-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local initial = require("lib.local.initial")
local updates = require("lib.local.updates")
local inserter = require("lib.script.inserter")
local radiation = require("lib.script.radiation")
local storage = require("lib.script.storage")
local equipment = require("lib.script.equipment")
local init = require("lib.script.init")

require("lib.script.interfaces")
require("lib.features.all")

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_init()
	init.alloc_defenitions()
	initial.run()
	inserter.on_init()
	--- TODO:
	radiation.on_init()
	storage.on_init()
	equipment.on_init()
	inserter.register_to_mod_events()
end

-- Function ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_load()
	inserter.on_load()
	radiation.on_load()
	storage.on_load()
	equipment.on_load()
	inserter.register_to_mod_events()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_update()
	initial.run()
	updates.run()
	inserter.on_update()
	radiation.on_update()
	storage.on_update()
	equipment.on_update()

	-- apm.lib.features.runtime.update()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_tick(event)
	inserter.on_tick()
	radiation.on_tick()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_nth_tick(event)
	equipment.on_nth_tick(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_mod_setting_changed(event)
	inserter.on_update()
	radiation.on_update()
	storage.on_update()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

local function on_built_entity(event)
	if event.entity.valid ~= true then return end
	inserter.on_build(event.entity)
end

local function on_destroy_entity(event)
	if event.entity.valid ~= true then return end
	inserter.on_destroy_entity(event.entity)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_entity_cloned(event)
	inserter.on_entity_cloned(event.source, event.destination)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local function event_on_robot_build(event)
-- 	if event.entity.valid ~= true then return end
-- 	inserter.on_build(event.entity)
-- end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_rotate(event)
	if event.entity.valid ~= true then return end
	inserter.on_rotate(event.entity)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_entity_settings_pasted(event)
	if event.destination.valid ~= true then return end
	inserter.on_entity_settings_pasted(event.destination)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_entity_died(event)
	storage.died(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_lua_shortcut(event)
	equipment.toggle_equipment_manager(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_placed_equipment(event)
	equipment.control_equipment_manager_shortcut(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_removed_equipment(event)
	equipment.control_equipment_manager_shortcut(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_armor_inventory_changed(event)
	equipment.control_equipment_manager_shortcut(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_created(event)
	local player = game.players[event.player_index]

	result = equipment.check_equipment_manager(player)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_joined_game(event)
	local player = game.players[event.player_index]

	equipment.check_equipment_manager(player)
end

-- Event Defines---------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local entity_build_filter = {
	{ filter = "type", type = "inserter" },
	{ filter = "type", type = "assembling-machine" },
	{ filter = "type", type = "furnace" },
	{ filter = "type", type = "lab" },
	{ filter = "type", type = "mining-drill" },
	{ filter = "type", type = "boiler" },
	{ filter = "type", type = "pump" }
}

local entity_died_filter = {
	{ filter = "type", type = "container" },
}


local build_events = {
	defines.events.on_built_entity,
	defines.events.on_robot_built_entity,
	defines.events.script_raised_built,
	defines.events.script_raised_revive,
	defines.events.on_space_platform_built_entity,
}

for _, event in ipairs(build_events) do
	script.on_event(
		event,
		on_built_entity,
		entity_build_filter
	)
end

local destroy_events = {
	defines.events.on_robot_mined_entity,
	defines.events.on_player_mined_entity,
	defines.events.on_entity_died,
	defines.events.script_raised_destroy,
	defines.events.on_space_platform_mined_entity,
}

for _, event in ipairs(destroy_events) do
	script.on_event(
		event,
		on_destroy_entity,
		entity_build_filter
	)
end

script.on_event(defines.events.on_tick, function(event) event_on_tick(event) end)
script.on_event(defines.events.on_player_created, function(event) event_on_player_created(event) end)
script.on_event(defines.events.on_player_joined_game, function(event) event_on_player_joined_game(event) end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event) event_mod_setting_changed(event) end)
-- script.on_event(defines.events.on_built_entity, function(event) on_built_entity(event) end, entity_build_filter)
-- script.on_event(defines.events.on_robot_built_entity, function(event) event_on_robot_build(event) end,
-- entity_build_filter)
script.on_event(defines.events.on_entity_cloned, function(event) event_on_entity_cloned(event) end)
script.on_event(defines.events.on_player_rotated_entity, function(event) event_on_rotate(event) end)
script.on_event(defines.events.on_entity_settings_pasted, function(event) event_on_entity_settings_pasted(event) end)
script.on_event(defines.events.on_entity_died, function(event) event_on_entity_died(event) end, entity_died_filter)
script.on_event(defines.events.on_lua_shortcut, function(event) event_on_lua_shortcut(event) end)
script.on_event(defines.events.on_player_placed_equipment, function(event) event_on_player_placed_equipment(event) end)
script.on_event(defines.events.on_player_removed_equipment, function(event) event_on_player_removed_equipment(event) end)
script.on_event(defines.events.on_player_armor_inventory_changed,
	function(event) event_on_player_armor_inventory_changed(event) end)

script.on_nth_tick(60 * 10, function(event) on_nth_tick(event) end)

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
script.on_init(event_on_init)
script.on_load(event_on_load)
script.on_configuration_changed(event_on_update)
