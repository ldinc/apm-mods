require("lib.features")
local dllist = require("lib.containers.dllist")

local inserter_script = {}


---@class QueueItem
---@field id integer
---@field entity LuaEntity
---@field fuel_inventory LuaInventory?
---@field bulk boolean?
---@field err integer

-- Helper function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function split(str, pat)
	str = string.gsub(str, "%s+", "")

	local t = {}
	local fpat = "(.-)" .. pat
	local last_end = 1
	local s, e, cap = str:find(fpat, 1)

	while s do
		if s ~= 1 or cap ~= "" then
			table.insert(t, cap)
		end
		last_end = e + 1
		s, e, cap = str:find(fpat, last_end)
	end

	if last_end <= #str then
		cap = str:sub(last_end)
		table.insert(t, cap)
	end

	return t
end

---@param str string
---@return table<string, boolean>, string[]
local function split_to_dict(str)
	local list = split(str, ",")

	local dict = {}

	for _, key in ipairs(list) do
		dict[key] = true
	end

	return dict, list
end

-- Helper function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local function tablelength(T)
-- 	local count = 0
-- 	for _ in pairs(T) do count = count + 1 end

-- 	return count
-- end

-- Local ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

-- local inserter_table = {}
-- local inserter_size = 0

function inserter_script.alloc_defenitions()
	if not storage.apm then storage.apm = {} end
	if not storage.apm.lib then storage.apm.lib = {} end
	if not storage.apm.lib.inserters then storage.apm.lib.inserters = {} end

	if not storage.apm.lib.inserters.queue then
		---@type DLL<integer, QueueItem>
		storage.apm.lib.inserters.queue = dllist.new()
	end

	if not storage.apm.lib.inserters.settings then
		---@type {fn_enabled: boolean, batch_size: integer, valid_targets: table<string, boolean>, valid_targets_string: string[]}
		storage.apm.lib.inserters.settings = {
			fn_enabled = false,
			batch_size = 15,
			valid_targets = {},
			valid_targets_string = {},
		}
	end
end

-- Function -------------------------------------------------------------------
-- check the state of the filter mode
-- return: true for withlist, return false for blacklist
-- ----------------------------------------------------------------------------

---@param entity LuaEntity
local function get_filter_mode(entity)
	if entity.inserter_filter_mode == 'blacklist' then
		return false
	end

	return true
end

--- This function checks filter state
---@param entity LuaEntity
---@param item_name string
local function check_filter(entity, item_name)
	local filter_slot_count = entity.filter_slot_count

	if filter_slot_count == 0 then
		return true
	end

	local return_value = get_filter_mode(entity)

	for i = 1, filter_slot_count do
		if entity.get_filter(i) == item_name then
			return return_value
		end
	end

	return not return_value
end

---@param want_pickup_item_count integer
---@param t_object QueueItem
---@return integer
local function calc_item_count(want_pickup_item_count, t_object)
	if want_pickup_item_count == 1 then return 1 end

	local inserter_stack_bonus = 0
	if t_object.bulk then
		-- is stack inserter
		inserter_stack_bonus = t_object.entity.force.bulk_inserter_capacity_bonus
	else
		-- is normal inserter
		inserter_stack_bonus = t_object.entity.force.inserter_stack_size_bonus
	end

	local possible_stack_size = 1 + inserter_stack_bonus
	local stack_size_override = t_object.entity.inserter_stack_size_override

	if stack_size_override > 0 then
		possible_stack_size = stack_size_override
	end

	if want_pickup_item_count > possible_stack_size then
		-- pickup target more items then the possible stack size
		want_pickup_item_count = possible_stack_size

		return want_pickup_item_count
	end

	return want_pickup_item_count
end

---@param drop_target LuaEntity
---@param item_stack ItemStackDefinition
---@return boolean
local function check_drop_target(drop_target, item_stack)
	if drop_target ~= nil then
		return drop_target.can_insert(item_stack)
	end

	return true -- we can always lay down an item on ground
