local tech      = require "lib.entities.tech"
local product   = require "lib.entities.product"
local alloys    = require "lib.entities.alloys"
local pipes     = require "lib.entities.pipes"
local bob       = require "lib.entities.bob"
local logistics = require "lib.entities.logistics"
local ores      = require "lib.entities.ores"
local combat    = require "lib.entities.combat"
local frames    = require "lib.entities.frames"
local recipies  = require "lib.entities.recipies"
local logic     = require "lib.entities.logic"
local inserters = require "lib.entities.buildings.inserters"
local rocket    = require "lib.entities.new.rocket"
local icons     = require "lib.icons"
local energy    = require "lib.entities.buildings.energy"
local labs      = require "lib.entities.buildings.labs"
local pumpjacks = require "lib.entities.buildings.pumpjacks"
local storages  = require "lib.entities.buildings.storages"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')
require('lib.utils.tech')
require('lib.utils.techtree')

local t = require('lib.entities.tech')

local function newTech(technology, t_icon, t_recipes, t_research_packs, i_research_count, i_research_time)
    mod_name = 'apm_bob_rework'
    new = {}
    new.type = 'technology'
    new.name = technology
    if t_icon == nil then
        new.icon = '__apm_bob_rework_resource_pack_ldinc__/graphics/technologies/' .. technology .. '.png'
        new.icon_size = 128
    else
        new.icon = t_icon.icon
        new.icon_size = t_icon.icon_size
    end
    new.effects = {}
    if t_recipes ~= nil then
        for _, name in pairs(t_recipes) do
            table.insert(new.effects, { type = 'unlock-recipe', recipe = name })
        end
    end
    -- new.prerequisites = t_prerequisites
    new.unit = {}
    new.unit.count = i_research_count
    new.unit.ingredients = t_research_packs
    new.unit.time = i_research_time
    new.order = 'a-a-a'
    data:extend({ new })

    APM_LOG_INFO(self, 'new()', 'create new technology: "' .. tostring(new.name) .. '"')
end

