if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

-- TODO: move to drop section

apm.bob_rework.lib.override.machineFrames = function ()
    local recipe = apm.bob_rework.lib.entities.machineFrame
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.bronze, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicBasic, 2)
    
    local recipe = apm.bob_rework.lib.entities.steamMachineFrame
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicSteam, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassPipe, 2)
    
    local recipe = apm.bob_rework.lib.entities.advancedMachineFrame
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.machineFrame, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.concrete, 5)
end
