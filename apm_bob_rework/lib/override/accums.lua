if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildAccum = function (fast, high, slow, tier)
    local recipe = fast
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 4)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)

    local recipe = high
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 10)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 4)

    local recipe = slow
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 4)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 4)
end

apm.bob_rework.lib.override.accums = function ()
    buildAccum('fast-accumulator', 'large-accumulator', 'slow-accumulator', apm.bob_rework.lib.tier.monel)
end