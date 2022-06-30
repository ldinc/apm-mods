if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local e = require('lib.entities.buildings.energy')

local buildHeatExhanger = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 3 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 3*tier.level)
end

buildHeatExhanger(e.heat.exchanger, e.boiler.extra, t.red)