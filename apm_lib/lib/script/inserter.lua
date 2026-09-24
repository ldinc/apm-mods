require("lib.features")
local dllist          = require("lib.containers.dllist")
---@diagnostic disable-next-line: different-requires
local strings         = require("lib.containers.strings")

local inserter_script = {}

local scratch_leech   = { name = "", count = 0, quality = nil }
local scratch_chain   = { name = "", count = 0, quality = nil }
local scratch_fuel    = { name = "", count = 1, quality = nil }
local ASH_NAME        = "apm_generic_ash"
local scratch_work    = { name = "", count = 0, quality = nil }

---@class QueueItem
---@field id integer
---@field entity LuaEntity
---@field fuel_inventory LuaInventory?
---@field bulk boolean?
---@field err integer
---@field ash_last_check_tick integer?

function inserter_script.alloc_defenitions()
	if not storage.inserters then storage.inserters = {} end

	-- a queue from before the packed-array rewrite (fields nodes/head) is replaced
	local q = storage.inserters.queue --[[@as table?]]
	if not q or q.values == nil or q.nodes ~= nil or q.head ~= nil then
		---@type DLL<integer, QueueItem>
		storage.inserters.queue = dllist.new()
	end

	if not storage.inserters.settings then
		storage.inserters.settings = {
			fn_enabled           = false,
			batch_size           = 15,
			valid_targets        = {},
			valid_targets_string = {},
			ash_chaining         = true,
			ash_size             = 100,
		}
	end

	-- Per-force bonus cache. Keyed by force.index.
	-- Populated lazily in calc_item_count and refreshed by force events.
	if not storage.inserters.force_bonus then
		---@type table<integer, { stack: integer, bulk: integer }>
		storage.inserters.force_bonus = {}
	end
end

--- Refresh the cached inserter bonuses for a single force.
--- Called from force-level events (research finished, force reset, etc.).
---@param force LuaForce
local function refresh_force_bonus(force)
	storage.inserters.force_bonus[force.index] = {
		stack = force.inserter_stack_size_bonus,
		bulk  = force.bulk_inserter_capacity_bonus,
	}
end

--- Read the cached bonuses for a force, populating the cache on first miss.
--- This is the hot-path accessor called from calc_item_count.
---@param force LuaForce
---@return integer stack_bonus
---@return integer bulk_bonus
local function get_force_bonus(force)
	local cache = storage.inserters.force_bonus
	local entry = cache[force.index]
	if not entry then
		entry = {
			stack = force.inserter_stack_size_bonus,
			bulk  = force.bulk_inserter_capacity_bonus,
		}
		cache[force.index] = entry
	end
	return entry.stack, entry.bulk
end

-- Function -------------------------------------------------------------------
-- check the state of the filter mode
-- return: true for withlist, return false for blacklist
-- ----------------------------------------------------------------------------

-- Scratch table for the precomputed filter decision. Reused across calls.
-- Fields:
--   names      : table<string, true> | nil   -- set of filter item names, nil if no slots
--   mode_allow : boolean                      -- true = whitelist, false = blacklist
-- The quality part of a filter is ignored: a filter matches every quality of its item.
local scratch_filter_state = { names = nil, mode_allow = true }

--- Build (or refresh) the filter decision for an inserter. Call once per
--- visit, then query with `filter_passes()`.
---
--- Allocates at most one table (`names`), and only when the inserter actually
--- has filter slots configured. The same `scratch_filter_state` is reused
--- every call; the caller must consume the result before the next call.
---@param entity LuaEntity
---@return table   -- the `scratch_filter_state` table, for chaining
local function build_filter_state(entity)
	local filter_slot_count = entity.filter_slot_count

	scratch_filter_state.mode_allow = (entity.inserter_filter_mode ~= "blacklist")

	if filter_slot_count == 0 then
		scratch_filter_state.names = nil

		return scratch_filter_state
	end

	-- Reuse the names table across calls instead of reallocating.
	local names = scratch_filter_state.names

	if names then
		for k in pairs(names) do names[k] = nil end
	else
		names = {}
		scratch_filter_state.names = names
	end

	for i = 1, filter_slot_count do
		local flt = entity.get_filter(i)

		if flt and flt.name then
			names[flt.name] = true
		end
	end

	return scratch_filter_state
