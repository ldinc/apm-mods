if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildLaboratoryRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)


    if tier.level > 0 then
        local inserter = tier.inserter
        if tier.level == apm.bob_rework.lib.tier.monel.level then
            inserter = apm.bob_rework.lib.entities.yellowInserter
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, inserter, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    if tier.extraConstructionAlloy then
        local count = 20
        if tier.level == 1 then
            count = 15
        end
        if tier.level > 1 then
            count = 20
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level*2 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 20)
end

apm.bob_rework.lib.override.laboratories = function ()
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.laboratory, apm.bob_rework.lib.tier.bronze)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.steamLaboratory, apm.bob_rework.lib.tier.brass)
    buildLaboratoryRecipe(apm.bob_rework.lib.entities.advancedLaboratory, apm.bob_rework.lib.tier.monel)
    buildLaboratoryRecipe('lab-2', apm.bob_rework.lib.tier.aluminium)
end
