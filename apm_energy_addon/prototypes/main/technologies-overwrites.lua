require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/technologies-overwrites.lua'

APM_LOG_HEADER(self)

apm.lib.utils.technology.add.recipe_for_unlock('battery', 'apm_battery_charging_station')