end

--- Query the precomputed filter: does `item_name` pass this inserter's filter?
---@param item_name string
---@return boolean
local function filter_passes(item_name)
	local names = scratch_filter_state.names
	if not names then
		-- No filter slots configured -> everything passes.
		return true
	end
	local in_set = names[item_name] == true
	return in_set == scratch_filter_state.mode_allow
end

---@param want_pickup_item_count integer
---@param t_object QueueItem
---@return integer
local function calc_item_count(want_pickup_item_count, t_object)
	if want_pickup_item_count == 1 then return 1 end

	local entity = t_object.entity
	local stack_override = entity.inserter_stack_size_override

	local possible_stack_size
	if stack_override > 0 then
		possible_stack_size = stack_override
	else
		-- One `.force` read (unavoidable), then cached bonus lookup.
		local stack_bonus, bulk_bonus = get_force_bonus(entity.force --[[@as LuaForce]])
		possible_stack_size = 1 + (t_object.bulk and bulk_bonus or stack_bonus)
	end

	if want_pickup_item_count > possible_stack_size then
		return possible_stack_size
	end
	return want_pickup_item_count
end

---@param drop_target LuaEntity?
---@param item_stack ItemStackDefinition
---@return boolean
local function check_drop_target(drop_target, item_stack)
	if drop_target ~= nil then
		return drop_target.can_insert(item_stack)
	end

	--- [Trollface.png]
	return true -- we can always lay down an item on ground
end

--- Moves items from an inventory into the inserter's hand (leeching, fuel chaining,
--- burnt results). set_stack bypasses the inserter filters, so a filter inserter can pick
--- up fuel for itself.
--- Removes first and puts only what was really removed into the hand, with its quality;
--- anything that does not end up in the hand goes back. So no items are created, lost or
--- turned into normal quality.
--- The hand must be empty, or (allow_merge) hold the same item and quality, e.g. a bulk
--- inserter waiting at the pickup with a part stack of ash. item_stack.count is what is
--- added on top of the hand, the caller keeps it within the hand size.
---@param inserter LuaEntity
---@param inventory LuaInventory
---@param item_stack ItemStackDefinition
---@param allow_merge boolean?
---@return boolean
local function transfer_leeching(inserter, inventory, item_stack, allow_merge)
	if not item_stack.count or item_stack.count < 1 then
		return false
	end

	local name, quality = item_stack.name, item_stack.quality or "normal"
	local held_stack = inserter.held_stack
	local before = 0

	if held_stack.valid_for_read then
		if not allow_merge or held_stack.name ~= name or held_stack.quality.name ~= quality then
			return false
		end
		before = held_stack.count
	end

	local removed = inventory.remove(item_stack)
	if removed == 0 then
		return false
	end

	if before > 0 then
		held_stack.count = math.min(before + removed, held_stack.prototype.stack_size)
	else
		held_stack.set_stack({ name = name, quality = quality, count = removed })
	end

	local added = (held_stack.valid_for_read and held_stack.count or 0) - before

	if added < removed then
		inventory.insert({ name = name, quality = quality, count = removed - added })
	end

	return added > 0
end

---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
---@return LuaInventory?
local function get_a_fuel_inventory(pickup_target, drop_target)
	if pickup_target ~= nil then
		local pickup_inventory = pickup_target.get_fuel_inventory()

		if pickup_inventory ~= nil then
			return pickup_inventory
		end
	end
	if drop_target ~= nil then
		local drop_inventory = drop_target.get_fuel_inventory()

		return drop_inventory
	end

	return nil
end

