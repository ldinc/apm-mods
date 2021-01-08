if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildEFurnace = function (recipe, tier)
    
end

apm.bob_rework.lib.override.furnaces = function ()
    local recipe = 'electric-mixing-furnace'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.stoneBrick, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelPipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicAdvanced, 5)

    local recipe = 'electric-chemical-mixing-furnace'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.advancedMachineFrame, 0)
    local recipe = 'electric-chemical-mixing-furnace-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.advancedMachineFrame, 0)
end