end

--- transfer the item stack on leeching or fuel chaining
--- it decisions which method we need (filter inserter need a bypass methode, otherwise he can not pickup fuel for them self)
---@param inserter LuaEntity
---@param inventory LuaInventory
---@param item_stack ItemStackDefinition
---@return boolean
local function transfer_leeching(inserter, inventory, item_stack)
	local held_stack = inserter.held_stack
	if not held_stack.valid_for_read then
		if inserter.filter_slot_count == 0 then
			if held_stack.transfer_stack(item_stack) then
				inventory.remove(item_stack)

				return true
			end
		else
			held_stack.set_stack(item_stack)
			inventory.remove(item_stack)

			return true
		end
	end

	return false
end

---@param pickup_target LuaEntity
---@param drop_target LuaEntity
---@return LuaInventory?
local function get_a_fuel_inventory(pickup_target, drop_target)
	if pickup_target ~= nil then
		local pickup_inventory = pickup_target.get_fuel_inventory()
		--local pickup_inventory = my_get_fuel_inventory(pickup_target)
		if pickup_inventory ~= nil then
			return pickup_inventory
		end
	end
	if drop_target ~= nil then
		local drop_inventory = drop_target.get_fuel_inventory()
		--local drop_inventory = my_get_fuel_inventory(drop_target)

		return drop_inventory
	end

	return nil
end

--- can pickup 'fuel' for it self from pickup_target or drop_target
---@param entity LuaEntity
---@param pickup_target LuaEntity
---@param drop_target LuaEntity
---@return boolean
local function burner_inserter_leech(entity, pickup_target, drop_target)
	local target_inventory = get_a_fuel_inventory(pickup_target, drop_target)
	if not target_inventory then return false end


	local target_inventory_contents = target_inventory.get_contents()

	for _, item in ipairs(target_inventory_contents) do
		if item.count >= 2 then
			local stack_size = math.min(item.count - 1, 5)
			local item_stack = { name = item.name, count = stack_size }

			return transfer_leeching(entity, target_inventory, item_stack)
		end

		return false
	end
end

--- chain fuel from pickup_target to drop_target
---@param t_object QueueItem
---@param pickup_inventory LuaInventory
---@param drop_target LuaEntity
---@return boolean
local function inserter_chain_fuel(t_object, pickup_inventory, drop_target)
	local pickup_inventory_contents = pickup_inventory.get_contents()

	for _, item in ipairs(pickup_inventory_contents) do
		local stack_size = calc_item_count((item.count), t_object)
		local item_stack = { name = item.name, count = stack_size }

		if drop_target.can_insert(item_stack) then
			return transfer_leeching(t_object.entity, pickup_inventory, item_stack)
		end

		return false
	end
end