--- item name -> list of its fuel categories. Built lazily from prototypes, which cannot
--- change during a session, so the cache does not affect determinism.
---@type table<string, string[]>
local item_fuel_categories_cache = {}

--- Factorio 2.1.20 replaced LuaItemPrototype::fuel_category with fuel_categories
--- (array[string], nil when the item is not a fuel). Reading the old key raises an
--- error, and reading the new one builds a fresh table on every call, so it is cached.
---@param item LuaItemPrototype
---@return string[]
local function get_item_fuel_categories(item)
	local cached = item_fuel_categories_cache[item.name]

	if cached then
		return cached
	end

	local list = item.fuel_categories or {}

	item_fuel_categories_cache[item.name] = list

	return list
end

---@param item LuaItemPrototype
---@param burner_categories table<string, boolean>
---@return boolean
local function item_fits_burner(item, burner_categories)
	for _, category in ipairs(get_item_fuel_categories(item)) do
		if burner_categories[category] then
			return true
		end
	end

	return false
end

--- Takes up to 5 fuel the inserter can burn from the target's fuel inventory,
--- leaving at least one item in the slot.
---@param entity LuaEntity
---@param target LuaEntity?
---@param burner_categories table<string, boolean>
---@return boolean
local function leech_from(entity, target, burner_categories)
	if not target or not target.valid then
		return false
	end

	local fuel_inventory = entity.get_fuel_inventory()

	if not fuel_inventory then
		return false
	end

	local target_inventory = target.get_fuel_inventory()

	if not target_inventory or target_inventory.is_empty() then
		return false
	end

	for i = 1, #target_inventory do
		local slot = target_inventory[i]

		if slot.valid_for_read and slot.count >= 2 and item_fits_burner(slot.prototype, burner_categories) then
			scratch_leech.name    = slot.name
			scratch_leech.count   = math.min(slot.count - 1, 5)
			scratch_leech.quality = slot.quality.name

			-- straight into the inserter's own fuel slot: an inserter without any energy
			-- cannot use fuel that is only in its hand
			local removed         = target_inventory.remove(scratch_leech)

			if removed == 0 then
				return false
			end

			scratch_leech.count = removed
			local inserted = fuel_inventory.insert(scratch_leech)

			if inserted < removed then
				scratch_leech.count = removed - inserted
				target_inventory.insert(scratch_leech)
			end

			return inserted > 0
		end
	end

	return false
end

--- can pickup 'fuel' for it self from pickup_target or drop_target
--- Only fuel of the inserter's own fuel categories (not e.g. nutrients or fuel cells).
---@param entity LuaEntity
---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
---@return boolean
local function burner_inserter_leech(entity, pickup_target, drop_target)
	local burner = entity.burner

	if not burner then
		return false
	end

	local burner_categories = burner.fuel_categories

	return leech_from(entity, pickup_target, burner_categories)
			or leech_from(entity, drop_target, burner_categories)
end

--- chain fuel from pickup_target to drop_target
---@param t_object QueueItem
---@param pickup_inventory LuaInventory
---@param drop_target LuaEntity
---@return boolean
local function inserter_chain_fuel(t_object, pickup_inventory, drop_target)
	if pickup_inventory.is_empty() then
		return false
	end

	-- only the first entry, as before; with its quality, else the normal-quality
	-- variant would be checked and moved
	local item = pickup_inventory.get_contents()[1]

	if not item then
		return false
	end

	scratch_chain.name    = item.name
	scratch_chain.quality = item.quality
	scratch_chain.count   = calc_item_count(item.count, t_object)

	if drop_target.can_insert(scratch_chain) then
		return transfer_leeching(t_object.entity, pickup_inventory, scratch_chain)
	end

	return false
end

