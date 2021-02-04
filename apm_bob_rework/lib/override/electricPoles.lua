if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildEPole = function (medium, big, substation, tier)
    local recipe = medium
    local m = tier.level - 2
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5+2*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 2 + 2*m)

    local recipe = big
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 3*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 4+4*m)

    local recipe = substation
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 40 + 5*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5*tier.level)
end

apm.bob_rework.lib.override.electricPoles = function ()
    buildEPole('medium-electric-pole', 'big-electric-pole', 'substation', apm.bob_rework.lib.tier.monel)
    buildEPole('medium-electric-pole-2', 'big-electric-pole-2', 'substation-2', apm.bob_rework.lib.tier.steel)
    buildEPole('medium-electric-pole-3', 'big-electric-pole-3', 'substation-3', apm.bob_rework.lib.tier.aluminium)
    buildEPole('medium-electric-pole-4', 'big-electric-pole-4', 'substation-4', apm.bob_rework.lib.tier.titanium)
end