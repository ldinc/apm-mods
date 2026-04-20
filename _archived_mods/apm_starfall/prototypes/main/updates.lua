require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/updates.lua'

APM_LOG_HEADER(self)

apm.lib.utils.fuel.overhaul(5, 'apm_alien_fuel', 8.0, 'apm_alien_fuel_burnted', 'apm_starfall_alien')
apm.lib.utils.fuel.overwrite_emissions_multiplier('apm_alien_fuel', 0.2)
