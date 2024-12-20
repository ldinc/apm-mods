local updates = {}

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function update_01801()
    
    if global.update_01801 == nil then global.update_01801 = false end
    
    if game.active_mods['apm_starfall_ldinc'] >= '0.18.1' and not global.update_01801 then
        log('---------------------------------------------')
        log('Running update script for "0.18.01"')
        remote.call('apm_starfall_ldinc', 'add_surface', 1)
        log('---------------------------------------------')
        global.update_01801 = true
    end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function updates.run()
    if settings.startup["apm_starfall_update_01801_disable"].value == false then
        update_01801()
    end
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return updates
