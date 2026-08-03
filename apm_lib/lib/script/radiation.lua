-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
require("lib.features")
local core = require("lib.script.core")


-- Definitions ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local radiation_script = {}

--- Schema version of storage.radiation. Bump this when the storage layout
--- changes and add a migration step in migrate_storage().
local STORAGE_VERSION = 1

--- Level -> letter used in the radioactive sound prototype names
--- (prototypes/sounds/radiation.lua).
local radiation_sound_paths = {
	[1] = "a",
	[2] = "b",
	[3] = "c",
}

--- Lua-side cache of the radioactive item list, sorted by level (desc) then
--- name. Not persisted; rebuilt lazily and invalidated on every list change.
---@type { name: string, level: integer }[]?
local sorted_items = nil

---@return { name: string, level: integer }[]
local function get_sorted_items()
	if sorted_items then
		return sorted_items
	end

	sorted_items = {}

	for item_name, level in pairs(storage.radiation.items) do
		table.insert(sorted_items, { name = item_name, level = level })
	end

	table.sort(sorted_items, function(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		end

		return a.name < b.name
	end)

	return sorted_items
end

local function invalidate_sorted_items()
	sorted_items = nil
end

function radiation_script.alloc_definitions()
	if not storage.radiation then storage.radiation = {} end

	if storage.radiation.apm_nuclear_radiation == nil then
		storage.radiation.apm_nuclear_radiation = true
	end

	if storage.radiation.radiation_dmg_multiplier == nil then
		storage.radiation.radiation_dmg_multiplier = 1.0
	end

	if storage.radiation.radiation_dmg_based_on_stack == nil then
		storage.radiation.radiation_dmg_based_on_stack = false
	end

	if storage.radiation.checked_item_list == nil then
		storage.radiation.checked_item_list = false
	end
end

--- Migrates the radiation storage layout to STORAGE_VERSION.
--- Called from on_init and on_update (on_configuration_changed).
local function migrate_storage()
	---@type uint64
	local version = storage.radiation.version or 0

	if version < 1 then
		-- v1: the item list moved from storage.items_radioactive_01774
		-- (and the even older storage.items_radioactive) into storage.radiation.items
		storage.radiation.items = {}

		local legacy = storage.items_radioactive_01774 or storage.items_radioactive

		if legacy then
			for item_name, level in pairs(legacy) do
				storage.radiation.items[item_name] = level
			end

			storage.items_radioactive_01774 = nil
			storage.items_radioactive = nil

			log("Info: radiation.migrate_storage(): migrated radioactive items to storage.radiation.items (v1)")
		end

		storage.radiation.version = 1
	end

	-- if version < 2 then ... end -- template for future migrations
end

--- Removes entries whose item prototype no longer exists.
local function validate_item_list()
	for item_name, _ in pairs(storage.radiation.items) do
		if not prototypes.item[item_name] then
			storage.radiation.items[item_name] = nil

			log(APM_MSG_ERROR(
				"radiation.validate_item_list",
				"Invalid radioactive item was removed [" .. tostring(item_name) .. "]"
			))
		end
	end

	invalidate_sorted_items()
end

local function get_config()
	apm.lib.features.runtime.update()

	storage.radiation.apm_nuclear_radiation        =
			apm.lib.features.runtime.get_boolean("apm_lib_radiation_dmg")

	storage.radiation.radiation_dmg_multiplier     =
			apm.lib.features.runtime.get_double("apm_lib_radiation_dmg_multiplier")

	storage.radiation.radiation_dmg_based_on_stack =
			apm.lib.features.runtime.get_boolean("apm_lib_radiation_dmg_based_on_stack")
end


---@param item_name string
---@param level integer?
---@return boolean
local function add_item(item_name, level)
	if not level then
		level = 2
	end

	local items = storage.radiation.items

	if items[item_name] == level then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"add_item()",
				'item: "' .. tostring(item_name) .. '" is already on the list.'
			))
		end

		return true
	end

	if not prototypes.item[item_name] then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				"add_item()",
				'item: "' .. tostring(item_name) .. '" does not exist.'
			))
		end

		return false
	end

	items[item_name] = level
	invalidate_sorted_items()

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"add_item()",
			'item: "' .. tostring(item_name) .. '" set to level: "' .. tostring(level) .. '"'
		))
	end

	return true
