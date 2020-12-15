require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/integrations/entities.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_compat_bob = settings.startup["apm_energy_addon_compat_bob"].value
local apm_energy_addon_compat_earendel = settings.startup["apm_energy_addon_compat_earendel"].value
local apm_energy_addon_compat_reverse_factory = settings.startup["apm_energy_addon_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_bob', apm_energy_addon_compat_bob)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_earendel', apm_energy_addon_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_reverse_factory', apm_energy_addon_compat_reverse_factory)

-- Earendel -------------------------------------------------------------------------------
-- This need to run in the update phase so Earendel can correctly generate his units,
-- with the expected values
-- ----------------------------------------------------------------------------------------
if mods['aai-vehicles-miner'] and apm_energy_addon_compat_earendel then
    apm.energy_addon.overhaul('vehicle-miner-mk3')
    apm.energy_addon.overhaul('vehicle-miner-mk4')

    -- the vehicle-miner need a effectivity of 2 to work correct
    apm.lib.utils.car.effectivity('vehicle-miner', 2)
    apm.lib.utils.car.effectivity('vehicle-miner-mk2', 2)
	apm.lib.utils.car.effectivity('vehicle-miner-mk3', 2)
	apm.lib.utils.car.effectivity('vehicle-miner-mk4', 2)
	apm.lib.utils.car.effectivity('vehicle-miner-mk5', 2)
end

if mods['aai-vehicles-laser-tank'] and apm_energy_addon_compat_earendel then
    apm.energy_addon.overhaul('vehicle-laser-tank')
end

if mods['aai-vehicles-warden'] and apm_energy_addon_compat_earendel then
	apm.lib.utils.car.effectivity('vehicle-warden', 2)
end

-- bob ------------------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------------------
if mods.bobvehicleequipment and apm_energy_addon_compat_bob then
    data.raw.car['apm_electric_car'].equipment_grid = "bob-car"
    data.raw.car['apm_electric_tank'].equipment_grid = "bob-tank"
end