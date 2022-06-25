if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildGreenhousesRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    if tier.extraConstructionAlloy then
        local count = 20
        if tier.level == 1 then
            count = 8
        end
        if tier.level > 1 then
            count = 12
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 25 + 5*tier.level)
    if tier.level >= 2 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'small-lamp', 14)
    end
end

apm.bob_rework.lib.override.greenhouses = function ()
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.greenhouse, apm.bob_rework.lib.tier.gray)
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.steamGreenhouse, apm.bob_rework.lib.tier.steam)
    buildGreenhousesRecipe(apm.bob_rework.lib.entities.advancedGreenhouse, apm.bob_rework.lib.tier.red)
end
