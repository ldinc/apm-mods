-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
require("lib.features")
local core = require("lib.script.core")
local sound = require("lib.script.sound")
require("lib.utils.prototypes")


-- Definitions ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local radiation_script = {}

function radiation_script.alloc_defenitions()
	if not storage.items_radioactive_01774 then
		storage.items_radioactive_01774 = {}
	end

	if not storage.radiation then storage.radiation = {} end

	if not storage.radiation.apm_nuclear_radiation then
		storage.radiation.apm_nuclear_radiation = true
	end

	if not storage.radiation.radiation_dmg_multiplier then
		storage.radiation.radiation_dmg_multiplier = 1.0
	end

	if not storage.radiation.radiation_dmg_based_on_stack then
		storage.radiation.radiation_dmg_based_on_stack = false
	end

	if not storage.radiation.checked_item_list then
		storage.radiation.checked_item_list = false
	end

	if not storage.items_radioactive_01774 then
		storage.items_radioactive_01774 = {}
	end
end

---@param t any
---@param order function(any, any, any) boolean
---@return function()
local function spairs(t, order)
	-- collect the keys
	local keys = {}

	for k in pairs(t) do keys[#keys + 1] = k end

	-- if order function given, sort by it by passing the table and keys a, b,
	-- otherwise just sort the keys
	if order then
		table.sort(keys, function(a, b) return order(t, a, b) end)
	else
		table.sort(keys)
	end

	-- return the iterator function
	local i = 0

	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
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

	if not storage.radiation then

	end

	if storage.items_radioactive_01774[item_name] then
		if storage.items_radioactive_01774[item_name] ~= level then
			storage.items_radioactive_01774[item_name] = level

			log('Info: add_item(): item: "' .. tostring(item_name) .. '" updated.')

			return true
		end

		log('Info: add_item(): item: "' .. tostring(item_name) .. '" is already on the list.')

		return true
	end

	if not storage.items_radioactive_01774[item_name] then
		if apm.lib.utils.prototypes.item.exists(item_name) then
			storage.items_radioactive_01774[item_name] = level

			log('Info: add_item(): add item: "' .. tostring(item_name) .. '" to the radioactive list.')

			return true
		end

		log('Warning: add_item(): item: "' .. tostring(item_name) .. '" does not exist.')

		return false
	end

	return false
end

---@param item_name string
---@return boolean
local function remove_item(item_name)
	if not storage.items_radioactive_01774 then return false end

	if not storage.items_radioactive_01774[item_name] then return false end

	storage.items_radioactive_01774[item_name] = nil

	log('Info: remove_item(): remove item: "' .. tostring(item_name) .. '" from the radioactive list.')

	return true
end

---@return table<string, any>?
local function list_items()
	if not storage.items_radioactive_01774 then return nil end

	return storage.items_radioactive_01774
end

local function generate_radioactive_table()
	add_item("uranium-235", 2)
	add_item("uranium-fuel-cell", 2)
	add_item("used-up-uranium-fuel-cell", 3)
end

function radiation_script.on_init()
	radiation_script.alloc_defenitions();

	get_config()
	generate_radioactive_table()
end

function radiation_script.on_load()
	-- get_config()
end

local function convert_table()
	if storage.items_radioactive then
		storage.items_radioactive = nil

		log("Info: radiation.convert_table(): removed old table after update")
	end
	if not storage.items_radioactive_01774 then
		storage.items_radioactive_01774 = {}

		log("Info: radiation.convert_table(): create new table after update")
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function radiation_script.on_update()
	radiation_script.alloc_defenitions();
	get_config()
	convert_table()
	generate_radioactive_table()
end

---@param player LuaPlayer?
---@param character LuaEntity?
---@param item_name string
---@param count integer
local function damage_to_character_from_item(player, character, item_name, count)
	if not player or not character then return end

	local item_rtype = storage.items_radioactive_01774[item_name]
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

local comparator = function(t, a, b) return t[b] < t[a] end

---@param player LuaPlayer?
---@param character LuaEntity?
---@param cause_damage boolean
local function check_inventory(player, character, cause_damage)
	if not player or not character then return end

	for item_name, radiation_level in spairs(storage.items_radioactive_01774, comparator) do
		local count = character.get_item_count(item_name)

		if count > 0 then
			local radioactive_type = "radioactive_b_"

			if radiation_level <= 1 then
				radioactive_type = "radioactive_a_"
			elseif radiation_level == 2 then
				radioactive_type = "radioactive_b_"
			elseif radiation_level >= 3 then
				radioactive_type = "radioactive_c_"
			end

			sound.create_on_character_position(radioactive_type .. tostring(math.random(3)), player)

			if cause_damage == true then
				damage_to_character_from_item(player, character, item_name, count)
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
		for item_name, _ in pairs(storage.items_radioactive_01774) do
			if not apm.lib.utils.prototypes.item.exists(item_name) then
				storage.items_radioactive_01774[item_name] = nil

				log('Info: check_item_list(): item: "' .. tostring(item_name) .. '" does not exist, removed from list.')
			end
		end

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
