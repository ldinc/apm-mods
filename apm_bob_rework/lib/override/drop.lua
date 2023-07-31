local product = require "lib.entities.product"
local bob     = require "lib.entities.bob"
local types   = require "lib.entities.types"
local assemblers = require "lib.entities.buildings.assemblers"
local flags      = require "lib.entities.flags"
local energy     = require "lib.entities.buildings.energy"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')



apm.bob_rework.lib.override.drop = function()
    local rm = apm.lib.utils.recipe.remove
    -- local hd = apm.lib.utils.item.delete_hard
    local hd = apm.lib.utils.item.remove

    local hide = function (name, type)
        local base = data.raw[type]
        if base == nil then
            return
        end
        local entity = base[name]
        if entity == nil then
            return
        end
        apm.lib.utils.entity.add.flag(entity, flags.notmadein)
        apm.lib.utils.entity.add.flag(entity, flags.hidden)
    end

    local d = function (name, type)
        hide(name, type)
        rm(name)
        hd(name)
    end


    local resetUpgrades = function (name, type)
        local base = data.raw[type]
        if base == nil then
            return
        end
        local entity = base[name]
        if entity and entity.next_upgrade then
            entity.next_upgrade = nil
        end
    end


    rm('apm_gearing')
    rm('wood-pellets')

    rm('boiler-2-from-oil-boiler')
    rm('boiler-3-from-heat-exchanger')
    rm('boiler-3-from-oil-boiler-2')
    rm('boiler-4-from-heat-exchanger-2')
    rm('boiler-4-from-oil-boiler-3')
    rm('boiler-5-from-heat-exchanger-4')
    rm('boiler-5-from-heat-exchanger-3')
    rm('boiler-5-from-oil-boiler-4')
    rm('oil-boiler-2-from-boiler-3')
    rm('oil-boiler-3-from-boiler-4')
    rm('oil-boiler-4-from-boiler-5')


    rm('wooden-pellets')

    -- rm('bob-area-mining-drill-1')
    -- rm('bob-area-mining-drill-2')
    -- rm('bob-area-mining-drill-3')
    -- rm('bob-area-mining-drill-4')

    rm('stone-furnace-from-stone-chemical-furnace')
    rm('stone-furnace-from-stone-mixing-furnace')
    rm('steel-furnace-from-fluid-furnace')
    rm('steel-furnace-from-steel-chemical-furnace')
    rm('steel-furnace-from-steel-mixing-furnace')
    rm('steel-furnace-from-fluid-mixing-furnace')
    rm('electric-furnace-from-electric-chemical-furnace')
    rm('electric-furnace-from-electric-mixing-furnace')
    rm('stone-chemical-furnace-from-stone-furnace')
    rm('steel-chemical-furnace-from-fluid-chemical-furnace')
    rm('steel-chemical-furnace-from-steel-furnace')
    rm('steel-chemical-furnace-from-fluid-furnace')
    rm('stone-mixing-furnace-from-stone-furnace')
    rm('steel-mixing-furnace-from-fluid-mixing-furnace')
    rm('steel-mixing-furnace-from-steel-furnace')
    rm('steel-mixing-furnace-from-fluid-furnace')
    rm('electric-chemical-furnace-from-electric-furnace')
    rm('electric-mixing-furnace-from-electric-furnace')
    rm('fluid-furnace-from-fluid-chemical-furnace')
    rm('fluid-furnace-from-fluid-mixing-furnace')
    rm('fluid-chemical-furnace-from-fluid-furnace')
    rm('fluid-mixing-furnace-from-fluid-furnace')

    rm('offshore-pump')

    rm('heat-exchanger-2-from-boiler-4')
    rm('heat-exchanger-3-from-boiler-5')
    rm('fluid-reactor-from-fluid-furnace')

    rm('stone-furnace')
    rm('steel-furnace')
    rm('fluid-furnace')
    rm('electric-furnace')
    rm('electric-furnace-2')
    rm('electric-furnace-3')

    rm(apm.bob_rework.lib.entities.stonePipe)
    rm(apm.bob_rework.lib.entities.stoneUnderPipe)
    rm(apm.bob_rework.lib.entities.plasticPipe)
    rm(apm.bob_rework.lib.entities.plasticUnderPipe)

    rm('bob-greenhouse')

    rm('advanced-car-vehicle-rampant-arsenal')
    rm('advanced-tank-vehicle-rampant-arsenal')
    rm('nuclear-car-vehicle-rampant-arsenal')
    rm('nuclear-tank-vehicle-rampant-arsenal')

    rm('bob-power-armor-mk3')
    rm('bob-power-armor-mk4')
    rm('bob-power-armor-mk5')

    rm('bob-plasma-rocket')

    rm(apm.bob_rework.lib.entities.nitinol)
    rm(apm.bob_rework.lib.entities.nitinolGearWheel)
    rm(apm.bob_rework.lib.entities.nitinolBearing)

    rm('shotgun-passive-defence-rampant-arsenal')
    rm('cannon-passive-defence-rampant-arsenal')
    rm('lightning-passive-defence-rampant-arsenal')
    rm('bullets-passive-defence-rampant-arsenal')
    rm('slow-passive-defence-rampant-arsenal')
    rm('self-repair-capsule-ammo-rampant-arsenal')
    rm('repair-capsule-ammo-rampant-arsenal')
    rm('nuclear-landmine-capsule-ammo-rampant-arsenal')
    rm('nuclear-landmine-rampant-arsenal')
    rm('repair-capsule-rampant-arsenal')
    rm('speed-capsule-rampant-arsenal')
    rm('healing-capsule-rampant-arsenal')
    rm('he-grenade-capsule-rampant-arsenal')
    rm('he-grenade-capsule-ammo-rampant-arsenal')

    rm('shotgun-passive-defense-rampant-arsenal')
    rm('cannon-passive-defense-rampant-arsenal')
    rm('lightning-passive-defense-rampant-arsenal')
    rm('bullets-passive-defense-rampant-arsenal')
    rm('slow-passive-defense-rampant-arsenal')
    rm('posion-mine')

    rm('apm_iron_bearing')
    rm('apm_iron_bearing_ball')
    rm('tungsten-gear-wheel')
    rm('tungsten-gear-wheel')
    rm('void-pump')

    -- drop bob's high tier buildings (green & purple)
    rm('bob-distillery-4')
    rm('bob-distillery-5')
    rm('assembling-machine-5')
    rm('assembling-machine-6')
    -- rm('chemical-plant-3')
    rm('chemical-plant-4')
    rm('electrolyser-4')
    rm('electrolyser-5')
    rm('electronics-machine-1')
    rm('electronics-machine-2')
    rm('electronics-machine-3')
    rm('beacon-2')
    -- rm('beacon-3')
    -- drop belts & inserters (green & purple)
    rm('turbo-transport-belt')
    rm('turbo-underground-belt')
    rm('turbo-splitter')
    rm('purple-loader')
    rm('turbo-inserter')
    rm('turbo-filter-inserter')
    rm('turbo-stack-inserter')
    rm('turbo-stack-filter-inserter')

    rm('ultimate-transport-belt')
    rm('ultimate-underground-belt')
    rm('ultimate-splitter')
    rm('green-loader')
    rm('ultimate-inserter')
    rm('ultimate-filter-inserter')
    rm('ultimate-stack-inserter')
    rm('ultimate-stack-filter-inserter')

    rm('apm_sieve_copper')
    rm('apm_dry_mud_sifting_iron')
    rm('apm_dry_mud_sifting_copper')

    rm('apm_electric_bob-locomotive-2')
    rm('apm_electric_bob-locomotive-3')
    rm('apm_electric_bob-armoured-locomotive-2')
    rm('apm_electric_bob-tank-2')
    rm('apm_electric_bob-tank-3')

    rm('bob-fluid-wagon-2')
    rm('bob-fluid-wagon-3')
    rm('bob-armoured-fluid-wagon-2')
    rm('brass-chest')

    rm(product.bearing.balls.titanium)
    rm(product.bearing.ceramic)

    rm('bob-logistic-zone-interface')
    rm('bob-robo-charge-port')
    rm('bob-robo-charge-port-2')
    rm('bob-robo-charge-port-3')
    rm('bob-robo-charge-port-4')
    rm('robot-drone-frame-large')
    rm('robot-drone-frame')

    rm('bob-logistic-zone-expander')
    rm('bob-logistic-zone-expander-2')
    rm('bob-robo-charge-port-large')
    rm('bob-robo-charge-port-large-2')

    rm('vehicle-solar-panel-1')
    rm('vehicle-solar-panel-2')
    rm('vehicle-solar-panel-3')
    rm('vehicle-solar-panel-4')
    rm('vehicle-shield-1')
    rm('vehicle-shield-2')
    rm('vehicle-shield-3')
    rm('vehicle-shield-4')
    rm('vehicle-battery-1')
    rm('vehicle-battery-2')
    rm('vehicle-battery-3')
    rm('vehicle-battery-4')
    rm('vehicle-laser-defense-1')
    rm('vehicle-laser-defense-2')
    rm('vehicle-belt-immunity-equipment')

    rm('iron-gear-wheel')
    rm('steel-bearing')
    rm('steel-bearing-ball')
    rm('steel-gear-wheel')

    rm('cobalt-steel-bearing-ball')
    rm('ceramic-bearing-ball')
    rm('titanium-bearing-ball')

    -- rm(bob.valve.check)
    -- rm(bob.valve.overflow)
    -- rm(bob.valve.topup)

    rm('apm_boiler_2')
    rm('apm_steam_engine_2')
    rm('boiler-3')
    rm('steam-mining-drill')

    rm(energy.generator.steam.drop.extra)

    -- resetUpgrades(assemblers.steam, types.assemblers)
    resetUpgrades(bob.assembler.burner, types.assemblers)
    resetUpgrades(bob.assembler.steam, types.assemblers)
    resetUpgrades(bob.assembler.electric.base, types.assemblers)
    -- resetUpgrades(bob.assembler.electric.yellow, types.assemblers)
    -- resetUpgrades(bob.assembler.electric.red, types.assemblers)
    resetUpgrades(bob.assembler.electric.blue, types.assemblers)
    resetUpgrades(bob.assembler.electric.green, types.assemblers)
    resetUpgrades(bob.assembler.electric.purple, types.assemblers)

    resetUpgrades(bob.assembler.electronics.yellow, types.assemblers)
    resetUpgrades(bob.assembler.electronics.green, types.assemblers)
    resetUpgrades(bob.assembler.electronics.blue, types.assemblers)

    d(bob.assembler.burner, types.assemblers)
    d(bob.assembler.steam, types.assemblers)
    d(bob.assembler.electric.purple, types.assemblers)
    d(bob.assembler.electric.green, types.assemblers)
    d(bob.assembler.electric.base, types.assemblers)
    d(bob.assembler.electronics.green, types.assemblers)
    d(bob.assembler.electronics.blue, types.assemblers)
    d(bob.assembler.electronics.yellow, types.assemblers)

-- ????    apm.lib.utils.item.delete_hard

    -- unused entities
    -- hd('bob-artillery-wagon-2')
    -- hd('bob-cargo-wagon-2')
    -- hd('bob-gun-turret-3')
    -- hd('bob-laser-turret-3')
    -- hd('bob-locomotive-2')
    -- hd('bob-sniper-turret-2')
    -- hd('heavy-armor-2')
    -- hd('personal-laser-defense-equipment-3')
    -- hd('vehicle-laser-defense-3')
    -- hd('bob-fluid-wagon-2')
    -- hd('bob-plasma-turret-3')
    -- hd('bob-power-armor-mk3')
    -- hd('vehicle-big-turret-3')
    -- hd('fluid-generator-2')
    -- hd('electric-furnace-2')
end
