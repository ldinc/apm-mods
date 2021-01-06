if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildEPole = function (medium, big, substation, tier)
    local recipe = medium
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 2 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.wire, 2)

    local recipe = big
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.wire, 4)

    local recipe = substation
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 10 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.wire, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 10 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 5)
end

apm.bob_rework.lib.override.electricPoles = function ()
    buildEPole('medium-electric-pole', 'big-electric-pole', 'substation', apm.bob_rework.lib.tier.monel)
end