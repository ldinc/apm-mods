local plates = require "lib.entities.plates"
local materials = require "lib.entities.materials"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local update =  function ()
    local recipe = ''
    local tune = function (e)
        apm.lib.utils.recipe.energy_required.mod(recipe, e)
    end

    recipe = 'apm_wood_0'
    tune(60)
    apm.lib.utils.recipe.result.mod(recipe, materials.wood, 40)
    recipe = 'apm_wood_1'
    tune(60)
    recipe = 'apm_wood_2'
    tune(60)
end

update()