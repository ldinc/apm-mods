if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildDistilator = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 3 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.filter, 9)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1 + tier.level)
end

apm.bob_rework.lib.override.distilators = function ()
    buildDistilator('bob-distillery', apm.bob_rework.lib.tier.yellow)
    buildDistilator('bob-distillery-2', apm.bob_rework.lib.tier.red)
    buildDistilator('bob-distillery-3', apm.bob_rework.lib.tier.blue)
end