if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local off = apm.lib.utils.recipe.disable
local on = apm.lib.utils.recipe.enable
local push = apm.lib.utils.technology.add.recipe_for_unlock
local rebind = function (base, sub)
    apm.lib.utils.technology.remove.prerequisites(sub, base)
    apm.lib.utils.technology.add.prerequisites(base, sub)
end
local drop = apm.lib.utils.technology.remove.science_pack

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
off('apm_zinc')
off('apm_stone_crushed_1')
off('apm_gun_powder')
off('repair-pack')
off('incinerator')
off(apm.bob_rework.lib.entities.steamInserter)
off(apm.bob_rework.lib.entities.monel)


push('apm_crusher_machine_0', 'apm_gun_powder')
push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearing)
push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearingBall)
push('apm_press_machine_0', 'repair-pack')
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzePipe)
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzeUnderPipe)

push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.ironStick)
push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelBearingBall)
push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelBearing)
push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelGearWheel)

push('apm_steam_science_pack', apm.bob_rework.lib.entities.steamInserter)
push('apm_power_steam', apm.bob_rework.lib.entities.brass)
push('apm_power_steam', apm.bob_rework.lib.entities.brassGearWheel)
push('apm_power_steam', apm.bob_rework.lib.entities.brassBearing)
push('apm_power_steam', apm.bob_rework.lib.entities.brassBearingBall)
push('apm_power_steam', apm.bob_rework.lib.entities.brassPipe)
push('apm_power_steam', apm.bob_rework.lib.entities.brassUnderPipe)
push('apm_coking_plant_0', 'apm_zinc')
push('apm_stone_brick', 'apm_stone_crushed_1')

push('apm_power_electricicty', 'incinerator')
rebind('logistics', 'automation')
rebind('automation', 'electric-engine')

push('alloy-processing', apm.bob_rework.lib.monel)
drop('invar-processing', 'logistic-science-pack')
rebind('logistic-science-pack', 'invar-processing')
