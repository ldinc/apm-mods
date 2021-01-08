if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildGreenhousesRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 10 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 25 + 5*tier.level)
    if tier.level >= 2 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'small-lamp', 30)
    end
end

apm.bob_rework.lib.override.greenhouses = function ()
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.greenhouse, apm.bob_rework.lib.tier.bronze)
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.steamGreenhouse, apm.bob_rework.lib.tier.brass)
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.advancedGreenhouse, apm.bob_rework.lib.tier.monel)
end
