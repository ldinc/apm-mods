local product = require "lib.entities.product"
local plates = require "lib.entities.plates"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.pistions = function ()
    local recipe = product.pistions
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 2)
end