local equipment_script = {}

-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local core = require("lib.script.core")

require("lib.utils.prototypes")

-- Events ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local on_burner_equipment_low_fuel = script.generate_event_name()
local on_burner_equipment_burnt_result_inventory_full = script.generate_event_name()

-- Local ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local shortcut_string_equipment_manager = "apm_shortcut_equipment_manager"

---@type table<string, integer>?
local lud_burnt_result_to_stack_size

---@type table<string, {result: string?}>?
local lud_item_to_burnt_result

local function generate_burnt_fuel_stack_size_table()
	if lud_burnt_result_to_stack_size and lud_item_to_burnt_result then
		return
	end

	log("-------------------------------------------------------------")
	log("Generate lookup tables")
	log("-------------------------------------------------------------")

	lud_item_to_burnt_result = {}
	lud_burnt_result_to_stack_size = {}

	for _, item in pairs(apm.lib.utils.prototypes.item.all()) do
		if item.fuel_value > 0 then
			if item.burnt_result ~= nil and item.burnt_result.name ~= nil then
				local burnt_item = apm.lib.utils.prototypes.item.get(item.burnt_result.name)

				if not lud_item_to_burnt_result[item.name] then
					log('Info: added "' ..
						tostring(item.name) .. '" with result: "' .. tostring(burnt_item.name) .. '" to lookup table')

					lud_item_to_burnt_result[item.name] = { result = burnt_item.name }
				end

				if not lud_burnt_result_to_stack_size[burnt_item.name] then
					log('Info: added "' ..
						tostring(burnt_item.name) ..
						'" with stack size: "' .. tostring(burnt_item.stack_size) .. '" to lookup table')

					lud_burnt_result_to_stack_size[burnt_item.name] = burnt_item.stack_size
				end
			elseif item.burnt_result == nil then
				if not lud_item_to_burnt_result[item.name] then
					log('Info: added "' .. tostring(item.name) .. '" without result to lookup table')

					lud_item_to_burnt_result[item.name] = { result = nil }
				end
			end
		end
	end
end

---@param reset boolean
---@param loading boolean
local function setup_environment(reset, loading)
	if not loading and (not storage.burner_equipment or reset) then
		storage.burner_equipment = {}
	end
end

---@param equipment_name string
---@return boolean
local function add_burner_equipment(equipment_name)
	if not storage.burner_equipment then
		storage.burner_equipment = {}
	end

	if storage.burner_equipment[equipment_name] then
		log('Info: equipment.remote.add_burner_equipment(): equipment: "' ..
			tostring(equipment_name) .. '" is already on the list.')

		return true
	end

	if not storage.burner_equipment[equipment_name] then
		local equipment = apm.lib.utils.prototypes.equipment.get(equipment_name)
		if equipment then
			--if not equipment.burner then
			--    log('Warning: equipment.remote.add_burner_equipment(): equipment: "' .. tostring(equipment_name) .. '" does not have the burner property.')
			--    return false
			--end
			storage.burner_equipment[equipment_name] = true

			log('Info: equipment.remote.add_burner_equipment(): add equipment: "' ..
				tostring(equipment_name) .. '" to the list.')

			return true
		end

		log('Warning: equipment.remote.add_burner_equipment(): equipment: "' ..
			tostring(equipment_name) .. '" does not exist.')

		return false
	end

	return false
end

---@param equipment_name string
---@return boolean
local function del_burner_equipment(equipment_name)
	if not storage.burner_equipment then
		storage.burner_equipment = {}
	end

	if storage.burner_equipment[equipment_name] then
		storage.burner_equipment[equipment_name] = nil

		log('Info: equipment.remote.del_burner_equipment(): equipment: "' ..
			tostring(equipment_name) .. '" removed from the list.')

		return true
	end

	log('Warning: equipment.remote.del_burner_equipment(): equipment: "' ..
		tostring(equipment_name) .. '" is not on the list.')

	return false
end

---@param player LuaPlayer
---@return LuaEquipment[]
local function get_burner(player)
	local inventory = player.get_inventory(defines.inventory.character_armor)

	if not inventory then
		return {}
	end

	---@type LuaEquipment[]
	local results = {}
	local armour = inventory[1]
	if armour and armour.valid_for_read and armour.grid and armour.grid.equipment then
		for _, equipment in pairs(armour.grid.equipment) do
			if storage.burner_equipment[equipment.name] then
				local burner = equipment.burner

				if not burner then
					-- failsafe, if a equipment without burner was registred
					log('Error: equipment.check_fuel(): equipment: "' ..
						tostring(equipment.name) .. '" has no burner propperty, will be removed.')

					del_burner_equipment(equipment.name)
				else
					table.insert(results, equipment)
				end
			end
		end
	end

	return results
