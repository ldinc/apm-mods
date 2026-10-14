-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local updates = require("lib.updates")
-- local core = require('__apm_lib_ldinc__.lib.script.core')
local patch_aai = require("__apm_lib_ldinc__.lib.script.patch.aai")
local patch_angel = require("__apm_lib_ldinc__.lib.script.patch.angel")

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function register_burner_equipment()
	remote.call("apm_equipment", "add_burner_equipment", "apm_equipment_burner_generator_basic")
	remote.call("apm_equipment", "add_burner_equipment", "apm_equipment_burner_generator_advanced")
end

local function setup_starting_items()
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

	local interface = remote.interfaces["ldinc_starting_equipment"]

	if not interface or not interface["add_list"] then
		return
	end

	remote.call("ldinc_starting_equipment", "add_list", "apm_lib", default_starting_items)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function On_Init()
	updates.run()

	patch_aai.patch_starting_items()

	setup_starting_items()

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
