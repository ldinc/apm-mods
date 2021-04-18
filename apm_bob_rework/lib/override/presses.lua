if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildPressRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    if tier.extraConstructionAlloy then
        local count = 8
        if tier.level == 1 then
            count = 15
        end
        if tier.level > 1 then
            count = 10
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.presses = function ()
    buildPressRecipe(apm.bob_rework.lib.entities.press, apm.bob_rework.lib.tier.bronze)
    buildPressRecipe(apm.bob_rework.lib.entities.steamPress, apm.bob_rework.lib.tier.brass)
    buildPressRecipe(apm.bob_rework.lib.entities.advancedPress, apm.bob_rework.lib.tier.monel)
end
