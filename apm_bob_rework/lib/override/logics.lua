if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.logics = function ()
    local recipe = apm.bob_rework.lib.entities.logicBasic
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.bronzeGearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.bronze, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.woodenBoard, 1)

    local recipe = apm.bob_rework.lib.entities.logicSteam
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassGearWheel , 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassPipe, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 1)

    local recipe = 'arithmetic-combinator'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron , 1)
    local recipe = 'decider-combinator'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron , 1)
    local recipe = 'constant-combinator'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron , 1)
end