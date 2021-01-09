if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildHeatExhanger = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 10)
end

buildHeatExhanger('heat-exchanger', 'boiler-3', apm.bob_rework.lib.tier.steel)
buildHeatExhanger('heat-exchanger-2', 'boiler-4', apm.bob_rework.lib.tier.aluminium)
buildHeatExhanger('heat-exchanger-3', 'boiler-5', apm.bob_rework.lib.tier.titanium)