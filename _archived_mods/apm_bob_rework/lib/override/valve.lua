local pipes = require "lib.entities.pipes"
local plates = require "lib.entities.plates"
local logic = require "lib.entities.logic"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end


apm.bob_rework.lib.override.valve = function()
    local recipe = ''
    local clear = function () apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local set = function (item, count)
        if count == nil then count = 1 end
        
        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end

    local up = function (name)
        recipe = name
        clear()
        set(plates.iron)
        set(pipes.base.iron)
        set(logic.mechanical)
    end

    up(pipes.valve.check)
    up(pipes.valve.overflow)
    up(pipes.valve.topup)
end
