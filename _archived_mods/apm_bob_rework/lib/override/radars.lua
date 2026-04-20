local radars = require "lib.entities.buildings.radars"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

local buildRadar = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame and tier.level ~= t.yellow.level then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 5 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 5)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, tier.level)
end

apm.bob_rework.lib.override.radars = function()
    buildRadar(radars.sentinel, t.yellow)
    buildRadar(radars.radar.basic, t.red)
    buildRadar(radars.radar.advance, t.blue)
end

apm.bob_rework.lib.override.radars()
