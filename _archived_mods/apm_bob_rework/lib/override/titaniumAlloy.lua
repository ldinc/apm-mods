local product = require "lib.entities.product"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

local plates = require "lib.entities.plates"
local alloys = require "lib.entities.alloys"

local update = function()
    local drop = plates.titanium
    local alloy = alloys.titanium

    local recipe = product.bearing.balls.titanium
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, drop, 0)

    recipe = product.bearing.titanium
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, drop, 0)
end

update()
