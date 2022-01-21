if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildLaboratoryRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 15 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.inserter, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.laboratories = function ()
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.laboratory, apm.bob_rework.lib.tier.bronze)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.steamLaboratory, apm.bob_rework.lib.tier.brass)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.advancedLaboratory, apm.bob_rework.lib.tier.monel)
end