end

---@param fuel_inventory LuaInventory?
---@param burnt_fuel_inventory LuaInventory?
---@return boolean
local function check_burnt_fuel_inventory_is_blocked(fuel_inventory, burnt_fuel_inventory)
	if not burnt_fuel_inventory or burnt_fuel_inventory.get_item_count() <= 0 then
		return false
	end

	if not fuel_inventory then
		return false
	end

	---@type string[]
	local fuel_items = {}

	for i = 1, #fuel_inventory do
		local item_fuel = fuel_inventory[i]

		if item_fuel.valid_for_read then
			table.insert(fuel_items, i, item_fuel.name)
		end
	end

	for i = 1, #burnt_fuel_inventory do
		local item_burnt = burnt_fuel_inventory[i]

		if item_burnt.valid_for_read and item_burnt.count >= 1 then
			if
					fuel_items[i] and
					lud_item_to_burnt_result and
					lud_item_to_burnt_result[fuel_items[i]] and
					lud_item_to_burnt_result[fuel_items[i]].result and
					lud_item_to_burnt_result[fuel_items[i]].result ~= item_burnt.name
			then
				return true
			end
		end
	end

	return false
end

---@param burnt_fuel_inventory LuaInventory?
---@return boolean
local function check_burnt_fuel_inventory_state(burnt_fuel_inventory)
	if not burnt_fuel_inventory or burnt_fuel_inventory.get_item_count() <= 0 then
		return false
	end

	local max_items = 0
	local item_count = 0

	for i = 1, #burnt_fuel_inventory do
		local item_burnt = burnt_fuel_inventory[i]

		if
				item_burnt and item_burnt.valid_for_read and
				item_burnt.count >= 1 and
				lud_burnt_result_to_stack_size
		then
			max_items = max_items + (lud_burnt_result_to_stack_size[item_burnt.name] or 1)
			item_count = item_count + item_burnt.count
		end
	end

	if item_count >= max_items then
		return true
	end

	return false
end

---@param player LuaPlayer
---@param equipment LuaEquipment
---@param alerts LocalisedString[]
---@param fuel_is_empty boolean
---@param burnt_fuel_inventory_is_blocked boolean
---@param burnt_fuel_inventory_is_full boolean
---@return LocalisedString[]
local function generate_alerts(player, equipment, alerts, fuel_is_empty, burnt_fuel_inventory_is_blocked,
															 burnt_fuel_inventory_is_full)
	if fuel_is_empty or burnt_fuel_inventory_is_blocked or burnt_fuel_inventory_is_full then
		local i_string = equipment.name
		if equipment.prototype.take_result then
			i_string = equipment.prototype.take_result.name
		end

		local l_string = equipment.prototype.localised_name or { "equipment-name." .. tostring(equipment.name) }

		if not alerts then
			alerts = { "" }
		else
			table.insert(alerts, "\n")
		end

		if fuel_is_empty then
			table.insert(alerts, { "apm_msg_alert_low_fuel", i_string, l_string })
			script.raise_event(on_burner_equipment_low_fuel, { player = player, equipment = equipment })
		end

		if fuel_is_empty and (burnt_fuel_inventory_is_blocked or burnt_fuel_inventory_is_full) then
			table.insert(alerts, "\n")
		end

		if burnt_fuel_inventory_is_blocked then
			table.insert(alerts, { "apm_msg_alert_burnt_fuel_inventory_is_blocked", i_string, l_string })
			script.raise_event(on_burner_equipment_burnt_result_inventory_full, { player = player, equipment = equipment })
			return alerts
		end

		if burnt_fuel_inventory_is_full then
			table.insert(alerts, { "apm_msg_alert_burnt_fuel_inventory_is_full", i_string, l_string })
			script.raise_event(on_burner_equipment_burnt_result_inventory_full, { player = player, equipment = equipment })
		end
	end

	return alerts
end

