local product = require "lib.entities.product"
local combat  = require "lib.entities.combat"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local change = function (recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.explosives, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 2)
end

apm.bob_rework.lib.override.ammo = function()
    for _, name in pairs(combat.ammo.capsule) do
        change(name)
    end
end