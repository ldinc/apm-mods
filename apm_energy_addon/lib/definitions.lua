require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/lib/definitions.lua'

APM_LOG_HEADER(self)

if apm.energy_addon.color == nil then apm.energy_addon.color = {} end
if apm.energy_addon.constants == nil then apm.energy_addon.constants = {} end
if apm.energy_addon.icons == nil then apm.energy_addon.icons = {} end
if apm.energy_addon.icons.path == nil then apm.energy_addon.icons.path = {} end

-- Constants ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.energy_addon.constants.fuel_value = {}
apm.energy_addon.constants.fuel_value.battery_vanilla = '4MJ'
apm.energy_addon.constants.fuel_value.battery_bob_lithium_ion = '6MJ'
apm.energy_addon.constants.fuel_value.battery_bob_silver_zinc = '8MJ'
apm.energy_addon.constants.fuel_value.apm_rtg = '1GJ'

apm.energy_addon.constants.energy_required = {}
apm.energy_addon.constants.energy_required.load = {}
apm.energy_addon.constants.energy_required.load.battery_vanilla = 3*4.00
apm.energy_addon.constants.energy_required.load.battery_bob_lithium_ion = 3*6.00
apm.energy_addon.constants.energy_required.load.battery_bob_silver_zinc = 3*8.00

apm.energy_addon.constants.energy_usage_charging_station = '5MW'

-- Icon path ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.energy_addon.icons.path.depleted_battery_overlay = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_depleted_battery_overlay.png'
apm.energy_addon.icons.path.rtg_decayed = '__apm_resource_pack_ldinc__/graphics/icons/apm_rtg_decayed.png'
apm.energy_addon.icons.path.electric_symbol = '__apm_resource_pack_ldinc__/graphics/icons/dynamics/apm_electric_symbol.png'

-- Icons ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.energy_addon.icons.depleted_battery_overlay = {size=64, icon=apm.energy_addon.icons.path.depleted_battery_overlay, filename=apm.energy_addon.icons.path.depleted_battery_overlay, icon_mipmaps=4, icon_size=64}
apm.energy_addon.icons.rtg_decayed = {icon=apm.energy_addon.icons.path.rtg_decayed, icon_size=64}
apm.energy_addon.icons.electric_symbol = {icon=apm.energy_addon.icons.path.electric_symbol, icon_size=64}
