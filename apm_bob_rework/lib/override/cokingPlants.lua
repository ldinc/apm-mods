if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.coking-plant')


local buildCokingPlantRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 8 + 4 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 12 + 4 * tier.level)
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

apm.bob_rework.lib.override.cokingPlants = function()
    buildCokingPlantRecipe(b.basic, t.gray)
    buildCokingPlantRecipe(b.steam, t.steam)
    buildCokingPlantRecipe(b.advanced, t.red)
end
