if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildCokingPlantRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 8 + 4*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 12 + 4*tier.level)
local count = 20
    if tier.level == 1 then
        count = 10
    end
    if tier.level > 1 then
        count = 12
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
end

apm.bob_rework.lib.override.cokingPlants = function ()
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.cokingPlant, apm.bob_rework.lib.tier.gray)
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.steamCokingPlant, apm.bob_rework.lib.tier.steam)
    buildCokingPlantRecipe(apm.bob_rework.lib.entities.advancedCokingPlant, apm.bob_rework.lib.tier.red)
end