---@param t_object QueueItem
---@param inventory LuaInventory?
---@return ItemStackDefinition?
local function inventory_get_fuel(t_object, inventory)
	if not inventory or not t_object.fuel_inventory then
		return nil
	end

	if inventory.is_empty() then
		return nil
	end

	local burner = t_object.entity.burner

	if not burner then
		return nil
	end

	local fuel_categories = burner.fuel_categories

	local contents = inventory.get_contents()

	for _, content in ipairs(contents) do
		local item = prototypes.item[content.name]
		if item and item_fits_burner(item, fuel_categories) then
			scratch_fuel.name    = item.name
			scratch_fuel.count   = 1
			scratch_fuel.quality = content.quality

			if inventory.remove(scratch_fuel) == 1 then
				return scratch_fuel
			end

			return nil
		end
	end

	return nil
end

---@param t_object QueueItem
---@param pickup_target LuaEntity?
local function steal_fuel_to_inserter(t_object, pickup_target)
	if not t_object or not pickup_target then return end

	-- The cached fuel_inventory exists iff the inserter is a burner,
	-- and it IS the burner's inventory — so we can skip reading
	-- `entity.burner` and `entity.burner.inventory` entirely.
	local fuel_inventory = t_object.fuel_inventory

	if not fuel_inventory then
		return
	end

	-- Try the pickup target's fuel inventory first (e.g. another burner machine),
	-- then its main chest inventory.
	local source = get_a_fuel_inventory(pickup_target)
	local fuel = inventory_get_fuel(t_object, source)

	if not fuel then
		source = pickup_target.get_inventory(defines.inventory.chest)
		fuel = inventory_get_fuel(t_object, source)
	end

	-- give the fuel back when the inserter can't take it (the slot it came from is free)
	if fuel and source and fuel_inventory.insert(fuel) == 0 then
		source.insert(fuel)
	end
end

---@param from LuaEntity?
---@param to LuaEntity?
local function try_transfer_ash_from_to(from, to)
	if not from or not to or not from.valid or not to.valid then return end
	-- the ash item comes from apm_power; without it there is nothing to move
	if not prototypes.item[ASH_NAME] then return end

	local to_burner   = to.burner
	local from_burner = from.burner
	if not to_burner or not from_burner then return end
	if not to_burner.fuel_categories["chemical"] then return end

	local to_brr   = to_burner.burnt_result_inventory
	local from_brr = from_burner.burnt_result_inventory
	if not to_brr or not from_brr then return end
	if to_brr.is_full() then return end

	-- The ash moves on as soon as there is a batch of it (ash_size, 10% of the ash stack),
	-- not only when the source slot is full: a machine that stopped for another reason
	-- (e.g. its output is full) never fills its burnt-result slot, so its ash was never passed on.
	local batch     = storage.inserters.settings.ash_size
	local from_full = from_brr.is_full()

	-- Move only ash that is really in the source (per quality): remove first, then insert,
	-- and give back what did not fit. Never calls remove/insert with count 0
	-- ("count must be positive") and never creates ash from nothing.
	for _, content in pairs(from_brr.get_contents()) do
		if content.name == ASH_NAME and (content.count >= batch or from_full) then
			local item = { name = ASH_NAME, quality = content.quality }
			local room = to_brr.get_insertable_count(item)
			if room >= batch then
				local count = math.min(content.count, room, apm.lib.features.stack_size.ash)
				if count > 0 then
					local removed = from_brr.remove({ name = ASH_NAME, quality = content.quality, count = count })
					if removed > 0 then
						local added = to_brr.insert({ name = ASH_NAME, quality = content.quality, count = removed })
						if added < removed then
							from_brr.insert({ name = ASH_NAME, quality = content.quality, count = removed - added })
						end
					end
				end
			end
		end
	end
end