---@param player LuaPlayer
---@param equipment LuaEquipment
---@param alerts LocalisedString[]
local function check_equipment(player, equipment, alerts)
	local burner = equipment.burner

	if not burner then
		return
	end

	local fuel_inventory = burner.inventory
	local burnt_fuel_inventory = burner.burnt_result_inventory
	local fuel_is_empty = false
	local burnt_fuel_inventory_is_blocked = false
	local burnt_fuel_inventory_is_full = false

	if burner.remaining_burning_fuel == 0 then
		fuel_is_empty = true
	end

	burnt_fuel_inventory_is_blocked = check_burnt_fuel_inventory_is_blocked(fuel_inventory, burnt_fuel_inventory)
	burnt_fuel_inventory_is_full = check_burnt_fuel_inventory_state(burnt_fuel_inventory)

	return generate_alerts(player, equipment, alerts, fuel_is_empty, burnt_fuel_inventory_is_blocked,
		burnt_fuel_inventory_is_full)
end

---@param player_inventory LuaInventory?
---@param equipment LuaEquipment?
local function equipment_manager_fuel(player_inventory, equipment)
	if not player_inventory then return end

	if not equipment or not equipment.burner then return end

	local equipment_inventory = equipment.burner.inventory

	if equipment_inventory == nil then return end

	for i = 1, #equipment_inventory do
		local item = equipment_inventory[i]

		if not item.valid_for_read or item.count >= 10 then return end

		local player_item_count = player_inventory.get_item_count(item.name)

		if player_item_count == 0 then return end

		local transfer_size = 10 - item.count
		if player_item_count < transfer_size then
			transfer_size = player_item_count
		end

		---@type ItemStackDefinition
		local item_stack = { name = item.name, count = transfer_size, quality = item.quality.name }

		if equipment_inventory.can_insert(item_stack) then
			local inserted = equipment_inventory.insert(item_stack)

			player_inventory.remove({ name = item.name, count = inserted, quality = item.quality.name })
		end
	end
end

---@param player_inventory LuaInventory?
---@param equipment LuaEquipment?
local function equipment_manager_residues(player_inventory, equipment)
	if not player_inventory then return end

	if not equipment or not equipment.burner then return end

	local equipment_inventory = equipment.burner.burnt_result_inventory

	if equipment_inventory == nil then return end

	for i = 1, #equipment_inventory do
		local item = equipment_inventory[i]

		if not item.valid_for_read then return end

		local item_stack = { name = item.name, count = item.count, quality = item.quality.name }

		if player_inventory.can_insert(item_stack) then
			local inserted = player_inventory.insert(item_stack)

			equipment_inventory.remove({ name = item.name, count = inserted })
		end
	end
end

---@param player LuaPlayer?
---@param equipment LuaEquipment?
local function equipment_manager(player, equipment)
	if not player or not equipment then return end

	if not player.is_shortcut_toggled(shortcut_string_equipment_manager) then return end

	local player_inventory = player.get_main_inventory()

	if player_inventory == nil then return end

	equipment_manager_fuel(player_inventory, equipment)
	equipment_manager_residues(player_inventory, equipment)
end

---@param player LuaPlayer?
---@param character LuaEntity?
local function check(player, character)
	if not player or not character then return end

	local burners = get_burner(player)
	if #burners > 0 then
		local alerts

		for _, equipment in pairs(burners) do
			equipment_manager(player, equipment)

			alerts = check_equipment(player, equipment, alerts)
		end

		if alerts then
			player.add_custom_alert(character, { type = "virtual", name = "apm_alert_equipment_burner" }, alerts, true)

			if settings.get_player_settings(player)["apm_lib_burner_equipment_alerts_sound"].value then
				player.play_sound({ path = "alert_burner_equipment" })
			end
		end
	end
end

---@param player LuaPlayer?
---@param state boolean?
local function toggle_equipment_manager(player, state)
	if not player then return end

	local current_state = player.is_shortcut_toggled(shortcut_string_equipment_manager)
	local new_state = not current_state

	if state then
		new_state = state
	end

	player.set_shortcut_toggled(shortcut_string_equipment_manager, new_state)

	local msg = { "apm_msg_equipment_manager_enabled" }
	if not new_state then
		msg = { "apm_msg_equipment_manager_disabled" }
	end

	core.send_msg_to_player(player, msg)
end

