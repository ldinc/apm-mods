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
    local recipe = aircleaners.basic
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 5)

    recipe = aircleaners.advanced
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.iron, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 5)

    recipe = sieves.steam
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 5)

    recipe = sieves.basic
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.sieve.iron, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.basement, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.logic, 2)
end
