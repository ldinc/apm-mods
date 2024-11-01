-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local initial = require('lib.local.initial')
local updates = require('lib.local.updates')
local inserter = require('lib.script.inserter')
local radiation = require('lib.script.radiation')
local storage = require('lib.script.storage')
local equipment = require('lib.script.equipment')
require('lib.script.interfaces')

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_init()
    storage.startupEquipment = {}
    initial.run()
	inserter.on_init()
    radiation.on_init()
    storage.on_init()
    equipment.on_init()
    inserter.register_to_mod_events()
end

-- Function -------------------------------------------------------------------
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
local function on_nth_tick()
    equipment.on_nth_tick()
end

local function on_cutscene_cancelled(player)
    equipment.check_starting_equipment(game.players[player])
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

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_entity_cloned(event)
    inserter.on_entity_cloned(event.source , event.destination)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_robot_build(event)
    if event.entity.valid ~= true then return end
    inserter.on_build(event.entity)
end

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

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_created(event)

    local player = game.players[event.player_index]
    -- log("event:" .. dump(event))
    -- log("player:" .. tostring(event.player_index))
    -- log("player:" .. dump(player))

    -- local inventory = player.get_inventory(defines.inventory.character_main)
    -- log("inv:" .. tostring(inventory))


    result = equipment.check_equipment_manager(player)
    equipment.check_starting_equipment(player)

    -- player.insert{name="apm_equipment_burner_generator_basic", count=1}
    -- player.insert{name="iron-plate", count=200}
    -- player.insert{name="copper-plate", count=200}
    -- player.insert{name="burner-mining-drill", count=12}
    -- player.insert{name="coal", count=400}
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_joined_game(event)
    local player = game.players[event.player_index]
    equipment.check_equipment_manager(player)

    -- log("event:" .. dump(event))
    -- log("player:" .. tostring(event.player_index))
    -- log("player:" .. dump(player))

    -- local inventory = player.get_inventory(defines.inventory.character_main)
    -- log("inv:" .. tostring(inventory))
    -- player.insert{name="apm_equipment_burner_generator_basic", count=1}
    -- player.insert{name="iron-plate", count=200}
    -- player.insert{name="copper-plate", count=200}
    -- player.insert{name="burner-mining-drill", count=12}
    -- player.insert{name="coal", count=400}
end

-- Event Defines---------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local entity_build_filter = {
    {filter='type', type='inserter'},
    {filter='type', type='assembling-machine'},
    {filter='type', type='furnace'},
    {filter='type', type='lab'},
    {filter='type', type='mining-drill'},
    {filter='type', type='boiler'},
    {filter='type', type='pump'}
}

local entity_died_filter = {
    {filter='type', type='container'},
}
script.on_event(defines.events.on_tick, function(event) event_on_tick(event) end)
script.on_event(defines.events.on_player_created, function(event) event_on_player_created(event) end)
script.on_event(defines.events.on_player_joined_game, function(event) event_on_player_joined_game(event) end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event) event_mod_setting_changed(event) end)
script.on_event(defines.events.on_built_entity, function(event) on_built_entity(event) end, entity_build_filter)
script.on_event(defines.events.on_robot_built_entity, function(event) event_on_robot_build(event) end, entity_build_filter)
script.on_event(defines.events.on_entity_cloned, function(event) event_on_entity_cloned(event) end)
script.on_event(defines.events.on_player_rotated_entity, function(event) event_on_rotate(event) end)
script.on_event(defines.events.on_entity_settings_pasted, function(event) event_on_entity_settings_pasted(event) end)
script.on_event(defines.events.on_entity_died, function(event) event_on_entity_died(event) end, entity_died_filter)
script.on_event(defines.events.on_lua_shortcut, function(event) event_on_lua_shortcut(event) end)
script.on_event(defines.events.on_player_placed_equipment, function(event) event_on_player_placed_equipment(event) end)
script.on_event(defines.events.on_player_removed_equipment, function(event) event_on_player_removed_equipment(event) end)
script.on_event(defines.events.on_player_armor_inventory_changed, function(event) event_on_player_armor_inventory_changed(event) end)

script.on_nth_tick(60*10, function() on_nth_tick() end)
script.on_event(defines.events.on_cutscene_cancelled, function (event)
    on_cutscene_cancelled(event.player_index)
end)

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
script.on_init(event_on_init)
script.on_load(event_on_load)
script.on_configuration_changed(event_on_update)