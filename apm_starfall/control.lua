-- Requires Defines------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local updates = require('lib.updates')
local starfall = require('__apm_lib_ldinc__.lib.script.starfall')

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_init()
	starfall.init()
    remote.call('apm_starfall', 'add_surface', 1)
    starfall.register_to_mod_events()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_load()
    starfall.register_to_mod_events()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_update()
	starfall.init()
    updates.run()
    starfall.recalculate_borders()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_on_tick(event)
	starfall.on_tick()
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function event_mod_setting_changed(event)
    starfall.mod_setting_changed()
end

-- on_nth_tick -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function on_nth_tick()
    starfall.recalculate_borders()
end

-- Event Defines---------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
script.on_event(defines.events.on_tick, function(event) event_on_tick(event) end)
script.on_event (defines.events.on_runtime_mod_setting_changed, function(event) event_mod_setting_changed(event) end)
script.on_nth_tick(60*60*5, function() on_nth_tick() end)

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
script.on_init(on_init)
script.on_load(on_load)
script.on_configuration_changed(on_update)