if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildCookingPlantRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 20 * tier.main.basementK)
end

apm.bob_rework.lib.override.cookingPlants = function ()
    buildCookingPlantRecipe(apm.bob_rework.lib.entities.cookingPlant, apm.bob_rework.lib.tier.bronze)
    buildCookingPlantRecipe(apm.bob_rework.lib.entities.steamCookingPlant, apm.bob_rework.lib.tier.brass)
end
