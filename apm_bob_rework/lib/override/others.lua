if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.others = function ()
    local recipe = apm.bob_rework.lib.entities.electricGeneratorUnit
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelBearing, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copperCable, 2)
    
end