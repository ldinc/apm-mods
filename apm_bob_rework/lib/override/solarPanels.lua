if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildSolarPanel= function (small, normal, large, tier, shell, alloy)
    local recipe = small
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 2)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 2)
    end

    local recipe = normal
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 4)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 4)
    end

    local recipe = large
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 24)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 8)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 8)
    end
end

apm.bob_rework.lib.override.solarPanels = function ()
    buildSolarPanel('solar-panel-small', 'solar-panel', 'solar-panel-large', apm.bob_rework.lib.tier.monel, apm.bob_rework.lib.entities.glass, apm.bob_rework.lib.entities.copper)
end