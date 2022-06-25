if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildHeatExhanger = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 3 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 3*tier.level)
end

buildHeatExhanger('heat-exchanger', 'boiler-3', apm.bob_rework.lib.tier.red)
-- buildHeatExhanger('heat-exchanger-2', 'boiler-4', apm.bob_rework.lib.tier.aluminium)
-- buildHeatExhanger('heat-exchanger-3', 'boiler-5', apm.bob_rework.lib.tier.titanium)