---@param event {player_index: integer, alt_mode: boolean, name: defines.events, tick: integer}
local function hotkey_equipment_manager(event)
	local player = game.players[event.player_index]

	toggle_equipment_manager(player)
end

---@param player LuaPlayer?
---@return boolean
local function player_has_burner_equipment(player)
	if not player then return false end

	local burners = get_burner(player)

	if #burners > 0 then return true end

	return false
end

---@param player LuaPlayer?
---@param force_enable boolean?
local function control_equipment_manager_shortcut(player, force_enable)
	if not player then return end

	if player_has_burner_equipment(player) then
		player.set_shortcut_available(shortcut_string_equipment_manager, true)

		if force_enable then
			toggle_equipment_manager(player, true)
		end
	else
		if player.is_shortcut_toggled(shortcut_string_equipment_manager) then
			toggle_equipment_manager(player, false)
		end

		player.set_shortcut_available(shortcut_string_equipment_manager, false)
	end
end

---@param player LuaPlayer?
local function check_equipment_manager(player)
	control_equipment_manager_shortcut(player)
end

---@param player LuaPlayer?
function equipment_script.check_equipment_manager(player)
	control_equipment_manager_shortcut(player)
end

function equipment_script.on_init()
	setup_environment(false, false)

	setup_starting_items()
end

function setup_starting_items()
	local default_starting_items = {
		{ name = "apm_equipment_burner_generator_basic", count = 1 },
		{ name = "burner-mining-drill",                  count = 12 },
		{ name = "apm_coke",                             count = 400 },
		{ name = "burner-inserter",                      count = 10 },
		{ name = "stone-furnace",                        count = 10 },
		{ name = "personal-roboport-equipment",          count = 1 },
		{ name = "battery-equipment",                    count = 2 },
		{ name = "apm_zx80_construction_robot",          count = 10 },
		{ name = "modular-armor",                        count = 1 },
		{ name = "apm_assembling_machine_0",             count = 5 },
		{ name = "firearm-magazine",                     count = 50 },
	}

	remote.call("ldinc_starting_equipment", "add_list", "apm_lib", default_starting_items)
end

function equipment_script.on_load()
	setup_environment(false, true)
end

function equipment_script.on_update()
	setup_environment(true, false)
end

---@param event {player_index: integer}
function equipment_script.control_equipment_manager_shortcut(event)
	local player = game.players[event.player_index]

	if not player then return end

	control_equipment_manager_shortcut(player)
end

---@param event {player_index: integer, prototype_name: string}
function equipment_script.toggle_equipment_manager(event)
	if event.prototype_name ~= shortcut_string_equipment_manager then return end

	local player = game.players[event.player_index]

	toggle_equipment_manager(player)
end

---@param event NthTickEventData
function equipment_script.on_nth_tick(event)
	generate_burnt_fuel_stack_size_table()

	local tick = game.tick

	if tick == 0 then return end

	local players = core.get_valid_players()

	if not players then return end
	for _, t_object in pairs(players) do
		check(t_object.player, t_object.character)
	end
end

-- Remote Interface -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- /c remote.call('apm_equipment', 'add_burner_equipment', 'xxx')
-- /c remote.call('apm_equipment', 'del_burner_equipment', 'xxx')
-- /c remote.call('apm_equipment', 'check_equipment_manager', player :: LuaPlayer)
--
-- subscribing events:
-- script.on_event(remote.call("apm_equipment", "event_on_burner_equipment_low_fuel"), function(event)
--    -- your stuff here
--  end)
-- script.on_event(remote.call("apm_equipment", "event_on_burner_equipment_burnt_result_inventory_full"), function(event)
--    -- your stuff here
--  end)
--  WARNING: this has to be done within on_init and on_load, otherwise the game will error about the remote.call

remote.add_interface("apm_equipment", {
	add_burner_equipment = function(equipment_name) return add_burner_equipment(equipment_name) end,
	del_burner_equipment = function(equipment_name) return del_burner_equipment(equipment_name) end,
	check_equipment_manager = function(player) return check_equipment_manager(player) end,
	event_on_burner_equipment_low_fuel = function() return on_burner_equipment_low_fuel end,
	event_on_burner_equipment_burnt_result_inventory_full = function()
		return
				on_burner_equipment_burnt_result_inventory_full
	end
})

-- Register script event -------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
script.on_event("apm_input_equipment_manager", function(event) hotkey_equipment_manager(event) end)

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return equipment_script
