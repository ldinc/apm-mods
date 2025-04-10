local product = require "lib.entities.product"
local combat  = require "lib.entities.combat"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local plates = require "lib.entities.plates"
local p = require('lib.entities.product')
local t = require('lib.tier.base')
local store = require('lib.entities.buildings.storages')
local robo = require('lib.entities.buildings.roboport')
local nuclear = require('lib.entities.nuclear')

local change2Tier = function()
    local items = {
        store.logistic.advance.provider.active,
        store.logistic.advance.provider.buffer,
        store.logistic.advance.provider.passive,
        store.logistic.advance.provider.requester,
        store.logistic.advance.provider.storage,
    }
    for _, key in pairs(items) do
        data.raw['logistic-container'][key].inventory_size = 96 -- x2 from 1 tier

        apm.lib.utils.recipe.ingredient.remove_all(key)
        apm.lib.utils.recipe.ingredient.mod(key, robo.antenna.advanced, 1)
        apm.lib.utils.recipe.ingredient.mod(key, store.chest.titanium, 1)
        apm.lib.utils.recipe.ingredient.mod(key, t.blue.logic, 5)
        apm.lib.utils.recipe.ingredient.mod(key, t.blue.extraLogic, 2)
    end

    local port = data.raw['roboport'][robo.port.advanced]
    port.construction_radius = 90
    port.logistics_radius = 90
end

local genAntenna = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 5)
    end
end

local genFrame = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 5)
    end
end

local genParts = function(brain, tool, tier)
    apm.lib.utils.recipe.ingredient.remove_all(brain)
    apm.lib.utils.recipe.ingredient.mod(brain, tier.wire, 5)
    apm.lib.utils.recipe.ingredient.mod(brain, tier.logic, 5)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(brain, tier.extraLogic, 5)
    end

    apm.lib.utils.recipe.ingredient.remove_all(tool)
    apm.lib.utils.recipe.ingredient.mod(tool, tier.bearing, 2)
    apm.lib.utils.recipe.ingredient.mod(tool, tier.gearWheel, 6)
    apm.lib.utils.recipe.ingredient.mod(tool, tier.constructionAlloy, 1)
end

local updateDescriptions = function()
    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.red, "Construction robot")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.red, "Logistic robot")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.blue, "Construction robot MK 2")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.blue, "Logistic robot MK 2")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.nuclear, "Fusion powered robot")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.nuclear, "Fusion powered robot")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.part.brain.red, "Construction robot brain")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.part.brain.red, "Logistic robot brain")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.part.brain.blue, "Construction robot brain MK 2")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.part.brain.blue, "Logistic robot brain MK 2")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.part.tool.red, "Construction robot tools")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.part.tool.red, "Logistic robot tools")

    apm.lib.utils.item.overwrite.localised_name(robo.bots.construction.part.tool.blue, "Construction robot tools MK 2")
    apm.lib.utils.item.overwrite.localised_name(robo.bots.logistic.part.tool.blue, "Logistic robot tools MK 2")
end


local updateBurnerInserter = function(recipe)
    local obj = data.raw['inserter'][recipe]

    if obj then
        obj.energy_source = {
            type = "void",
            emissions_per_minute = 5,
            fluid_box = {}
        }
    end
end

local modify = function()
    local update = function(recipe, storage, m)
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, robo.antenna.base, m * 3)
        apm.lib.utils.recipe.ingredient.mod(recipe, storage, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, t.red.logic, 5 * m)
        apm.lib.utils.recipe.ingredient.mod(recipe, t.red.extraLogic, 2)
    end

    local recipies = {
        store.logistic.basic.provider.active,
        store.logistic.basic.provider.buffer,
        store.logistic.basic.provider.passive,
        store.logistic.basic.provider.requester,
        store.logistic.basic.provider.storage,
    }

    for _, recipe in pairs(recipies) do
        update(recipe, store.chest.steel, 1)
    end

    recipies = {
        store.storehouse.provider.active,
        store.storehouse.provider.passive,
        store.storehouse.provider.storage,
        store.storehouse.provider.requester,
        store.storehouse.provider.buffer,
    }
    for _, recipe in pairs(recipies) do
        update(recipe, store.storehouse.basic, 3)
    end

    recipies = {
        store.warehouse.provider.active,
        store.warehouse.provider.passive,
        store.warehouse.provider.storage,
        store.warehouse.provider.requester,
        store.warehouse.provider.buffer,
    }
    for _, recipe in pairs(recipies) do
        update(recipe, store.warehouse.basic, 5)
    end

    local recipe = p.cliff.explosives
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.gun.powder, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 10)

    -- --change bots
    -- local recipe = robo.bots.construction.nuclear
    -- apm.lib.utils.recipe.ingredient.remove_all(recipe)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.blue, 1)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.nuclear, 1)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.deuterium.cell.I, 1)

    -- local recipe = robo.bots.logistic.nuclear
    -- apm.lib.utils.recipe.ingredient.remove_all(recipe)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.blue, 1)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.nuclear, 1)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.deuterium.cell.I, 1)

    genAntenna(robo.antenna.base, t.red)
    genAntenna(robo.antenna.advanced, t.blue)

    genFrame(robo.frame.basic, t.red)
    genFrame(robo.frame.advanced, t.blue)

    genParts(robo.bots.construction.part.brain.red, robo.bots.construction.part.tool.red, t.red)
    genParts(robo.bots.logistic.part.brain.red, robo.bots.logistic.part.tool.red, t.red)
    genParts(robo.bots.construction.part.brain.blue, robo.bots.construction.part.tool.blue, t.blue)
    genParts(robo.bots.logistic.part.brain.blue, robo.bots.logistic.part.tool.blue, t.blue)

    local recipe = robo.bots.construction.red
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.basic, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.brain.red, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.tool.red, 1)

    local recipe = robo.bots.construction.blue
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.advanced, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.brain.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.tool.blue, 1)

    local recipe = robo.bots.construction.nuclear
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.advanced, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.brain.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.part.tool.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.nuclear.advance, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.deuterium.cell.I, 1)

    local recipe = robo.bots.logistic.red
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.basic, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.brain.red, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.tool.red, 1)

    local recipe = robo.bots.logistic.blue
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.advanced, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.brain.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.tool.blue, 1)

    local recipe = robo.bots.logistic.nuclear
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.frame.advanced, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.brain.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.part.tool.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.nuclear.advance, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.deuterium.cell.I, 1)

    updateDescriptions()
    change2Tier()

    local recipe = 'apm_zx80_construction_robot'
    apm.lib.utils.item.mod.stack_size(recipe, 50)

    updateBurnerInserter('burner-inserter')
    updateBurnerInserter('apm_burner_filter_inserter')
end

modify()
