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
local rm = apm.lib.utils.technology.remove.recipe_from_unlock
local drop = apm.lib.utils.technology.remove.science_pack
local free = function (name)
    apm.lib.utils.technology.disable(name)
    apm.lib.utils.technology.delete(name)
    -- force
    if data.raw.technology[name] then
        data.raw.technology[name] = nil
    end
end
local unbind = apm.lib.utils.technology.remove.prerequisites
local bind = apm.lib.utils.technology.add.prerequisites
local repush = function (from, to, item)
    rm(from, item)
    push(to, item)
end
local repushItems = function (from, to, items)
    for _, v in pairs(items) do
        repush(from, to, v)
    end
end

-- apm.lib.utils.technology.remove.recipe_from_unlock('alloy-processing', 'stone-mixing-furnace')
-- setup startup entities & remove some techs
on('stone-mixing-furnace')
on(apm.bob_rework.lib.entities.bronze)
off('iron-stick')
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
-- off(apm.bob_rework.lib.entities.cobaltAlloy)


push('apm_crusher_machine_0', 'apm_gun_powder')
push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearing)
push('apm_press_machine_0', apm.bob_rework.lib.entities.bronzeBearingBall)
push('apm_press_machine_0', 'repair-pack')
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzePipe)
push('apm_water_supply-1', apm.bob_rework.lib.entities.bronzeUnderPipe)

drop('steel-processing', 'apm_steam_science_pack')
drop('steel-processing', 'automation-science-pack')
push('steel-processing', apm.bob_rework.lib.entities.ironStick)
rebind('steel-processing', 'apm_puddling_furnace_0')
unbind('steel-processing', 'electrolysis-1')
unbind('steel-processing', 'chemical-processing-1')
unbind('steel-processing', 'apm_power_automation_science_pack')
drop('warehouse-research', 'apm_steam_science_pack')
drop('warehouse-research', 'automation-science-pack')
drop('warehouse-research', 'logistic-science-pack')

-- push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelBearingBall)
-- push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelBearing)
-- push('apm_puddling_furnace_0', apm.bob_rework.lib.entities.steelGearWheel)

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

push('alloy-processing', apm.bob_rework.lib.entities.monel)
-- push('alloy-processing', apm.bob_rework.lib.entities.cobaltAlloy)
rm('alloy-processing', apm.bob_rework.lib.entities.bronze)
rm('alloy-processing', apm.bob_rework.lib.entities.bronzePipe)
rm('alloy-processing', apm.bob_rework.lib.entities.bronzeUnderPipe)
rm('alloy-processing', 'stone-mixing-furnace')
drop('invar-processing', 'logistic-science-pack')
rebind('logistic-science-pack', 'invar-processing')

drop('stone-wall', 'apm_steam_science_pack')
drop('stone-wall', 'automation-science-pack')
drop('gun-turret', 'apm_steam_science_pack')
drop('gun-turret', 'automation-science-pack')
drop('gate', 'logistic-science-pack')
unbind('gate', 'military-2')
bind('gate', 'military')
rm('military-2', 'piercing-rounds-magazine')
rm('military-2', 'grenade')
push('military', 'piercing-rounds-magazine')
push('military', 'grenade')
bind('gun-turret', 'apm_press_machine_0')
bind('stone-wall', 'apm_press_machine_0')
repush('apm_stone_bricks', 'apm_coking_plant_0', 'storage-tank')
repushItems('zinc-processing', 'apm_coking_plant_0', {
    apm.bob_rework.lib.entities.brass, apm.bob_rework.lib.entities.gunMetal,
    apm.bob_rework.lib.entities.brassBearing, apm.bob_rework.lib.entities.brassBearingBall,
    apm.bob_rework.lib.entities.brassGearWheel, apm.bob_rework.lib.entities.brassPipe,
    apm.bob_rework.lib.entities.brassUnderPipe, 'brass-chest',
})

unbind('electric-energy-distribution-1', 'steel-processing')
free('nitinol-processing')
free('bob-plasma-rocket')   
free('electric-rocket')
free('bob-shotgun-plasma-shells')
free('bob-shotgun-electric-shells')
free('bob-electric-bullets')
free('bob-plasma-bullets')
free('bob-atomic-artillery-shell')
free('rampant-arsenal-technology-regeneration-walls')
free('bob-electric-rocket')
free('bob-plasma-turrets-1')
free('reinforced-wall')
free('rampant-arsenal-technology-regeneration-turrets')

push('titanium-processing', apm.bob_rework.lib.entities.nitinolPipe)
push('titanium-processing', apm.bob_rework.lib.entities.nitinolUnderPipe)