---@param tick integer
---@param t_object QueueItem
---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
local function try_transfer_ash(tick, t_object, pickup_target, drop_target)
	if not storage.inserters.settings.ash_chaining or storage.inserters.settings.ash_size == 0 then
		return
	end

	-- if t_object.entity.status == defines.entity_status.full_burnt_result_output then
	-- 	-- TODO: check if can drop ash to storage or belt, or land
	-- end


	--- check does drop target valid
	if not drop_target or not drop_target.burner then return end

	if
			t_object.ash_last_check_tick
			and
			(tick - t_object.ash_last_check_tick < 1000)
	then
		return
	end

	t_object.ash_last_check_tick = tick

	try_transfer_ash_from_to(pickup_target, drop_target)
	try_transfer_ash_from_to(t_object.entity, drop_target)
end

--- This function made it possible that a inserter can handle the 'burnt_result_inventory' on all machiens.
--- That burner inserter can also leech fuel from drop target.
--- That burner inserters are capable to chain fuel through all burner machines
---@param tick integer
---@param t_object QueueItem
---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
---@param at_pickup boolean? the hand is at the pickup position
local function inserter_work(tick, t_object, pickup_target, drop_target, at_pickup)
	local entity = t_object.entity

	-- Fuel leeching --------------------------------------------------------
	if entity.status == defines.entity_status.no_fuel then
		steal_fuel_to_inserter(t_object, pickup_target)
	end

	try_transfer_ash(tick, t_object, pickup_target, drop_target)

	if t_object.fuel_inventory and t_object.fuel_inventory.get_item_count() <= 0 then
		if burner_inserter_leech(entity, pickup_target, drop_target) then
			return
		end
	end

	-- the rest moves items into the hand: only while the hand is at the pickup
	if not pickup_target or not at_pickup then return end

	-- Fuel chain -----------------------------------------------------------
	if drop_target then
		local pickup_inventory = pickup_target.get_fuel_inventory()
		if pickup_inventory then
			local drop_inventory = drop_target.get_fuel_inventory()
			if drop_inventory
					and pickup_inventory.get_item_count() >= 5
					and drop_inventory.get_item_count() < 5
			then
				if inserter_chain_fuel(t_object, pickup_inventory, drop_target) then
					return
				end
			end
		end
	end

	-- Burnt-result clearing ------------------------------------------------
	local burnt_inv = pickup_target.get_burnt_result_inventory()
	if not burnt_inv or burnt_inv.is_empty() then return end

	-- Precompute the filter decision once for this inserter/tick
	-- (a blacklisted ash filter is covered by filter_passes too).
	build_filter_state(entity)

	-- only the first entry, as before
	local item = burnt_inv.get_contents()[1]

	if not item or item.count < 1 or not filter_passes(item.name) then
		return
	end

	-- a hand with the same item (bulk inserter filling up at the pickup) is topped up,
	-- a hand with anything else is left alone
	local held_stack = entity.held_stack
	local in_hand = 0
	if held_stack.valid_for_read then
		if held_stack.name ~= item.name or held_stack.quality.name ~= item.quality then return end
		in_hand = held_stack.count
	end

	local count = calc_item_count(item.count + in_hand, t_object) - in_hand
	if count < 1 then return end

	scratch_work.name    = item.name
	scratch_work.count   = count
	scratch_work.quality = item.quality

	-- vanilla takes burnt results out only to chests, belts and the ground; this also
	-- feeds them into the next machine of a chain when that machine accepts them
	if check_drop_target(drop_target, scratch_work) then
		transfer_leeching(entity, burnt_inv, scratch_work, true)
	end
end

--- golbal.insert{entity, has_fuel_inventory, has_filter_slots}
--- to store a reference of the fuel_inventory saves this script 0.1-0.13ms per 100 iterrations/tick
---@param inserter LuaEntity
local function add_inserter(inserter)
	local id = inserter.unit_number

	if id == nil then
		return
	end

	local _, exists = dllist.find(storage.inserters.queue, id)

	if not exists then
		local fuel_inventory = inserter.get_fuel_inventory()
		local bulk = inserter.prototype.bulk
		---@type QueueItem
		local item = { id = id, entity = inserter, fuel_inventory = fuel_inventory, bulk = bulk, err = 0 }

		dllist.add(storage.inserters.queue, item)
	end
end

