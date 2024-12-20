local logic = require "lib.entities.logic"
local wires = require "lib.entities.wires"
local plates= require "lib.entities.plates"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local b = require('lib.entities.buildings.energy')
local tl = require('lib.entities.tech')

apm.bob_rework.lib.override.eboiler = function ()
    local tech = data.raw.technology[tl.boiler.electric]
    if tech then
        tech.icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/eboiler.png"
        tech.icon_size = 144
    end

    local recipe = b.boiler.electric
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, b.boiler.advance, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic.circuit.basic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, wires.copper, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 10)

    local rm = apm.lib.utils.recipe.remove
    rm('electric-boiler-2')
    rm('electric-boiler-3')
    rm('electric-boiler-4')
    rm('electric-boiler-5')
end