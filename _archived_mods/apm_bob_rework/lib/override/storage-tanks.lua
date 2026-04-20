local fluids = require "lib.entities.fluids"
local plates = require "lib.entities.plates"
local product= require "lib.entities.product"
local pipes  = require "lib.entities.pipes"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.storage = {}

local fixPipesGraphics = function ()
    local storage = data.raw['storage-tank'][fluids.tank.small.inline]
    if storage then
        storage.fluid_box.secondary_draw_orders = {north = -1, east = -1, south = 1, west = -1}
    end

    local storage = data.raw['storage-tank'][fluids.tank.small.cross]
    if storage then
        storage.fluid_box.secondary_draw_orders = {north = -1, east = -1, south = 1, west = -1}
    end
end

apm.bob_rework.lib.override.storage.tank = function ()

    local recipe = ''
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function (itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end

    recipe = fluids.tank.minibuffer
    clear()
    add(plates.iron, 4)
    add(product.rubber, 4)
    add(pipes.base.iron, 2)

    recipe = fluids.tank.small.inline
    clear()
    add(plates.iron, 4)
    add(product.rubber, 4)
    add(pipes.base.iron, 2)

    recipe = fluids.tank.small.cross
    clear()
    add(plates.iron, 4)
    add(product.rubber, 4)
    add(pipes.base.iron, 4)

    fixPipesGraphics(recipe)

end