---@param entity LuaEntity
---@return boolean
local function entity_condition(entity)
	if storage.inserters.settings.valid_targets[entity.type] then
		local burner_inventory = entity.get_fuel_inventory()

		if
				burner_inventory
				and
				entity.burner
				and
				entity.burner.fuel_categories["chemical"]
		then -- this will only catch entities with a burner NOT fluids (thats good)
			return true
		end
	end

	return false
end

---@param entity LuaEntity
---@return boolean
local function inserter_condition(entity)
	local position = entity.position
	local surface = entity.surface
	local area = { { position.x - 6, position.y - 6 }, { position.x + 6, position.y + 6 } }
	local filter = {
		type = storage.inserters.settings.valid_targets_string,
		area = area,
	}
	local possible_entities = surface.find_entities_filtered(filter)

	for _, possible_entity in pairs(possible_entities) do
		if entity_condition(possible_entity) then
			return true
		end
	end

	return false
end

---@param entity LuaEntity
---@return LuaEntity[]
local function scan_area_for_inserter(entity)
	local position = entity.position
	local surface = entity.surface
	local area = { { position.x - 6, position.y - 6 }, { position.x + 6, position.y + 6 } }

	return surface.find_entities_filtered { type = "inserter", area = area }
end

local function get_config()
	apm.lib.features.runtime.update()

	storage.inserters.settings.fn_enabled           =
			apm.lib.features.runtime.get_boolean("apm_lib_inserter_functions")
	storage.inserters.settings.batch_size           =
			apm.lib.features.runtime.get_integer("apm_lib_inserter_iterations_01759")

	local valid_targets_string                      =
			apm.lib.features.runtime.get_string("apm_lib_inserter_valid_targets")

	local dict, list                                = strings.split_by_pattern_to_dict(valid_targets_string, ",")

	storage.inserters.settings.valid_targets        = dict
	storage.inserters.settings.valid_targets_string = list

	storage.inserters.settings.ash_chaining         =
			apm.lib.features.runtime.get_boolean("apm_lib_inserter_ash_chaining")

	if apm.lib.features.stack_size.ash > 0 then
		storage.inserters.settings.ash_size = math.ceil(apm.lib.features.stack_size.ash / 10)
	else
		storage.inserters.settings.ash_size = 0
	end
end

---@param reset boolean
---@param loading boolean
local function setup_environment(reset, loading)
	if reset then
		inserter_script.alloc_defenitions()

		dllist.reset(storage.inserters.queue)
	end
end

local function rescan()
	log("-- rescan() -----------------------------------------------------")
	log("this can take a secound or two...")

	setup_environment(true, false)

	local old = dllist.length(storage.inserters.queue)

	for _, surface in pairs(game.surfaces) do
		local inserters = surface.find_entities_filtered({ type = "inserter" })

		for _, inserter in pairs(inserters) do
			if inserter_condition(inserter) then
				add_inserter(inserter)
			end
		end
	end

	local new = dllist.length(storage.inserters.queue)

	log("rescanned amount of inserters: " .. tostring(old) .. " -> " .. tostring(new))
	log("-----------------------------------------------------------------")
end

-- Function -------------------------------------------------------------------
-- return t_object{entity, fuel_inventory} or nil
--
-- ----------------------------------------------------------------------------

--- It seems to be fn for trying remove entity with err >= 3
---@param t_object QueueItem
local function remove_inserter(t_object)
	if t_object.err >= 3 then
		dllist.remove(storage.inserters.queue, t_object.id)
	else
		t_object.err = t_object.err + 1
	end
end

-- Function -------------------------------------------------------------------
-- return t_object{entity, fuel_inventory} or nil
--
-- ----------------------------------------------------------------------------

