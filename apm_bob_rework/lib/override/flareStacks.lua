local pipes = require "lib.entities.pipes"
local wires = require "lib.entities.wires"
local plates= require "lib.entities.plates"
local materials = require "lib.entities.materials"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local u = require('lib.entities.buildings.utilizators')
local p = require('lib.entities.product')

local buildFlare = function(recipe)
    local tier = t.yellow

    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, wires.copper, 5)
end


local buildGasVenting = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.iron, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.concrete, 10)
end

local buildIncinerator = function(recipe)
    local tier = t.yellow

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 1)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
end

apm.bob_rework.lib.override.flareStacks = function()
    buildGasVenting(u.vent, t.yellow)
    buildFlare(u.flare)
    buildIncinerator(u.incinerator.basic)
    buildIncinerator(u.incinerator.electric)
end
