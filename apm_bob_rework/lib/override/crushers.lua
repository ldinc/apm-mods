if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildCrusherRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5 + 5*tier.level)
    if tier.extraConstructionAlloy then
        local count = 8
        if tier.level == 1 then
            count = 10
        end
        if tier.level > 1 then
            count = 12
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.crushers = function ()
    buildCrusherRecipe(apm.bob_rework.lib.entities.crusher, apm.bob_rework.lib.tier.bronze)
    buildCrusherRecipe(apm.bob_rework.lib.entities.steamCrusher, apm.bob_rework.lib.tier.brass)
    buildCrusherRecipe(apm.bob_rework.lib.entities.advancedCrusher, apm.bob_rework.lib.tier.monel)
end
