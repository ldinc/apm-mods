if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local plates    = require "lib.entities.plates"
local materials = require "lib.entities.materials"
local t = require('lib.tier.base')

local buildSolarPanel= function (small, normal, large, tier, extra, alloy)
    local recipe = small
    local logic = tier.logic
    local shell = materials.glass

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 4*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 2)
    end
    if extra then
        apm.lib.utils.recipe.ingredient.mod(recipe, extra, 4*tier.level)
    end

    local recipe = normal
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 8*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 4)
    end
    if extra then
        apm.lib.utils.recipe.ingredient.mod(recipe, extra, 8*tier.level)
    end

    local recipe = large
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 24)
    apm.lib.utils.recipe.ingredient.mod(recipe, shell, 16*tier.level)
    if alloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 8)
    end
    if extra then
        apm.lib.utils.recipe.ingredient.mod(recipe, extra, 16*tier.level)
    end
end

apm.bob_rework.lib.override.solarPanels = function ()
    buildSolarPanel('solar-panel-small', 'solar-panel', 'solar-panel-large', t.yellow, nil, plates.copper)
    buildSolarPanel('solar-panel-small-2', 'solar-panel-2', 'solar-panel-large-2', t.red, nil, plates.silver)
end