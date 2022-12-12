if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildBelts = function(tier)
    local recipe = tier.belt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 2)
    apm.lib.utils.recipe.result.mod(recipe, recipe, 2)

    local recipe = tier.underBelt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)

    local recipe = tier.splitter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)


    local recipe = tier.loader
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    end
end

apm.bob_rework.lib.override.belts = function()
    buildBelts(t.gray)
    buildBelts(t.yellow)
    buildBelts(t.red)
    buildBelts(t.blue)
end
