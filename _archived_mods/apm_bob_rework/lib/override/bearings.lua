local product = require "lib.entities.product"
local alloys  = require "lib.entities.alloys"
local fluids  = require "lib.entities.fluids"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local genBearing = function(recipe, mat, balls)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, mat, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, balls, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, fluids.lubricant, 10)
end

local changeSubGroupForItem = function(name, sg)
    local itm = data.raw['item'][name]
    if itm then
        itm.subgroup = sg
    end
end

local updateGearing = function(name)
    apm.lib.utils.recipe.result.mod(name, name, 2)
end

apm.bob_rework.lib.override.bearings = function()
    apm.lib.utils.recipe.category.change(product.bearing.bronze, 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change(product.bearing.brass, 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change(product.bearing.cobalt.steel, 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change(product.bearing.titanium, 'crafting-with-fluid')

    genBearing(product.bearing.bronze, alloys.bronze, product.bearing.balls.bronze)
    genBearing(product.bearing.brass, alloys.brass, product.bearing.balls.brass)
    genBearing(product.bearing.cobalt.steel, alloys.cobalt.steel, product.bearing.balls.cobalt.steel)
    genBearing(product.bearing.titanium, alloys.titanium, product.bearing.balls.ceramic)

    changeSubGroupForItem(product.bearing.bronze, 'bob-bearings')
    changeSubGroupForItem(product.bearing.brass, 'bob-bearings')
    changeSubGroupForItem(product.bearing.balls.bronze, 'bob-bearings')
    changeSubGroupForItem(product.bearing.balls.brass, 'bob-bearings')
    changeSubGroupForItem(product.bearing.balls.ceramic, 'bob-bearings')
    changeSubGroupForItem(product.bearing.balls.cobalt.steel, 'bob-bearings')
    changeSubGroupForItem(product.gearwheel.bronze, 'bob-gears')
    changeSubGroupForItem(product.gearwheel.brass, 'bob-gears')

    updateGearing(product.gearwheel.bronze)
    updateGearing(product.gearwheel.brass)
    updateGearing(product.gearwheel.iron)
    updateGearing(product.gearwheel.cobaltSteel)
    updateGearing(product.gearwheel.titanium)
end
