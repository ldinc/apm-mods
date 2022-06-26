if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

local plates = require('lib.entities.plates')
local frame = require('lib.entities.frames')
local alloy = require('lib.entities.alloys')
local pipe = require('lib.entities.pipes')
local logic = require('lib.entities.logic')

apm.bob_rework.lib.override.frames = function()
    -- basic
    apm.lib.utils.recipe.ingredient.remove_all(frame.basic)
    apm.lib.utils.recipe.ingredient.mod(frame.basic, alloy.cobalt.steel, 3)
    apm.lib.utils.recipe.ingredient.mod(frame.basic, pipe.base.steel, 2)
    apm.lib.utils.recipe.ingredient.mod(frame.basic, logic.circuit.basic, 4)
    -- advanced
    apm.lib.utils.recipe.ingredient.remove_all(frame.advanced)
    apm.lib.utils.recipe.ingredient.mod(frame.advanced, alloy.titanium, 3)
    apm.lib.utils.recipe.ingredient.mod(frame.advanced, plates.aluminium, 4)
    apm.lib.utils.recipe.ingredient.mod(frame.advanced, pipe.base.titanium, 2)
    apm.lib.utils.recipe.ingredient.mod(frame.advanced, logic.PU, 4)
    -- steam
    apm.lib.utils.recipe.ingredient.remove_all(frame.steam)
    apm.lib.utils.recipe.ingredient.mod(frame.steam, alloy.brass, 2)
    apm.lib.utils.recipe.ingredient.mod(frame.steam, pipe.base.brass, 2)
    apm.lib.utils.recipe.ingredient.mod(frame.steam, logic.steam, 2)
end
