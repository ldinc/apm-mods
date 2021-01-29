if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildCokingPlantRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
local count = 20
    if tier.level == 1 then
        count = 15
    end
    if tier.level > 1 then
        count = 10
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20 * tier.basementK)
end

apm.bob_rework.lib.override.cokingPlants = function ()
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.cokingPlant, apm.bob_rework.lib.tier.bronze)
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.steamCokingPlant, apm.bob_rework.lib.tier.brass)
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.advancedCokingPlant, apm.bob_rework.lib.tier.monel)
end
