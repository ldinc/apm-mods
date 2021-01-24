if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildSolarPanel= function (small, normal, large, tier, shell, alloy)
    local recipe = small
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 4*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 2)
    end

    local recipe = normal
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 8*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 4)
    end

    local recipe = large
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 24)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 16*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 8)
    end
end

apm.bob_rework.lib.override.solarPanels = function ()
    buildSolarPanel('solar-panel-small', 'solar-panel', 'solar-panel-large', apm.bob_rework.lib.tier.brass, apm.bob_rework.lib.entities.glass, apm.bob_rework.lib.entities.copper)
    buildSolarPanel('solar-panel-small-2', 'solar-panel-2', 'solar-panel-large-2', apm.bob_rework.lib.tier.steel, apm.bob_rework.lib.entities.glass, apm.bob_rework.lib.entities.silver)
    buildSolarPanel('solar-panel-small-3', 'solar-panel-3', 'solar-panel-large-3', apm.bob_rework.lib.tier.titanium, apm.bob_rework.lib.entities.siliconWafer, apm.bob_rework.lib.entities.gold)
end