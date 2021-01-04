if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildCrusherRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.frame, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 15 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.crusher = function ()
    buildCrusherRecipe(apm.bob_rework.lib.entities.crusher, apm.bob_rework.lib.tier.bronze)
end
