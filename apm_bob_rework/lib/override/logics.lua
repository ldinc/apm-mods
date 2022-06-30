if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local l = require('lib.entities.logic')
local p = require('lib.entities.product')
local alloy = require('lib.entities.alloys')
local pipe = require('lib.entities.pipes')
local t = require('lib.tier.base')

local gen = function (recipe)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.wire, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.frame, 1)
end

apm.bob_rework.lib.override.logics = function()
    local recipe = l.mechanical
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.gearwheel.bronze, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy.bronze, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.board.wooden, 1)

    local recipe = l.steam
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.gearwheel.brass, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipe.base.brass, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy.brass, 1)

    gen(l.combinator.arithmetic)
    gen(l.combinator.decider)
    gen(l.combinator.const)
end
