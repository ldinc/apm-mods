if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildLaboratoryRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.level > 0 then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 3)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.laboratories = function ()
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.laboratory, apm.bob_rework.lib.tier.bronze)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.steamLaboratory, apm.bob_rework.lib.tier.brass)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.advancedLaboratory, apm.bob_rework.lib.tier.monel)
end
