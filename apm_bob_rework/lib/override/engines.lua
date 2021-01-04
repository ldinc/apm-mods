if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildSimpleEngine = function (tier)
    local recipe = tier.main.engineUnit
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.pistons, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
end

apm.bob_rework.lib.override.simpleEngines = function ()
    buildSimpleEngine(apm.bob_rework.lib.tier.bronze)
    buildSimpleEngine(apm.bob_rework.lib.tier.brass)
end