--- This function made it possible that a inserter can handle the 'burnt_result_inventory' on all machiens.
--- That burner inserter can also leech fuel from drop target.
--- That burner inserters are capable to chain fuel through all burner machines
---@param t_object QueueItem
---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
local function inserter_work(t_object, pickup_target, drop_target)
	-- -------------------------------------------------------------------------------------
	-- This part is for the fuel leeching
	-- -------------------------------------------------------------------------------------
	if t_object.fuel_inventory and t_object.fuel_inventory.get_item_count() <= 0 then
		if burner_inserter_leech(t_object.entity, pickup_target, drop_target) then
			return
		end
	end

	-- we can simply return here if there is no pickup_target
	if not pickup_target then return end

	-- -------------------------------------------------------------------------------------
	-- This part is for the fuel chain
	-- -------------------------------------------------------------------------------------
	if drop_target and pickup_target then
		local pickup_inventory = pickup_target.get_fuel_inventory()
		--local pickup_inventory = my_get_fuel_inventory(pickup_target)

		if pickup_inventory then
			local drop_inventory = drop_target.get_fuel_inventory()
			--local drop_inventory = my_get_fuel_inventory(drop_target)

			if drop_inventory then
				if pickup_inventory.get_item_count() >= 5 then
					if drop_inventory.get_item_count() < 5 then
						if inserter_chain_fuel(t_object, pickup_inventory, drop_target) then
							return
						end
					end
				end
			end
		end
	end

	-- -------------------------------------------------------------------------------------
	-- This part is for clearing the burned fuel inventory
	-- -------------------------------------------------------------------------------------

	local pickup_target_burnt_result_inventory = pickup_target.get_burnt_result_inventory()
	--local pickup_target_burnt_result_inventory = my_get_burnt_result_inventory(pickup_target)

	if not pickup_target_burnt_result_inventory then
		return
	end

	if pickup_target_burnt_result_inventory.is_empty() then
		return
	end


	local pickup_target_inventory_contents = pickup_target_burnt_result_inventory.get_contents()

	local entity = t_object.entity

	local blacklisted = {}

	-- ignore ash if it was blacklisted
	if entity.inserter_filter_mode then
		local count = entity.filter_slot_count

		for i = 1, count, 1 do
			local flt = entity.get_filter(i)

			if flt and entity.inserter_filter_mode == "blacklist" and flt.comparator == "=" and flt.name == "apm_generic_ash" then
				blacklisted[flt.name] = true
			end
		end
	end

	for _, item in ipairs(pickup_target_inventory_contents) do
		if item.count >= 1 and check_filter(t_object.entity, item.name) then
			local stack_size = calc_item_count(item.count, t_object)
			local item_stack = { name = item.name, count = stack_size }

			if check_drop_target(drop_target, item_stack) then
				if not blacklisted[item.name] and t_object.entity.held_stack.transfer_stack(item_stack) then
					pickup_target_burnt_result_inventory.remove(item_stack)
				end
			end
		end

		return
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

	local _, exists = dllist.find(storage.apm.lib.inserters.queue, id)

	if not exists then
		local fuel_inventory = inserter.get_fuel_inventory()
		local bulk = inserter.prototype.bulk
		---@type QueueItem
		local item = { id = id, entity = inserter, fuel_inventory = fuel_inventory, bulk = bulk, err = 0 }

		dllist.add(storage.apm.lib.inserters.queue, id, item)
	end
end

---@param entity LuaEntity
---@return boolean
local function entity_condition(entity)
	if storage.apm.lib.inserters.settings.valid_targets[entity.type] then
		if entity.get_fuel_inventory() then -- this will only catch entities with a burner NOT fluids (thats good)
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
		type = storage.apm.lib.inserters.settings.valid_targets_string,
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
	local inserters = surface.find_entities_filtered { type = "inserter", area = area }

	return inserters
end

local function get_config()
	apm.lib.features.runtime.update()

	storage.apm.lib.inserters.settings.fn_enabled           =
			apm.lib.features.runtime.get_boolean("apm_lib_inserter_functions")
	storage.apm.lib.inserters.settings.batch_size           =
			apm.lib.features.runtime.get_integer("apm_lib_inserter_iterations_01759")

	local valid_targets_string                              =
			apm.lib.features.runtime.get_string("apm_lib_inserter_valid_targets")

	local dict, list                                        = split_to_dict(valid_targets_string)

	storage.apm.lib.inserters.settings.valid_targets        = dict
	storage.apm.lib.inserters.settings.valid_targets_string = list
end

---@param reset boolean
---@param loading boolean
local function setup_environment(reset, loading)
	if reset then
		inserter_script.alloc_defenitions()

		dllist.reset(storage.apm.lib.inserters.queue)
	end


	--- old one code
	-- if not loading and (not storage.inserter_01746 or reset) then
	-- 	storage.inserter_01746 = {}
	-- 	storage.inserter_01746_ids = {}
	-- 	storage.inserter_01746_index = 1
	-- end

	-- inserter_table = storage.inserter_01746
	-- inserter_size = #storage.inserter_01746

	-- if loading and inserter_size then
	-- 	log('-- setup_environment() ----------------------------------------------')
	-- 	log('Info: inserters: "' .. tostring(inserter_size) .. '" from globale table loaded')
	-- 	log('--------------------------------------------------------------------')
	-- end
