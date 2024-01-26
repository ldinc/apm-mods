if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local e = require('lib.entities.buildings.energy')
local tier = require('lib.tier.base')
local plate = require('lib.entities.plates')
local alloy = require('lib.entities.alloys')

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
    buildAccum(e.accum.fast.basic, e.accum.high.basic, e.accum.slow.basic, tier.yellow)
    buildAccum(e.accum.fast.advance, e.accum.high.advance, e.accum.slow.advance, tier.red)
    buildAccum(e.accum.fast.extra, e.accum.high.extra, e.accum.slow.extra, tier.blue)

    apm.lib.utils.recipe.ingredient.mod(e.accum.basic, plate.iron, 0)
    apm.lib.utils.recipe.ingredient.mod(e.accum.basic, alloy.brass, 2)
end