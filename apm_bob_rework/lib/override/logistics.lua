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

local modify = function()
    local recipies = {
        store.logistic.basic.provider.active,
        store.logistic.basic.provider.buffer,
        store.logistic.basic.provider.passive,
        store.logistic.basic.provider.requester,
        store.logistic.basic.provider.storage,

        store.storehouse.provider.active,
        store.storehouse.provider.passive,
        store.storehouse.provider.storage,
        store.storehouse.provider.requester,
        store.storehouse.provider.buffer,

        store.warehouse.provider.active,
        store.warehouse.provider.passive,
        store.warehouse.provider.storage,
        store.warehouse.provider.requester,
        store.warehouse.provider.buffer,
    }
    for _, recipe in pairs(recipies) do
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, robo.antenna.basic, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, store.chest.steel, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, t.red.logic, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, t.red.extraLogic, 2)
    end

    local recipe = p.cliff.explosives
    apm.lib.utils.recipe.ingredient.mod(recipe, p.explosives, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.gun.powder, 160)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.barrel.empty, 0)

    --change bots
    local recipe = robo.bots.construction.nuclear
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.construction.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.rtg, 1)

    local recipe = robo.bots.logistic.nuclear
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, robo.bots.logistic.blue, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.rtg, 1)

    change2Tier()
end

modify()
