if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.steelworks = function ()
    local recipe = apm.bob_rework.lib.entities.puddingFurnace
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.stoneBrick, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassPipe, 5)

    local recipe = apm.bob_rework.lib.entities.steelworks
    local tier = apm.bob_rework.lib.tier.yellow
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 14)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.concrete, 20)

    local recipe = apm.bob_rework.lib.entities.advancedSteelworks
    local tier = apm.bob_rework.lib.tier.red
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 18)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.refinedConcrete, 20)
end