end

local function rescan()
	log('-- rescan() -----------------------------------------------------')
	log('this can take a secound or two...')

	setup_environment(true, false)

	for _, surface in pairs(game.surfaces) do
		local inserters = surface.find_entities_filtered({ type = 'inserter' })

		for _, inserter in pairs(inserters) do
			if inserter_condition(inserter) then
				add_inserter(inserter)
			end
		end
	end

	-- log('rescanned amount of inserters: ' .. tostring(#inserter_table))
	log('-----------------------------------------------------------------')
end

-- Function -------------------------------------------------------------------
-- return t_object{entity, fuel_inventory} or nil
--
-- ----------------------------------------------------------------------------

--- It seems to be fn for trying remove entity with err >= 3
---@param t_object QueueItem
local function remove_inserter(t_object)
	if t_object.err >= 3 then
		dllist.remove(storage.apm.lib.inserters.queue, t_object.id)
	else
		t_object.err = t_object.err + 1
	end
end

-- Function -------------------------------------------------------------------
-- return t_object{entity, fuel_inventory} or nil
--
-- ----------------------------------------------------------------------------

---@return QueueItem?, LuaEntity?, LuaEntity?
local function get_next_inserter()
	local t_object = dllist.get_next_loop(storage.apm.lib.inserters.queue)

	if not t_object then
		return nil
	end

	if not t_object.entity or not t_object.entity.valid then
		remove_inserter(t_object)

		return nil
	end

	-- --------------------------------------------------------------
	-- if the inserter hand is not in place, we don't need to check anything.
	local px = t_object.entity.pickup_position.x
	local hx = t_object.entity.held_stack_position.x
	local py = t_object.entity.pickup_position.y
	local hy = t_object.entity.held_stack_position.y

	-- if (px ~= hx) or  (py ~= hy) then <- this is not bobinserters proofed only x*90° have exact pickup_position == held_stack_position
	if (px > hx + 0.01 or px < hx - 0.01) or (py > hy + 0.01 or py < hy - 0.01) then
		return nil
	end
	-- --------------------------------------------------------------

	-- --------------------------------------------------------------
	-- debug lines for positions
	-- local entity = t_object.entity
	-- game.print('Positions:' .. '\npx: ' ..tostring(entity.pickup_position.x).. '\nhx: ' ..tostring(entity.held_stack_position.x).. '\npy: ' ..tostring(entity.pickup_position.y).. '\nhy: ' ..tostring(entity.held_stack_position.y))
	-- --------------------------------------------------------------

	-- if t_object.entity.held_stack.valid_for_read then return end <- that call is fucking expensive, we won't do it!
	-- --------------------------------------------------------------

	local pickup_target = t_object.entity.pickup_target
	local drop_target = t_object.entity.drop_target

	if not pickup_target and not drop_target then
		remove_inserter(t_object)

		return nil
	end

	if pickup_target and not storage.apm.lib.inserters.settings.valid_targets[pickup_target.type] then
		if drop_target and not storage.apm.lib.inserters.settings.valid_targets[drop_target.type] then
			-- This condition for drop_target ~= 'inserter' is a workaround:
			-- Because if this script fires in a situation were the inserter is feeding himself from a belt,
			-- the drop_target in this exact moment is the inserter himself and will be otherwise removed from the table.
			if drop_target.type ~= 'inserter' then
				remove_inserter(t_object)
			end

			return nil
		end
	end

	t_object.err = 0

	return t_object, pickup_target, drop_target
end

-- Remote Function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function remote_inserter_global_size()
	if
			not storage.apm or
			not storage.apm.lib or
			not storage.apm.lib.inserters or
			not storage.apm.lib.inserters.queue
	then
		return nil
	end

	return dllist.length(storage.apm.lib.inserters.queue)
end

-- Remote Function ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function remote_inserter_global_ids()
	-- if not storage.inserter_01746_ids then return nil end
	-- return tablelength(storage.inserter_01746_ids)
	return nil
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@param player LuaPlayer
local function command_inserter_global_size(player)
	local msg = { '', 'Inserter:' ..
	'\ndb: ' .. tostring(remote_inserter_global_size() .. '\nunique ids: ' .. tostring(remote_inserter_global_ids())) }
	player.print(msg)

	player.print(serpent.block(storage.apm.lib.inserters.queue))
	player.print(serpent.block(storage.apm.lib.inserters.settings))
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@param player LuaPlayer
local function command_inserter_rescan(player)
	if not player.admin then
		player.print({ '', 'Only admins can use this command.' })

		return
	end

	rescan()
	player.print({ '', 'All inserters rescanned.' })
end

-- Command Function -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------


---@param event CustomCommandData
local function command_inserter(event)
	local player = game.players[event.player_index]
	local parameter = event.parameter

	if parameter == 'info' then
		command_inserter_global_size(player)
	elseif parameter == 'rescan' then
		command_inserter_rescan(player)
	end
end

-- Command Interface ----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_commands()
	commands.add_command("inserter", { 'apm_cmd_description_inserter_info' }, command_inserter)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_init()
	inserter_script.alloc_defenitions()
	get_config()
	register_commands()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_load()
	inserter_script.alloc_defenitions()
	-- get_config()
	register_commands()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function inserter_script.on_update()
	log("JIB UPDATES")
	inserter_script.alloc_defenitions()
	get_config()
	rescan()
end

---@param src_entity LuaEntity
---@param dest_entity LuaEntity
function inserter_script.on_entity_cloned(src_entity, dest_entity)
	if src_entity.valid == false then return end
	if dest_entity.valid == false then return end


	if (src_entity.type == "inserter") and (src_entity.unit_number ~= nil) then
		local _, src_entity_is_tracked = dllist.find(storage.apm.lib.inserters.queue, src_entity.unit_number)

		if src_entity_is_tracked then
			add_inserter(dest_entity)
		end
	end
end

---@param entity LuaEntity
local function burner_fuel_leech_on_build(entity)
	local surface = entity.surface
	local pickup_position = entity.pickup_position
	local drop_position = entity.drop_position

	local pickup_target
	local filter = {
		type = storage.apm.lib.inserters.settings.valid_targets_string,
		position = pickup_position,
	}

	for _, p_e in pairs(surface.find_entities_filtered(filter)) do
		pickup_target = p_e
	end

	local drop_target

	filter = {
		type = storage.apm.lib.inserters.settings.valid_targets_string,
		position = drop_position,
	}

	for _, p_e in pairs(surface.find_entities_filtered(filter)) do
		drop_target = p_e
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
local function check_entity(entity)
	if entity.valid == false or entity.unit_number == nil then return end

	if (entity.type == "inserter") and (entity.unit_number ~= nil) then
		local _, tracked = dllist.find(storage.apm.lib.inserters.queue, entity.unit_number)

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

-- local function next_inserter()


-- 	storage.apm.lib.inserters.index = storage.apm.lib.inserters.index + 1

-- 	if storage.apm.lib.inserters.index >= #storage.apm.lib.inserters.queue then
-- 		storage.apm.lib.inserters.index = 1
-- 	end
-- end

function inserter_script.on_tick()
	if storage.apm.lib.inserters.queue == nil then
		print()
	end

	local inserter_size = dllist.length(storage.apm.lib.inserters.queue)

	if inserter_size == 0 or not storage.apm.lib.inserters.settings.fn_enabled then
		return
	end

	local func_get = get_next_inserter
	local func_work = inserter_work

	for _ = 0, storage.apm.lib.inserters.settings.batch_size, 1 do
		local t_object, pickup_target, drop_target = func_get()

		if t_object then
			func_work(t_object, pickup_target, drop_target)
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
	rescan = function() return rescan() end
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
return inserter_script