end

---@param item_name string
---@return boolean
local function remove_item(item_name)
	if not storage.radiation.items[item_name] then return false end

	storage.radiation.items[item_name] = nil
	invalidate_sorted_items()

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"remove_item()",
			'item: "' .. tostring(item_name) .. '" removed from the radioactive list.'
		))
	end

	return true
end

---@return table<string, integer>
local function list_items()
	return storage.radiation.items
end

local function generate_radioactive_table()
	add_item("uranium-235", 2)
	add_item("uranium-fuel-cell", 2)
	add_item("used-up-uranium-fuel-cell", 3)
end

function radiation_script.on_init()
	radiation_script.alloc_definitions()

	migrate_storage()
	get_config()
	generate_radioactive_table()
	validate_item_list()
end

function radiation_script.on_load()
	-- storage is not accessible in on_load; the sorted item cache is Lua-side
	-- and rebuilt lazily, so there is nothing to do here.
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function radiation_script.on_update()
	radiation_script.alloc_definitions()

	migrate_storage()
	get_config()
	generate_radioactive_table()
	validate_item_list()
end

---@param player LuaPlayer?
---@param character LuaEntity?
---@param item_name string
---@param count integer
local function damage_to_character_from_item(player, character, item_name, count)
	if not player or not character then return end

	local item_rtype = storage.radiation.items[item_name]
	local rnd_min = 2 ^ item_rtype
	local rnd_max = rnd_min * 2 * item_rtype
	local damage = math.random(rnd_min, rnd_max) * storage.radiation.radiation_dmg_multiplier

	if storage.radiation.radiation_dmg_based_on_stack and count then
		damage = damage * count
	end

	character.damage(damage, game.forces.neutral)

	---@type LocalisedString
	local msg = { "apm_msg_radiation_dmg", damage, item_name }

	core.send_dmg_msg_to_player(player, msg)
end

---@param character LuaEntity
---@param level integer
local function play_radiation_sound(character, level)
	if level < 1 then
		level = 1
	elseif level > 3 then
		level = 3
	end

	-- 2.1 SoundPath: the sound prototype name, raw file paths are not supported
	character.surface.play_sound({
		path = "radioactive_" .. radiation_sound_paths[level] .. "_" .. tostring(math.random(3)),
		position = character.position,
	})
end

---@param player LuaPlayer?
---@param character LuaEntity?
---@param cause_damage boolean
local function check_inventory(player, character, cause_damage)
	if not player or not character then return end
	if not character.get_main_inventory() then return end

	for _, entry in ipairs(get_sorted_items()) do
		local count = character.get_item_count({ name = entry.name })

		if count > 0 then
			play_radiation_sound(character, entry.level)

			if cause_damage == true then
				damage_to_character_from_item(player, character, entry.name, count)
			end

			if not storage.radiation.radiation_dmg_based_on_stack then
				break
			end

			if not character.valid then
				return
			end
		end
	end
end

-- Function -------------------------------------------------------------------
-- This check runs once every game start
--
-- ----------------------------------------------------------------------------
local function check_item_list()
	if not storage.radiation.checked_item_list then
		validate_item_list()

		storage.radiation.checked_item_list = true
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function radiation_script.on_tick()
	if not storage.radiation.apm_nuclear_radiation then return end

	check_item_list()

	if game.tick % 240 == 37 then
		local players = core.get_valid_players()

		if not players then return end

		for _, t_object in pairs(players) do
			check_inventory(t_object.player, t_object.character, true)
		end
		return
	end

	if game.tick % 60 == 37 then
		local players = core.get_valid_players()

		if not players then return end

		for _, t_object in pairs(players) do
			check_inventory(t_object.player, t_object.character, false)
		end
	end
end

-- Remote Interface ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- /c remote.call('apm_radiation', 'add_item', 'uranium-ore', 1)
-- /c remote.call('apm_radiation', 'remove_item', 'uranium-ore')
-- /c remote.call('apm_radiation', 'list_items')
remote.add_interface("apm_radiation", {
	add_item = function(item_name, level) return add_item(item_name, level) end,
	remove_item = function(item_name) return remove_item(item_name) end,
	list_items = function() return list_items() end,
})

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return radiation_script
