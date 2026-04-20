local plates    = require "lib.entities.plates"
local materials = require "lib.entities.materials"
local wires     = require "lib.entities.wires"
local logic     = require "lib.entities.logic"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end
if apm.bob_rework.lib.override.deadlock == nil then apm.bob_rework.lib.override.deadlock = {} end


apm.bob_rework.lib.override.deadlock.lamp = function()
    local recipe = ''
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local set = function(item, count)
        if count == nil then count = 1 end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end

    recipe = 'deadlock-copper-lamp'
    clear()
    set(plates.copper, 6)
    set(materials.glass, 2)

    recipe = 'deadlock-large-lamp'
    clear()
    set(plates.iron, 6)
    set(wires.copper, 18)
    set(materials.glass, 2)
    set(logic.circuit.low, 2)

    recipe = 'deadlock-floor-lamp'
    clear()
    set(plates.iron, 6)
    set(wires.copper, 14)
    set(materials.glass, 4)
    set(logic.circuit.low, 2)
end