---@return QueueItem?, LuaEntity?, LuaEntity?, boolean?
local function get_next_inserter()
	local t_object, _ = dllist.get_next_loop(storage.inserters.queue)

	if not t_object then return nil end

	local entity = t_object.entity
	if not entity or not entity.valid then
		remove_inserter(t_object)
		return nil
	end

	-- Read each position table exactly once.
	local pickup_pos = entity.pickup_position
	local held_pos   = entity.held_stack_position
	local dx         = pickup_pos.x - held_pos.x
	local dy         = pickup_pos.y - held_pos.y

	local at_pickup  = not (dx > 0.01 or dx < -0.01 or dy > 0.01 or dy < -0.01)

	-- A hand that is not at the pickup is left alone, except for refuelling: a burner inserter
	-- without fuel may be stuck anywhere (no energy to move its hand back).
	if not at_pickup then
		local fuel_inventory = t_object.fuel_inventory

		if entity.status ~= defines.entity_status.no_fuel and not (fuel_inventory and fuel_inventory.is_empty()) then
			return nil
		end
	end

	local pickup_target = entity.pickup_target
	local drop_target   = entity.drop_target

	if not pickup_target and not drop_target then
		remove_inserter(t_object)
		return nil
	end

	local valid_targets = storage.inserters.settings.valid_targets
	if pickup_target and not valid_targets[pickup_target.type] then
		if drop_target and not valid_targets[drop_target.type] then
			if drop_target.type ~= "inserter" then
				remove_inserter(t_object)
			end
			return nil
		end
	end

	t_object.err = 0

	return t_object, pickup_target, drop_target, at_pickup
end

-- Remote Function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function remote_inserter_global_size()
	if
			not storage.inserters or
			not storage.inserters.queue
	then
		return nil
	end

	return dllist.length(storage.inserters.queue)
end

-- Remote Function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@return integer
local function remote_inserter_global_ids()
	return dllist.length(storage.inserters.queue)
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@param player LuaPlayer
local function command_inserter_global_size(player)
	local msg = {
		"", "Inserter:" ..
	"\ntotal inserters: " .. tostring(dllist.length(storage.inserters.queue)) ..
	"\nsettings: " .. tostring(serpent.block(storage.inserters.settings))
	}
	player.print(msg)
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@param player LuaPlayer
local function command_inserter_rescan(player)
	if not player.admin then
		player.print({ "", "Only admins can use this command." })

		return
	end

	rescan()
	player.print({ "", "All inserters rescanned." })
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------


---@param event CustomCommandData
local function command_inserter(event)
	local player = game.players[event.player_index]
	local parameter = event.parameter

	if parameter == "info" then
		command_inserter_global_size(player)
	elseif parameter == "rescan" then
		command_inserter_rescan(player)
	end
end

-- Command Interface ----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_commands()
	commands.add_command("inserter", { "apm_cmd_description_inserter_info" }, command_inserter)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_init()
	inserter_script.alloc_defenitions()
	get_config()
	register_commands()

	for _, force in pairs(game.forces) do
		refresh_force_bonus(force)
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_load()
	-- inserter_script.alloc_defenitions()
	-- get_config()
	register_commands()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_update()
	inserter_script.alloc_defenitions()
	get_config()
	rescan()

	-- technologies (and their bonuses) can change with a mod update
	for _, force in pairs(game.forces) do
		refresh_force_bonus(force)
	end
end

---@param src_entity LuaEntity
---@param dest_entity LuaEntity
function inserter_script.on_entity_cloned(src_entity, dest_entity)
	if src_entity.valid == false then return end
	if dest_entity.valid == false then return end


	if (src_entity.type == "inserter") and (src_entity.unit_number ~= nil) then
		local _, src_entity_is_tracked = dllist.find(storage.inserters.queue, src_entity.unit_number)

		if src_entity_is_tracked then
			add_inserter(dest_entity)
		end
	end
end

---@param entity LuaEntity
local function burner_fuel_leech_on_build(entity)
	local valid_targets = storage.inserters.settings.valid_targets
	local pickup_target = entity.pickup_target
	local drop_target   = entity.drop_target

	if pickup_target and not valid_targets[pickup_target.type] then
		pickup_target = nil
	end

	if drop_target and not valid_targets[drop_target.type] then
		drop_target = nil
	end

	burner_inserter_leech(entity, pickup_target, drop_target)
