local steelworks = require "lib.entities.buildings.steelworks"
local plates     = require "lib.entities.plates"
local materials  = require "lib.entities.materials"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

apm.bob_rework.lib.override.steelworks = function ()
    local recipe = steelworks.pudding.furnace
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.constructionAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.brick, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.pipe, 5)

    recipe = steelworks.basic
    local tier = t.yellow
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 14)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.concrete, 20)

    recipe = steelworks.advanced
    tier = t.blue
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 18)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 18)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.refined.concrete, 20)
end
