if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildCrusherRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 15 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.crushers = function ()
    buildCrusherRecipe(apm.bob_rework.lib.entities.crusher, apm.bob_rework.lib.tier.bronze)
    buildCrusherRecipe(apm.bob_rework.lib.entities.steamCrusher, apm.bob_rework.lib.tier.brass)
end
