if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.steelworks = function ()
    local recipe = apm.bob_rework.lib.entities.puddingFurnace
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.stoneBrick, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassPipe, 5)

    local recipe = apm.bob_rework.lib.entities.steelworks
    local tier = apm.bob_rework.lib.tier.monel
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.concrete, 30)

    local recipe = apm.bob_rework.lib.entities.advancedSteelworks
    local tier = apm.bob_rework.lib.tier.aluminium
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.concrete, 30)
end
