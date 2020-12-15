local updates = {}

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function update_01801()
    if global.update_01801 == nil then global.update_01801 = false end

    if game.active_mods['apm_lib_ldinc'] >= '0.18.1' and not global.update_01801 then
        log('---------------------------------------------')
        log('Running update script for "0.18.01"')
        remote.call('apm_radiation', 'remove_item', 'uranium-ore')
        remote.call('apm_radiation', 'remove_item', 'uranium-238')
        log('---------------------------------------------')
        global.update_01801 = true
    end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function updates.run()
    update_01801()
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
return updates