end

---@param entity LuaEntity
function inserter_script.on_build(entity)
	if entity.valid == false then return end

	if entity.type == "inserter" then
		if entity.get_fuel_inventory() then
			burner_fuel_leech_on_build(entity)
		end

		if inserter_condition(entity) then
			add_inserter(entity)
		end
	elseif entity_condition(entity) then
		local inserters = scan_area_for_inserter(entity)

		for _, inserter in pairs(inserters) do
			add_inserter(inserter)
		end
	end
end

---@param entity LuaEntity
function inserter_script.on_destroy_entity(entity)
	if (entity.valid == false) or (not entity.unit_number) then
		return
	end

	if entity.type == "inserter" then
		dllist.remove(storage.inserters.queue, entity.unit_number)
	end
end

---@param entity LuaEntity
local function check_entity(entity)
	if entity.valid == false or entity.unit_number == nil then return end

	if (entity.type == "inserter") and (entity.unit_number ~= nil) then
		local _, tracked = dllist.find(storage.inserters.queue, entity.unit_number)

		if not tracked then
			if inserter_condition(entity) then
				add_inserter(entity)
			end
		end
	end
end

---@param entity LuaEntity
function inserter_script.on_rotate(entity)
	check_entity(entity)
end

---@param entity LuaEntity
function inserter_script.on_entity_settings_pasted(entity)
	check_entity(entity)
end

---@param tick  integer
function inserter_script.on_tick(tick)
	local inserter_size = dllist.length(storage.inserters.queue)
	local feature_enabled = storage.inserters.settings.fn_enabled

	if inserter_size == 0 or not feature_enabled then
		return
	end

	-- never more than the queue holds: a small queue would process the same inserters twice per tick
	for _ = 1, math.min(storage.inserters.settings.batch_size, inserter_size), 1 do
		local t_object, pickup_target, drop_target, at_pickup = get_next_inserter()

		if t_object then
			inserter_work(tick, t_object, pickup_target, drop_target, at_pickup)
		end
	end
end

-- Remote Interface -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- /c game.player.print(remote.call('apm_inserter', 'count_inserter'))
-- /c game.player.print(remote.call('apm_inserter', 'count_ids'))
-- /c remote.call('apm_inserter', 'rescan')

remote.add_interface("apm_inserter", {
	count_inserter = function() return remote_inserter_global_size() end,
	count_ids = function() return remote_inserter_global_ids() end,
	rescan = function() return rescan() end,
	-- For the tips-and-tricks simulations: a simulation's script cannot change its map
	-- settings. The next settings change or configuration change replaces the value again.
	set_enabled = function(value)
		inserter_script.alloc_defenitions()
		storage.inserters.settings.fn_enabled = value and true or false
	end,
	is_enabled = function()
		return storage.inserters ~= nil and storage.inserters.settings ~= nil and
		storage.inserters.settings.fn_enabled == true
	end,
})

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function Event_changed_inserter_positions(event)
	if not event then return end

	local inserter = event.entity
	if not inserter then return end

	check_entity(inserter)
end

-- Hook to mod events ---------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.register_to_mod_events()
	if remote.interfaces.bobinserters then
		script.on_event(remote.call("bobinserters", "get_changed_position_event_id"),
			function(event) Event_changed_inserter_positions(event) end)
		log('Info: inserter.register_to_mod_events(): register events for "bobinserters"')
	elseif remote.interfaces.boblogistics then
		script.on_event(remote.call("boblogistics", "get_changed_position_event_id"),
			function(event) Event_changed_inserter_positions(event) end)
		log('Info: inserter.register_to_mod_events(): register events for "boblogistics"')
	end
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
inserter_script.refresh_force_bonus = refresh_force_bonus

return inserter_script
