-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local updates = require('lib.updates')
-- local core = require('__apm_lib_ldinc__.lib.script.core')
-- local patch_aai = require('__apm_lib_ldinc__.lib.script.patch.aai')
local patch_angel = require('__apm_lib_ldinc__.lib.script.patch.angel')
local offshore_pumps = require('__apm_lib_ldinc__.lib.script.offshore_pump')

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_burner_equipment()
	remote.call('apm_equipment', 'add_burner_equipment', 'apm_equipment_burner_generator_basic')
	remote.call('apm_equipment', 'add_burner_equipment', 'apm_equipment_burner_generator_advanced')
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function On_Init()
	updates.run()
	offshore_pumps.on_init()
	register_burner_equipment()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_load()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_update()
	updates.run()
	offshore_pumps.on_update()
	register_burner_equipment()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local function event_on_tick()
-- 	patch_aai.on_tick()
-- 	patch_angel.on_tick()
-- end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_created(event)
	patch_angel.player_create(event)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_player_joined_game(event)
end

-- Event Defines---------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------


script.on_event(defines.events.on_player_created, function(event) event_on_player_created(event) end)
script.on_event(defines.events.on_player_joined_game, function(event) event_on_player_joined_game(event) end)

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
script.on_init(On_Init)
script.on_load(on_load)
script.on_configuration_changed(on_update)