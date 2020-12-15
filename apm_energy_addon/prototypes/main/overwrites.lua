require('util')
require('__apm_lib__.lib.log')

local self = 'apm_energy_addon/prototypes/main/overwrites.lua'

APM_LOG_HEADER(self)

-- car
apm.energy_addon.overhaul('apm_electric_car')

-- tank
apm.energy_addon.overhaul('apm_electric_tank')
