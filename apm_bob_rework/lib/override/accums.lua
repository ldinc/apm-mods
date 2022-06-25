if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildAccum = function (fast, high, slow, tier)
    local recipe = fast
    local logic = tier.logic
    if tier.level == 1 then
        logic = apm.bob_rework.lib.entities.logicContact
    end
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 4)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 2)

    local recipe = high
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 10)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 4)

    local recipe = slow
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.battery then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 4)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 4)
end

apm.bob_rework.lib.override.accums = function ()
    buildAccum('fast-accumulator', 'large-accumulator', 'slow-accumulator', apm.bob_rework.lib.tier.yellow)
    buildAccum('fast-accumulator-2', 'large-accumulator-2', 'slow-accumulator-2', apm.bob_rework.lib.tier.red)
    -- buildAccum('fast-accumulator-3', 'large-accumulator-3', 'slow-accumulator-3', apm.bob_rework.lib.tier.titanium)

    local recipe = 'accumulator'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 2)

end