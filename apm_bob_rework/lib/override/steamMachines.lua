local sieves = require "lib.entities.buildings.sieves"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local aircleaners = require "lib.entities.buildings.aircleaners"
local pipes = require "lib.entities.pipes"
local product = require "lib.entities.product"
local plates = require "lib.entities.plates"
local t = require('lib.tier.base')
local tier = t.steam

apm.bob_rework.lib.override.steamMachines = function()

    local recipe = ''
    local reset = function () apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function (p, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, p, cnt)  end

    recipe = aircleaners.basic
    reset()
    add(tier.engineUnit, 5)
    add(tier.pipe, 10)
    add(tier.constructionAlloy, 5)
    add(plates.copper, 2)
    add(tier.basement, 15)
    add(tier.logic, 5)
    add(product.rubber, 5)

    recipe = aircleaners.advanced
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    add(tier.engineUnit, 10)
    add(pipes.base.iron, 10)
    add(tier.constructionAlloy, 5)
    add(plates.copper, 5)
    add(tier.basement, 10)
    add(tier.logic, 5)
    add(product.rubber, 5)
    add(tier.frame, 3)

    recipe = sieves.steam
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    add(tier.engineUnit, 2)
    add(tier.pipe, 5)
    add(tier.constructionAlloy, 10)
    add(plates.copper, 4)
    add(tier.basement, 15)
    add(tier.logic, 2)
    add(product.rubber, 5)
    add(tier.frame, 3)

    recipe = sieves.basic
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    add(t.gray.engineUnit, 2)
    add(t.gray.pipe, 5)
    add(t.gray.constructionAlloy, 10)
    add(product.sieve.iron, 4)
    add(t.gray.basement, 15)
    add(t.gray.logic, 2)
end
