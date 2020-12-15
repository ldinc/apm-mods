require ('util')
require('__apm_lib__.lib.log')

local self = 'apm_energy_addon/prototypes/integrations/technology.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_compat_bob = settings.startup["apm_energy_addon_compat_bob"].value
local apm_energy_addon_compat_earendel = settings.startup["apm_energy_addon_compat_earendel"].value
local apm_energy_addon_compat_reverse_factory = settings.startup["apm_energy_addon_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_bob', apm_energy_addon_compat_bob)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_earendel', apm_energy_addon_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_reverse_factory', apm_energy_addon_compat_reverse_factory)


if mods['aai-vehicles-miner'] and apm_energy_addon_compat_earendel then
    apm.lib.utils.technology.add.prerequisites('vehicle-miner-3', 'electric-engine')
    apm.lib.utils.technology.add.prerequisites('vehicle-miner-3', 'battery')
    apm.lib.utils.technology.add.prerequisites('vehicle-miner-4', 'electric-engine')
    apm.lib.utils.technology.add.prerequisites('vehicle-miner-4', 'battery')
end