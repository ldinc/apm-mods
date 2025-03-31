require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/integrations/items.lua'

APM_LOG_HEADER(self)

local apm_power_overhaul_machine_frames = settings.startup["apm_power_overhaul_machine_frames"].value
local apm_power_steam_assembler_craftin_with_fluids = settings.startup["apm_power_steam_assembler_craftin_with_fluids"].value
local apm_power_compat_bob = settings.startup["apm_power_compat_bob"].value
local apm_power_compat_bob_overhaul_machine_frames = settings.startup["apm_power_compat_bob_overhaul_machine_frames"].value
local apm_power_compat_angel = settings.startup["apm_power_compat_angel"].value
local apm_power_compat_angel_overhaul_machine_frames = settings.startup["apm_power_compat_angel_overhaul_machine_frames"].value
local apm_power_compat_sctm = settings.startup["apm_power_compat_sctm"].value
local apm_power_compat_sct_overhaul_machine_frames = settings.startup["apm_power_compat_sct_overhaul_machine_frames"].value
local apm_power_compat_earendel = settings.startup["apm_power_compat_earendel"].value
local apm_power_compat_bio_industries = settings.startup["apm_power_compat_bio_industries"].value
local apm_power_compat_expensivelandfillrecipe = settings.startup["apm_power_compat_expensivelandfillrecipe"].value
local apm_power_compat_kingarthur = settings.startup["apm_power_compat_kingarthur"].value
local apm_power_compat_mferrari = settings.startup["apm_power_compat_mferrari"].value
local apm_power_compat_linver = settings.startup["apm_power_compat_linver"].value
local apm_power_compat_realistic_reactors = settings.startup["apm_power_compat_realistic_reactors"].value
local apm_power_compat_reverse_factory = settings.startup["apm_power_compat_reverse_factory"].value
local apm_power_compat_arcitos = settings.startup["apm_power_compat_arcitos"].value

APM_LOG_SETTINGS(self, 'apm_power_overhaul_machine_frames', apm_power_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_steam_assembler_craftin_with_fluids', apm_power_steam_assembler_craftin_with_fluids)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob', apm_power_compat_bob)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob_overhaul_machine_frames', apm_power_compat_bob_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel', apm_power_compat_angel)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overhaul_machine_frames', apm_power_compat_angel_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_sctm', apm_power_compat_sctm)
APM_LOG_SETTINGS(self, 'apm_power_compat_sct_overhaul_machine_frames', apm_power_compat_sct_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_earendel', apm_power_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_power_compat_bio_industries', apm_power_compat_bio_industries)
APM_LOG_SETTINGS(self, 'apm_power_compat_expensivelandfillrecipe', apm_power_compat_expensivelandfillrecipe)
APM_LOG_SETTINGS(self, 'apm_power_compat_kingarthur', apm_power_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_power_compat_mferrari', apm_power_compat_mferrari)
APM_LOG_SETTINGS(self, 'apm_power_compat_linver', apm_power_compat_linver)
APM_LOG_SETTINGS(self, 'apm_power_compat_realistic_reactors', apm_power_compat_realistic_reactors)
APM_LOG_SETTINGS(self, 'apm_power_compat_reverse_factory', apm_power_compat_reverse_factory)
APM_LOG_SETTINGS(self, 'apm_power_compat_arcitos', apm_power_compat_arcitos)

apm.lib.utils.item.mod.stack_size('copper-ore', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('iron-ore', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('stone', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('coal', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('uranium-ore', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('sulfur', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('wood', apm.lib.features.stack_size.default, false)
apm.lib.utils.item.mod.stack_size('steel-plate', apm.lib.features.stack_size.default, false)

-- AsphaltRoads ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['AsphaltRoads'] and apm_power_compat_arcitos then
	apm.lib.utils.item.overwrite.localised_name('Arci-asphalt', {'item-name.apm_arci_asphalt'})
end

if mods.bobpower and apm_power_compat_bob then
	if apm.lib.utils.setting.get.starup('bobmods-power-steam') then
		apm.lib.utils.item.remove('apm_boiler_2')
		apm.lib.utils.item.remove('apm_steam_engine_2')
	end
end

if mods['aai-industry'] and apm_power_compat_earendel then
	apm.lib.utils.item.remove("sand")
end

--- [crushing-industry]
if mods["crushing-industry"] then
	require("prototypes.integrations.items.crushing-industry")
end
