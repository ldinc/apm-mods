local product    = require "lib.entities.product"
local bob        = require "lib.entities.bob"
local types      = require "lib.entities.types"
local assemblers = require "lib.entities.buildings.assemblers"
local flags      = require "lib.entities.flags"
local energy     = require "lib.entities.buildings.energy"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')

local hidden = {}

local find = function (name)
    for key, container in pairs(data.raw) do
    local prototype = container[name]
    local short = string.sub(key, 1, 4)
    if key ~= 'recipe' and  short ~= 'item' and prototype then
        return prototype
    end
end

return nil
end

local hide = function(name)
    local item = data.raw.item[name]

    if item then
        hidden[name] = 'item'
    else
        item = find(name)

        if item and item.type then
            hidden[name] = item.type
        end
    end
end

local hardDrop = function(recipe)
    local result = apm.lib.utils.recipe.result.get_first_result(recipe)
    apm.lib.utils.recipe.remove(recipe)
    hide(recipe)
    -- apm.lib.utils.item.delete_hard(result)
    -- apm.lib.utils.item.delete_hard(recipe)
end



apm.bob_rework.lib.override.drop = function()
    -- local rm = apm.lib.utils.recipe.remove
    local rm = hardDrop
    -- local hd = apm.lib.utils.item.delete_hard
    local hd = apm.lib.utils.item.remove

    local hide = function(name, type)
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

    local d = function(name, type)
        hide(name, type)
        rm(name)
        hd(name)
    end


    local resetUpgrades = function(name, type)
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

    -- rm('bob-plasma-rocket')

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

    rm('apm_crusher_drums')
    rm('apm_crusher_drums_used')
    rm('apm_press_plates')
    rm('apm_press_plates_used')
    rm('apm_machine_frame_basic_used')
    rm('apm_machine_frame_steam_used')
    rm('apm_machine_frame_advanced_used')
    rm('apm_burner_long_inserter')
    rm('apm_burner_miner_drill_2')
    rm('storage-tank-3')
    rm('bob-storage-tank-all-corners-3')
    rm('storage-tank-4')
    rm('bob-storage-tank-all-corners-4')
    rm('medium-electric-pole-3')
    rm('medium-electric-pole-4')
    rm('big-electric-pole-3')
    rm('big-electric-pole-4')
    rm('substation-3')
    rm('substation-4')
    rm('bob-pump-4')
    rm('bob-pump-5')
    rm('logistic-chest-active-provider-3')
    rm('logistic-chest-buffer-3')
    rm('logistic-chest-passive-provider-3')
    rm('logistic-chest-storage-3')
    rm('logistic-chest-requester-3')
    rm('express-inserter')
    rm('express-filter-inserter')
    rm('express-stack-inserter')
    rm('express-stack-filter-inserter')
    rm('nitinol-pipe')
    rm('nitinol-pipe-to-ground')
    rm('logistic-robot')
    rm('construction-robot')
    rm('bob-logistic-robot-4')
    rm('bob-construction-robot-4')
    rm('bob-roboport-3')
    rm('bob-roboport-4')
    rm('bob-logistic-zone-expander-3')
    rm('bob-logistic-zone-expander-4')
    rm('bob-robochest-3')
    rm('bob-robochest-4')
    rm('bob-robo-charge-port-large-3')
    rm('bob-robo-charge-port-large-4')
    rm('repair-pack-4')
    rm('repair-pack-5')
    rm('burner-reactor-2')
    rm('burner-reactor-3')
    rm('fluid-reactor-2')
    rm('electric-boiler-2')
    rm('electric-boiler-3')
    rm('electric-boiler-4')
    rm('electric-boiler-5')
    rm('boiler-4')
    rm('boiler-5')
    rm('oil-boiler-3')
    rm('oil-boiler-4')
    rm('steam-engine-4')
    rm('steam-engine-5')
    rm('fluid-generator-2')
    rm('fluid-generator-3')
    rm('bob-mining-drill-1')
    rm('bob-mining-drill-2')
    rm('bob-mining-drill-3')
    rm('bob-mining-drill-4')
    rm('bob-mining-drill-5')
    rm('bob-pumpjack-1')
    rm('bob-pumpjack-2')
    rm('bob-pumpjack-3')
    rm('bob-pumpjack-4')
    rm('bob-pumpjack-5')
    rm('air-pump-3')
    rm('air-pump-4')
    rm('water-pump-3')
    rm('water-pump-4')
    rm('electric-chemical-mixing-furnace-2')
    rm('centrifuge-2')
    rm('centrifuge-3')
    rm('oil-refinery-3')
    rm('oil-refinery-4')
    rm('wide-beacon')
    rm('mech-frame')
    rm('mech-leg')
    rm('mech-foot')
    rm('mech-hip')
    rm('mech-knee')
    rm('mech-leg-segment')
    rm('nuclear-fuel')
    rm('rocket-fuel')
    rm('deadlock-stack-iron-ore')
    rm('deadlock-stack-copper-ore')
    rm('deadlock-stack-stone')
    rm('deadlock-stack-coal')
    rm('deadlock-stack-wood')
    rm('deadlock-stack-iron-plate')
    rm('deadlock-stack-copper-plate')
    rm('deadlock-stack-steel-plate')
    rm('deadlock-stack-copper-cable')
    rm('deadlock-stack-iron-gear-wheel')
    rm('deadlock-stack-iron-stick')
    rm('deadlock-stack-sulfur')
    rm('deadlock-stack-plastic-bar')
    rm('deadlock-stack-solid-fuel')
    rm('deadlock-stack-battery')
    rm('deadlock-stack-uranium-ore')
    rm('deadlock-stack-uranium-235')
    rm('deadlock-stack-uranium-238')
    rm('nitinol-alloy')
    rm('electric-bullet')
    rm('electric-bullet-projectile')
    rm('electric-rocket-warhead')
    rm('rtg')
    rm('nitinol-bearing-ball')
    rm('roboport-antenna-3')
    rm('roboport-antenna-4')
    rm('roboport-door-3')
    rm('roboport-door-4')
    rm('roboport-chargepad-3')
    rm('roboport-chargepad-4')
    rm('flying-robot-frame-3')
    rm('flying-robot-frame-4')
    rm('robot-brain-combat')
    rm('robot-brain-combat-2')
    rm('robot-brain-combat-3')
    rm('robot-brain-combat-4')
    rm('robot-brain-construction')
    rm('robot-brain-construction-4')
    rm('robot-brain-logistic')
    rm('robot-brain-logistic-4')
    rm('robot-tool-combat')
    rm('robot-tool-combat-2')
    rm('robot-tool-combat-3')
    rm('robot-tool-combat-4')
    rm('robot-tool-construction')
    rm('robot-tool-construction-4')
    rm('robot-tool-logistic')
    rm('robot-tool-logistic-4')
    rm('deadlock-stack-electronic-circuit')
    rm('deadlock-stack-advanced-circuit')
    rm('deadlock-stack-processing-unit')
    rm('spidertron-cannon')
    rm('mortar-bomb')
    rm('mortar-cluster-bomb')
    rm('mortar-fire-bomb')
    rm('mortar-poison-bomb')
    rm('electric-bullet-magazine')
    rm('bob-electric-rocket')
    rm('shotgun-electric-shell')
    rm('self-repair-capsule-ammo-rampant-arsenal')

    rm('heat-exchanger-2')
    rm('heat-exchanger-3')
    rm('steam-turbine-2')
    rm('steam-turbine-3')
    rm('uranium-235')
    rm('uranium-238')
    rm('uranium-fuel-cell')
    rm('plutonium-fuel-cell')
    rm('used-up-uranium-fuel-cell')
    rm('thorium-plutonium-fuel-cell')
    -- rm('empty-nuclear-fuel-cell')
    rm('mech-brain')

    rm('bob-artillery-wagon-2')
    rm('bob-artillery-wagon-3')

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

    -- apm.lib.utils.debug.object(hidden)
    -- apm.lib.utils.debug.object(find('mortar-bomb'))
    -- apm.lib.utils.debug.object(find('bob-artillery-wagon-2'))
    

    for _, item in pairs(data.raw.item) do

        if item.place_result then
            local place_result = find(item.place_result)
            if place_result and place_result.next_upgrade then
                if hidden[place_result.next_upgrade] or hidden[item.name] then
                    place_result.next_upgrade = nil
                end
            end
        end
    end


    local blacklist = {
        ['car'] = {},
        ['artillery-wagon'] = {},
        ['fluid-wagon'] = {},
    }

    for name, type in pairs(hidden) do
        local item = data.raw[type][name]
        if item then
            if blacklist[type] then
                item.flags = { 'hidden' }
                local target = data.raw['item-with-entity-data']
                if target then
                    item.flags = { 'hidden' }
                end
            else
                item.flags = { 'hidden', 'hide-from-bonus-gui', 'hide-from-fuel-tooltip' }
            end
        end
    end
end
