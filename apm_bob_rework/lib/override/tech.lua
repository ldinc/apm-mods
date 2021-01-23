if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local off = apm.lib.utils.recipe.disable
local on = apm.lib.utils.recipe.enable
local push = apm.lib.utils.technology.add.recipe_for_unlock

-- apm.lib.utils.technology.remove.recipe_from_unlock('alloy-processing', 'stone-mixing-furnace')
-- setup startup entities & remove some techs
on('stone-mixing-furnace')
on(apm.bob_rework.lib.entities.bronze)
off('apm_steam_science_pack')
off(apm.bob_rework.lib.entities.bronzeBearing)
off(apm.bob_rework.lib.entities.bronzeBearingBall)
off('apm_steam_science_pack')
off(apm.bob_rework.lib.entities.brassBearing)
off(apm.bob_rework.lib.entities.brassBearingBall)
off(apm.bob_rework.lib.entities.brassGearWheel)
off('steel-plate')


push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearing)
push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearingBall)
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzePipe)
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzeUnderPipe)

push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.ironStick)
push('apm_steam_science_pack', apm.bob_rework.lib.entities.steamInserter)
push('apm_power_steam', apm.bob_rework.lib.entities.brass)
push('apm_power_steam', apm.bob_rework.lib.entities.brassGearWheel)
push('apm_power_steam', apm.bob_rework.lib.entities.brassBearing)
push('apm_power_steam', apm.bob_rework.lib.entities.brassBearingBall)

-- TODO: add recipe for zinc (replace sulfur acid to coke & use chemical furnace for yearly brass)