function apm.bob_rework.lib.override.tech()
    local off = apm.lib.utils.recipe.disable
    local on = apm.lib.utils.recipe.enable
    local push = apm.lib.utils.technology.add.recipe_for_unlock
    local rebind = function(base, sub)
        apm.lib.utils.technology.remove.prerequisites(sub, base)
        apm.lib.utils.technology.add.prerequisites(base, sub)
    end
    local rm = apm.lib.utils.technology.remove.recipe_from_unlock
    local drop = apm.lib.utils.technology.remove.science_pack
    local science = apm.lib.utils.technology.add.science_pack
    local free = function(name)
        apm.lib.utils.technology.disable(name)
        apm.lib.utils.technology.delete(name)
        -- force
        if data.raw.technology[name] then
            data.raw.technology[name] = nil
        end
    end
    local unbind = apm.lib.utils.technology.remove.prerequisites
    local bind = apm.lib.utils.technology.add.prerequisites
    local repush = function(from, to, item)
        rm(from, item)
        push(to, item)
    end
    local repushItems = function(from, to, items)
        for _, v in pairs(items) do
            repush(from, to, v)
        end
    end

    rm('apm_crusher_machine_0', 'apm_stone_crushed_1')
    push('apm_stone_bricks', 'apm_stone_crushed_1')

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
    off(product.bearing.balls.brass)
    off(product.bearing.balls.bronze)
    off(product.bearing.balls.ceramic)
    off(product.bearing.balls.cobalt.steel)
    off('steel-plate')
    off('apm_zinc')
    off('apm_stone_crushed_1')
    off('apm_gun_powder')
    off('repair-pack')
    off('incinerator')
    off(apm.bob_rework.lib.entities.steamInserter)
    off(apm.bob_rework.lib.entities.monel)


    push(tech.processing.cobalt, product.bearing.balls.cobalt.steel)
    push(tech.materials.ceramics, product.bearing.balls.ceramic)

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

    unbind('apm_power_steam', 'apm_puddling_furnace_0')
    bind('apm_power_steam', 'apm_coking_plant_0')

    unbind('apm_coking_plant_1', 'apm_assembler_machine_1')
    bind('apm_coking_plant_1', 'apm_steam_science_pack')
    bind('apm_assembler_machine_1', 'apm_treated_wood_planks-1')
    bind('apm_centrifuge_0', 'apm_treated_wood_planks-1')
    bind('apm_greenhouse-2', 'apm_treated_wood_planks-1')

    drop('rampant-arsenal-technology-shotgun', 'automation-science-pack')
    bind('electric-engine', 'apm_power_electricity')
    unbind('electric-engine', 'apm_power_automation_science_pack')
    repush('apm_power_automation_science_pack', 'apm_power_electricity',
        apm.bob_rework.lib.entities.electricGeneratorUnit)
    repush('explosives', 'military-2', 'mortar-gun-rampant-arsenal')
    repush('rampant-arsenal-technology-capsule-turret', 'military-2', 'slowdown-capsule-ammo-rampant-arsenal')
    repush('rampant-arsenal-technology-capsule-turret', 'military-2', 'poison-capsule-ammo-rampant-arsenal')

    push('apm_steam_science_pack', apm.bob_rework.lib.entities.steamInserter)

    -- alloy processing
    push(tech.processing.alloy, alloys.brass)
    push(tech.processing.alloy, product.gearwheel.brass)
    push(tech.processing.alloy, product.bearing.brass)
    push(tech.processing.alloy, product.bearing.balls.brass)
    push(tech.processing.alloy, pipes.base.brass)
    push(tech.processing.alloy, pipes.under.brass)
    rm(tech.processing.alloy, alloys.bronze)


    unbind('bob-distillery-2', 'alloy-processing')
    unbind('steel-mixing-furnace', 'alloy-processing')
    unbind('electronics', 'alloy-processing')
    unbind('alloy-processing', 'apm_power_automation_science_pack')
    unbind('invar-processing', 'alloy-processing')
    bind('alloy-processing', 'apm_coking_plant_0')
    bind('apm_power_steam', 'alloy-processing')
    drop('alloy-processing', 'apm_steam_science_pack')
    drop('alloy-processing', 'automation-science-pack')
    push('apm_coking_plant_0', 'apm_zinc')
    push('apm_stone_brick', 'apm_stone_crushed_1')

    push('apm_power_electricicty', 'incinerator')
    rebind('logistics', 'automation')
    rebind('automation', 'electric-engine')

    push('nickel-processing', apm.bob_rework.lib.entities.monel)
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

    repush('apm_fluid_control-1', 'apm_water_supply-1', 'apm_pump_0')

    unbind('fluid-handling', 'engine')
    unbind('fluid-handling', 'automation-2')
    bind('fluid-handling', 'electronics')
    drop('fluid-handling', 'logistic-science-pack')

    bind('electrolysis-1', 'fluid-handling')
    bind('rail-signals', 'electronics')
    bind('apm_water_supply-2', 'fluid-handling')

    bind('apm_steelworks-1', 'electronics')
    bind('apm_steelworks-1', 'nickel-processing')

    unbind('apm_electric_mining_drills', 'electronics')
    bind('apm_electric_mining_drills', 'electric-engine')

    unbind('concrete', 'advanced-material-processing')
    unbind('concrete', 'automation-2')
    bind('concrete', 'steel-processing')
    drop('concrete', 'apm_steam_science_pack')
    drop('concrete', 'automation-science-pack')
    drop('concrete', 'logistic-science-pack')

    bind('apm_steelworks-1', 'concrete')
    bind('bob-boiler-2', 'concrete')
    bind('bob-boiler-2', 'invar-processing')
    bind('bob-steam-engine-2', 'concrete')
    bind('bob-steam-engine-2', 'invar-processing')
    bind('fluid-generator-1', 'invar-processing')
    bind('logistic-science-pack', 'concrete')

    bind('air-compressor-1', 'invar-processing')
    bind('water-bore-1', 'invar-processing')
    bind('water-miner-2', 'invar-processing')

    drop('circuit-network', 'logistic-science-pack')
    unbind('circuit-network', 'logistic-science-pack')
    bind('circuit-network', 'steel-processing')

    drop('military-2', 'logistic-science-pack')
    unbind('military-2', 'logistic-science-pack')
    bind('military-2', 'apm_power_electricity')

    local f = function(t)
        bind(t, 'concrete')
        bind(t, 'electronics')
        drop(t, 'logistic-science-pack')
        drop(t, 'logistic-science-pack')
        drop(t, 'chemical-science-pack')
    end
    f('apm_centrifuge_2')
    f('apm_crusher_machine_2')
    f('apm_press_machine_2')
    f('apm_greenhouse-3')


    rm('military-2', 'piercing-rounds-magazine')
    rm('military-2', 'grenade')
    push('military', 'piercing-rounds-magazine')
    push('military', 'grenade')
    bind('gun-turret', 'apm_press_machine_0')
    bind('stone-wall', 'apm_press_machine_0')
    repush('apm_stone_bricks', 'alloy-processing', 'storage-tank')
    repushItems('zinc-processing', 'alloy-processing', {
        apm.bob_rework.lib.entities.brass,
        apm.bob_rework.lib.entities.gunMetal,
        apm.bob_rework.lib.entities.brassBearing, apm.bob_rework.lib.entities.brassBearingBall,
        apm.bob_rework.lib.entities.brassGearWheel, apm.bob_rework.lib.entities.brassPipe,
        apm.bob_rework.lib.entities.brassUnderPipe,
    })
    bind('electrolysis-1', 'apm_air_cleaner_machine')

    bind('bob-sniper-turrets-1', 'invar-processing')

    unbind('bob-turrets-2', 'steel-processing')
    unbind('bob-turrets-2', 'logistic-science-pack')
    bind('bob-turrets-2', 'apm_steam_science_pack')

    unbind('pumpjack', 'logistic-science-pack')
    unbind('pumpjack', 'electronics')
    bind('pumpjack', 'electric-engine')
    drop('pumpjack', 'logistic-science-pack')

    bind('oil-processing', 'invar-processing')
    unbind('apm_coking_plant_2', 'oil-processing')
    bind('apm_coking_plant_2', 'invar-processing')
    drop('apm_coking_plant_2', 'logistic-science-pack')

    drop('apm_equipment_burner_generator-1', 'chemical-science-pack')
    drop('apm_equipment_burner_generator-2', 'chemical-science-pack')
    unbind('apm_equipment_burner_generator-2', 'utility-science-pack')
    drop('apm_equipment_burner_generator-2', 'utility-science-pack')
    bind('apm_equipment_burner_generator-2', 'advanced-electronics-2')
    science('apm_equipment_burner_generator-2', 'chemical-science-pack')

    bind('electronics-machine-2', 'express-inserters')
    science('electronics-machine-2', 'chemical-science-pack')
    bind('automation-2', 'fast-inserter')
    bind('automation-3', 'fast-inserter')

    bind('radars-2', 'ceramics')
    science('radars-2', 'chemical-science-pack')

    bind('bob-repair-pack-3', 'ceramics')
    science('bob-repair-pack-3', 'chemical-science-pack')
    science('bob-repair-pack-4', 'chemical-science-pack')
    science('bob-repair-pack-5', 'chemical-science-pack')

    bind('bob-oil-boiler-2', 'ceramics')
    science('bob-oil-boiler-2', 'chemical-science-pack')
    bind('bob-boiler-3', 'ceramics')
    science('bob-boiler-3', 'chemical-science-pack')
    bind('bob-oil-boiler-3', 'ceramics')
    science('bob-oil-boiler-3', 'chemical-science-pack')

    -- bind('fluid-generator-2', 'ceramics')
    -- science('fluid-generator-2', 'chemical-science-pack')

    bind('bob-drills-2', 'ceramics')
    science('bob-drills-2', 'chemical-science-pack')
    bind('bob-area-drills-2', 'ceramics')
    science('bob-area-drills-2', 'chemical-science-pack')

    bind('bob-railway-2', 'ceramics')
    science('bob-railway-2', 'chemical-science-pack')

    bind('bob-steam-engine-3', 'ceramics')
    science('bob-steam-engine-3', 'chemical-science-pack')

    bind('warehouse-logistics-research-1', 'logistic-robotics')

    bind('bob-armoured-railway', 'ceramics')
    unbind('bob-armoured-railway', 'titanium-processing')
    bind('rocketry', 'tungsten-processing')
    bind('bob-robo-modular-2', 'ceramics')
    bind('bob-turrets-4', 'ceramics')
    unbind('bob-turrets-4', 'titanium-processing')
    bind('vehicle-motor-equipment', 'ceramics')
    bind('rampant-arsenal-technology-rocket-turret-1', 'ceramics')

    push(tech.fluid.control.extra, pipes.valve.check)
    push(tech.fluid.control.extra, pipes.valve.overflow)
    push(tech.fluid.control.extra, pipes.valve.topup)

    bind('bob-fluid-handling-3', 'tungsten-processing')
    bind('bob-fluid-handling-2', 'ceramics')
    bind('chemical-plant-2', 'bob-fluid-handling-2')
    bind('oil-processing-2', 'bob-fluid-handling-2')
    bind('electrolyser-3', 'bob-fluid-handling-2')
    bind('bob-distillery-3', 'bob-fluid-handling-2')
    bind('automation-4', 'express-inserters')
    bind('express-inserters', 'ceramics')
    bind('logistics-3', 'ceramics')
    bind('bob-sniper-turrets-2', 'ceramics')
    bind('tank', 'ceramics')
    bind('military-3', 'ceramics')
    bind('bob-robots-1', 'ceramics')
    bind('personal-roboport-mk2-equipment', 'ceramics')
    bind('electric-pole-3', 'chemical-science-pack')
    unbind('electric-pole-3', 'titanium-processing')

    unbind('electric-energy-distribution-2', 'chemical-science-pack')
    drop('electric-energy-distribution-2', 'chemical-science-pack')
    bind('electric-energy-distribution-2', 'invar-processing')

    bind('bob-armoured-fluid-wagon', 'bob-fluid-handling-2')
    unbind('bob-armoured-fluid-wagon', 'titanium-processing')
    unbind('bob-robotics-2', 'chemical-science-pack')
    drop('bob-robotics-2', 'chemical-science-pack')

    bind('bob-steam-engine-5', 'production-science-pack')
    unbind('apm_steelworks-2', 'low-density-structure')

    bind('electronics-machine-3', 'ultimate-inserter')
    bind('automation-5', 'ultimate-inserter')

    bind('production-science-pack', 'bob-fluid-handling-3')
    bind('utility-science-pack', 'bob-fluid-handling-4')

    unbind('automation-2', 'logistic-science-pack')
    unbind('automation-2', 'fast-inserter')
    drop('automation-2', 'logistic-science-pack')

    bind('radars', 'invar-processing')

    bind('apm_steelworks-2', 'advanced-electronics-3')

    unbind('electric-energy-distribution-1', 'steel-processing')
    repush('fluid-handling', 'plastics', 'empty-canister')

    repush('waterfill', 'uranium-processing', 'waterfill-green')
    repush('waterfill', 'uranium-processing', 'deepwaterfill-green')

    repush('electrolysis-1', 'apm_water_supply-1', 'bob-small-storage-tank')
    repush('electrolysis-1', 'apm_water_supply-1', 'bob-small-inline-storage-tank')

    repush('chemical-processing-1', 'apm_fertiliser_2', 'apm_ammonium_sulfate_chem')

    push('thorium-plutonium-fuel-cell', 'thorium-plutonium-fuel-cell')

    repush('military-2', 'military-3', 'poison-capsule-ammo-rampant-arsenal')
    repush('military-2', 'military-3', 'slowdown-capsule-ammo-rampant-arsenal')

    repush('military-3', 'military-2', combat.ammo.shotgun.piercing)

    -- free('nitinol-processing')
    -- free('bob-plasma-rocket')
    free('electric-rocket')
    -- free('bob-shotgun-plasma-shells')
    free('bob-shotgun-electric-shells')
    free('bob-electric-bullets')
    -- free('bob-plasma-bullets')
    free('bob-atomic-artillery-shell')
    free('rampant-arsenal-technology-regeneration-walls')
    free('bob-electric-rocket')
    -- free('bob-plasma-turrets-1')
    free('reinforced-wall')
    free('rampant-arsenal-technology-regeneration-turrets')
    -- free('bob-plasma-turrets-2')
    -- free('bob-plasma-turrets-3')
    -- free('bob-plasma-turrets-4')
    -- free('bob-plasma-turrets-5')

    rm(t.puddling.furnace, 'apm_burner_miner_drill_2')

    free('bob-wood-processing')

    free('bob-greenhouse')
    free('bob-fertiliser')
    free('void-fluid')
    free('fluid-furnace')
    free('bob-robot-plasma-drones')
    rm('apm_nuclear_rtg', 'apm_rtg_radioisotope_thermoelectric_generator')
    free('thorium-plutonium-fuel-cell')
    free('rtg')

    free('effect-transmission-3')
    free('effect-transmission-2')
    -- rm('effect-transmission-2', 'beacon-2')
    -- push('effect-transmission-2', 'beacon-3')

    free('turbo-inserter')
    free('ultimate-inserter')
    free('logistics-5')
    free('logistics-4')
    free('stack-inserter-5')
    free('stack-inserter-4')
    free('stack-inserter-3')

    free('oil-processing-4')
    free('oil-processing-3')

    free('bob-robots-4')
    push('bob-robots-3', 'bob-logistic-robot-5')
    push('bob-robots-3', 'bob-construction-robot-5')
    rm('bob-robots-3', 'bob-logistic-robot-4')
    rm('bob-robots-3', 'bob-construction-robot-4')
    rm('bob-robots-3', 'robot-brain-logistic-4')
    rm('bob-robots-3', 'robot-tool-logistic-4')
    rm('bob-robots-3', 'robot-brain-construction-4')
    rm('bob-robots-3', 'robot-tool-construction-4')

    rm('construction-robotics', 'construction-robot')
    rm('construction-robotics', 'robot-brain-construction')
    rm('construction-robotics', 'robot-tool-construction')
    rm('logistic-robotics', 'logistic-robot')
    rm('logistic-robotics', 'robot-brain-logistic')
    rm('logistic-robotics', 'robot-tool-logistic')

    free('multi-purpose-furnace-2')
    free('electric-pole-4')
    free('electric-pole-3')
    free('electric-substation-4')
    free('electric-substation-3')

    free('bob-steam-turbine-3')
    free('bob-steam-turbine-2')
    free('fluid-reactor-3')
    free('fluid-reactor-2')
    free('burner-reactor-3')
    free('burner-reactor-2')
    free('bob-steam-engine-5')
    free('bob-steam-engine-4')
    free('bob-heat-exchanger-3')
    free('bob-heat-exchanger-2')
    free('bob-oil-boiler-4')
    free('bob-oil-boiler-3')
    free('bob-boiler-5')
    free('bob-boiler-4')
    free('bob-steam-turbine-3')
    free('bob-steam-turbine-2')
    free('fluid-generator-3')
    free('fluid-generator-2')

    free('bob-solar-energy-4')
    free('bob-electric-energy-accumulators-4')
    free('air-compressor-4')
    free('air-compressor-3')
    free('water-bore-4')
    free('water-bore-3')
    free('bob-pumpjacks-4')
    free('bob-pumpjacks-3')
    free('bob-pumpjacks-2')
    free('bob-drills-4')
    free('bob-drills-3')
    -- free('bob-drills-2')


    free('logistic-system-3')

    free('bob-fluid-handling-4')
    rm('bob-fluid-handling-3', "storage-tank-3")
    rm('bob-fluid-handling-3', "bob-storage-tank-all-corners-3")

    rm('automation', 'assembling-machine-1')

    free('heavy-spidertron')
    free('logistic-spidertron')
    free('spidertron')
    free('tankotron')
    free('walking-vehicle')

    free('bob-robo-modular-4')
    free('bob-robo-modular-3')
    free('bob-repair-pack-5')
    free('bob-repair-pack-4')

    free('vehicle-fusion-cell-equipment-6')
    free('vehicle-fusion-cell-equipment-5')
    free('vehicle-fusion-cell-equipment-4')
    free('vehicle-fusion-cell-equipment-3')
    free('vehicle-fusion-cell-equipment-2')
    free('vehicle-fusion-cell-equipment-1')

    free('vehicle-solar-panel-equipment-6')
    free('vehicle-solar-panel-equipment-5')

    push('apm_power_electricity', 'kr-sentinel')
    push('deuterium-fuel-cell-2', 'kr-antimatter-reactor')

    push('bob-drills-1', 'kr-electric-mining-drill-mk2')
    push('bob-drills-2', 'kr-electric-mining-drill-mk3')
    rm('bob-drills-1', 'bob-mining-drill-1')
    rm('bob-drills-2', 'bob-mining-drill-2')

    free('bob-turrets-5')
    free('bob-turrets-4')
    free('follower-robot-count-7')
    free('follower-robot-count-6')
    free('follower-robot-count-5')
    free('destroyer')
    free('follower-robot-count-4')
    free('follower-robot-count-3')
    free('follower-robot-count-2')
    free('follower-robot-count-1')
    free('defender')
    free('bob-laser-robot')
    free('distractor')
    free('bob-sniper-turrets-3')
    free('bob-sniper-turrets-2')
    free('bob-robot-gun-drones')
    free('bob-robot-laser-drones')
    free('bob-robot-flamethrower-drones')
    free('bob-laser-turrets-5')
    free('bob-laser-turrets-4')
    free('radars-5')
    free('radars-4')
    free('radars-3')

    free('apm_tools_1')
    free('apm_tools_0')

    free('bob-armor-making-4')
    free('bob-armor-making-3')
    free('solar-panel-equipment-4')
    free('solar-panel-equipment-3')
    free('fusion-reactor-equipment-4')
    free('fusion-reactor-equipment-3')
    free('fusion-reactor-equipment-2')

    free('rampant-arsenal-technology-battery-equipment-3')
    free('bob-battery-equipment-6')
    free('bob-battery-equipment-5')
    free('exoskeleton-equipment-3')

    free('personal-roboport-modular-equipment-4')
    free('personal-roboport-modular-equipment-3')
    free('personal-roboport-modular-equipment-2')
    free('personal-roboport-modular-equipment-1')

    free('night-vision-equipment-3')
    free('night-vision-equipment-2')
    free('vehicle-roboport-equipment-4')
    free('vehicle-roboport-equipment-3')
    free('vehicle-roboport-equipment-2')
    free('vehicle-roboport-equipment')
    free('vehicle-roboport-modular-equipment-4')
    free('vehicle-roboport-modular-equipment-3')
    free('vehicle-roboport-modular-equipment-2')
    free('vehicle-roboport-modular-equipment-1')

    free('vehicle-energy-shield-equipment-6')
    free('vehicle-energy-shield-equipment-5')

    free('vehicle-laser-defense-equipment-6')
    free('vehicle-laser-defense-equipment-5')
    free('vehicle-laser-defense-equipment-4')
    free('vehicle-laser-defense-equipment-3')
    free('vehicle-battery-equipment-6')
    free('vehicle-battery-equipment-5')

    free('bob-energy-shield-equipment-6')
    free('bob-energy-shield-equipment-5')

    free('personal-laser-defense-equipment-6')
    free('personal-laser-defense-equipment-5')
    free('personal-laser-defense-equipment-4')
    free('personal-laser-defense-equipment-3')

    free('bob-turrets-3')
    free('bob-laser-turrets-3')
    free('bob-artillery-turret-3')
    free('bob-artillery-turret-2')

    free('personal-roboport-mk4-equipment')
    free('personal-roboport-mk3-equipment')
    free('vehicle-fusion-reactor-equipment-6')
    free('vehicle-fusion-reactor-equipment-5')
    free('vehicle-fusion-reactor-equipment-4')
    free('vehicle-fusion-reactor-equipment-3')
    free('vehicle-fusion-reactor-equipment-2')
    free('vehicle-fusion-reactor-equipment-1')

    free('bob-robotics-4')
    free('bob-robotics-3')

    free('centrifuge-3')
    free('centrifuge-2')

    free('bob-armoured-railway-2')
    free('bob-railway-3')
    free('bob-railway-2')
    free('bob-artillery-wagon-3')
    free('bob-artillery-wagon-2')

    free('bob-tanks-3')
    free('bob-tanks-2')
    free('nitinol-processing')

    push(t.processing.cobalt, 'electric-engine-unit-2')
    push(t.processing.cobalt, 'engine-unit-2')
    push(t.processing.cobalt, 'apm_egen_unit-2')
    push(t.processing.titaniumAlloy, 'electric-engine-unit-3')
    push(t.processing.titaniumAlloy, 'engine-unit-3')
    push(t.processing.titaniumAlloy, 'apm_egen_unit-3')
    push(t.science.automation, 'apm_machine_frame_steam-2')
    push(t.electronics.advanced.I, frames.basic)
    rm(product.sieve)
    on(product.sieve)

    push(t.fluid.control.basic, pipes.base.copper)
    push(t.fluid.control.basic, pipes.under.copper)
    push(t.logistics.basic, logistics.belt.slow)

    push(t.crusher.burner, ores.crushed.basic.aluminium)
    push(t.crusher.burner, ores.crushed.basic.cobalt)
    push(t.crusher.burner, ores.crushed.basic.copper)
    push(t.crusher.burner, ores.crushed.basic.gold)
    push(t.crusher.burner, ores.crushed.basic.iron)
    push(t.crusher.burner, ores.crushed.basic.lead)
    push(t.crusher.burner, ores.crushed.basic.nickel)
    push(t.crusher.burner, ores.crushed.basic.silver)
    push(t.crusher.burner, ores.crushed.basic.tin)
    push(t.crusher.burner, ores.crushed.basic.titanium)
    push(t.crusher.burner, ores.crushed.basic.tungsten)
    push(t.crusher.burner, ores.crushed.basic.zinc)

    push(t.crusher.burner, combat.ammo.magazine.firearm)

    push(t.press.burner, product.bearing.balls.bronze)

    push(t.sieve.burner, ores.enriched.basic.aluminium)
    push(t.sieve.burner, ores.enriched.basic.cobalt)
    push(t.sieve.burner, ores.enriched.basic.copper)
    push(t.sieve.burner, ores.enriched.basic.gold)
    push(t.sieve.burner, ores.enriched.basic.iron)
    push(t.sieve.burner, ores.enriched.basic.nickel)
    push(t.sieve.burner, ores.enriched.basic.silver)
    push(t.sieve.burner, ores.enriched.basic.tin)
    push(t.sieve.burner, ores.enriched.basic.lead)
    push(t.sieve.burner, ores.enriched.basic.titanium)
    push(t.sieve.burner, ores.enriched.basic.tungsten)
    push(t.sieve.burner, ores.enriched.basic.zinc)
    rm(t.sieve.steam, product.sieve.iron)
    push(t.sieve.burner, product.sieve.iron)

    rm(t.processing.zinc, bob.recipe.zinc)
    push(t.processing.sulfur, bob.recipe.zinc)

    rm(t.science.automation, recipies.frames.advanced)
    push(t.electricity, recipies.frames.advanced)
    push(t.electronics.basic, logic.circuit.low)
    rm(t.electricity, frames.advanced)
    push(t.electronics.advanced.II, frames.advanced)
    rm(t.electronics.basic, inserters.filter.yellow)
    push(t.automation.electric.basic, inserters.filter.yellow)

    rm(t.processing.sulfur, recipies.chemistry.petroleum.gas.sweetening)
    push(t.processing.oil.basic, recipies.chemistry.petroleum.gas.sweetening)

    push(t.electrolysis.II, recipies.chemistry.plastic.old)

    rm(t.processing.titanium, product.gearwheel.titanium)
    push(t.processing.titaniumAlloy, product.gearwheel.titanium)
    rm(t.processing.titanium, product.bearing.titanium)
    push(t.processing.titaniumAlloy, product.bearing.titanium)
    rm(t.processing.titaniumAlloy, product.bearing.ball.titanium)

    rm(t.combat.rocket.silo, rocket.engine)
    push(t.combat.rocketry, rocket.engine)

    rm(t.electricity, energy.pole.small)
    push(t.materials.rubber.basic, energy.pole.small)


    rm(t.fluid.barrel, 'empty-barrel')
    push(t.fluid.control.extra, pumpjacks.burner)
    push(t.fluid.control.extra, 'empty-barrel')
    push(t.fluid.control.extra, 'apm_fill-crude-oil-barrel')
    push(t.processing.oil.basic, 'apm_fill-heavy-oil-barrel')
    push(t.processing.oil.basic, 'apm_fill-light-oil-barrel')


    free('fluid-canister-processing')
    free(bob.tech.automation.basic)
    free('apm_burner_long_inserter')
    free('bob-area-drills-4')
    free('bob-area-drills-3')
    free('bob-area-drills-2')
    free('bob-area-drills-1')
    free('water-miner-5')
    free('water-miner-4')
    free('water-miner-3')
    free('water-miner-2')
    free('water-miner-1')
    free('distractor-mine')
    free('bob-heat-exchanger-4')
    free('bob-oil-boiler-4')
    free('bob-heat-pipe-4')
    -- free('radars')

    local tname = 'long-inserters-1'
    local spdrop = function(sp)
        apm.lib.utils.technology.remove.science_pack(tname, sp)
    end
    local rbind = function(from, to)
        apm.lib.utils.technology.remove.prerequisites(tname, from)
        apm.lib.utils.technology.add.prerequisites(tname, to)
    end
    spdrop('automation-science-pack')
    spdrop('apm_steam_science_pack')
    rbind('logistics', 'logistics-0')

    tname = 'near-inserters'
    spdrop('automation-science-pack')
    spdrop('apm_steam_science_pack')
    rbind('logistics', 'logistics-0')

    tname = 'more-inserters-1'
    spdrop('logistic-science-pack')
    rbind('logistics-2', 'logistics')

    tname = 'more-inserters-2'
    spdrop('chemical-science-pack')
    spdrop('advanced-logistic-science-pack')
    bind(tname, 'logistics-2')

    tname = 'long-inserters-2'
    spdrop('chemical-science-pack')
    rbind('logistics-3', 'logistics-2')

    rm(t.processing.alloy, alloys.brass)

    rm(t.science.logistics, labs.basic)
    push(t.electronics.advanced.I, labs.basic)
    push(t.electricity, energy.generator.burner)

    rm(t.fluid.control.basic, storages.tank.small.basic)
    rm(t.fluid.control.basic, storages.tank.small.inline)

    push(t.sieve.burner, 'apm_dry_mud_util')
    push(t.sieve.burner, 'apm_dry_mud_util_stacked')

    free('basic-transport-belt-beltbox')
    free('deadlock-stacking-0')
    free('deadlock-stacking-1')
    free('deadlock-stacking-2')
    free('deadlock-stacking-3')

    -- push('logistics', 'transport-belt-beltbox-loader')
    -- push('logistics-2', 'fast-transport-belt-beltbox-loader')
    -- push('logistics-3', 'express-transport-belt-beltbox-loader')
    -- push('logistics', 'transport-belt-beltbox-beltbox')
    -- push('logistics-2', 'fast-transport-belt-beltbox-loader')
    -- push('logistics-3', 'express-transport-belt-beltbox-loader')

    repush('ironclad', 'military-2', combat.turret.mortar.base)
    repush('military-2', 'military-3', combat.radar.base)
    repush('military-3', 'military-4', 'fire-capsule')
    -- repush('military-2', 'military-3', combat.turret.mortar.portable)
    free('ironclad')
    free('ironclad-gunboat')

    push('concrete', pipes.sinkhole.small)

    push(tech.processing.coke.I, 'apm_gun_powder_from_crhushed_coke')
    push(tech.processing.coke.I, 'apm_gun_powder_from_charcoal')

    free('rampant-arsenal-technology-lite-artillery')

    free('apm_nuclear_fuel')
    rm('rocket-fuel', 'rocket-fuel')

    free('apm_particle_filter-3')
    free('apm_particle_filter-2')
    free('apm_particle_filter')

    push('apm_stone_bricks', 'apm_dry_to_wet_mud')

    apm.lib.utils.technology.remove.prerequisites_all('long-inserters-1')
    apm.lib.utils.technology.remove.prerequisites_all('near-inserters')
    apm.lib.utils.technology.remove.prerequisites_all('more-inserters-1')

    apm.lib.utils.technology.remove.science_pack('more-inserters-1', 'automation-science-pack')
    apm.lib.utils.technology.remove.science_pack('more-inserters-1', 'apm_steam_science_pack')

    bind('long-inserters-1', 'apm_crusher_machine_0')
    bind('near-inserters', 'apm_crusher_machine_0')
    bind('more-inserters-1', 'apm_crusher_machine_0')


    -- fix yellow science pack tech icon
    apm.lib.utils.technology.mod.icon(t.science.automation, '__base__/graphics/technology/utility-science-pack.png')

    -- Adding new tech
    local c = ores.crushed.advance
    local list = { c.aluminium, c.cobalt, c.copper, c.gold, c.iron, c.lead, c.nickel, c.silver, c.tin, c.titanium, c
        .tungsten, c.zinc }
    local ico = {
        icon = icons.path.ore.crushed,
        icon_size = 64,
    }

    -- fix rampantcharacter hp bonus tech
    apm.lib.utils.technology.remove.prerequisites('rampant-arsenal-technology-character-health-1',
        'rampant-arsenal-technology-regeneration')
    apm.lib.utils.technology.add.prerequisites('rampant-arsenal-technology-character-health-1', 'military-2')
    apm.lib.utils.technology.add.prerequisites('rampant-arsenal-technology-character-health-1', 'logistic-science-pack')
    apm.lib.utils.technology.add.prerequisites('rampant-arsenal-technology-character-health-1', 'military-science-pack')

    newTech(t.ore.crushing.advanced, ico, list, {}, 200, 20)

    local ico = {
        icon = icons.path.ore.enriched,
        icon_size = 64,
    }
    local c = ores.enriched.basic
    local list = { c.aluminium, c.cobalt, c.copper, c.gold, c.iron, c.lead, c.nickel, c.silver, c.tin, c.titanium, c
        .tungsten, c.zinc }
    newTech(t.ore.enrichment.base, ico, list, {}, 15, 10)

    local c = ores.enriched.advance
    local list = { c.aluminium, c.cobalt, c.copper, c.gold, c.iron, c.lead, c.nickel, c.silver, c.tin, c.titanium, c
        .tungsten, c.zinc }
    newTech(t.ore.enrichment.advanced, ico, list, {}, 150, 30)

    if settings.startup['apm_bob_rework_experimental_tech_tree_rebuilder'].value == true then
        apm.bob_rework.lib.utils.tech.tree.rebuild(t.crusher.burner)
    end
end
