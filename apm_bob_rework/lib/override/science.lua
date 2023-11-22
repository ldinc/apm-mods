local science = require "lib.entities.science"
local materials = require "lib.entities.materials"
local storages  = require "lib.entities.buildings.storages"
local logistics = require "lib.entities.logistics"
local inserters = require "lib.entities.buildings.inserters"
local roboport  = require "lib.entities.buildings.roboport"
local modules   = require "lib.entities.modules"
local energy    = require "lib.entities.buildings.energy"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.science = function ()
    local recipe = ''

    local clear = function ()
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
    end

    local set = function (item, count)
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end

    recipe = science.advanced.logistics
    clear()
    set(materials.plastic, 5)
    set(storages.chest.steel, 2)
    set(roboport.bots.logistic.red)
    set(logistics.rail.element)

    recipe = science.production
    clear()
    set(energy.accum.fast.advance)
    set(logistics.loader.fast)
    set(modules.effectivity.II, 4)
    set(modules.productivity.II, 4)

    recipe = science.logistics
    set(logistics.belt.basic, 0)
    set(logistics.belt.yellow)
end