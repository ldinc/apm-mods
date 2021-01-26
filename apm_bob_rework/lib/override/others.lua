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
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electroMagnet, 10)

    local recipe = 'train-stop'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicSteam, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.stoneBrick, 2)
    
    local recipe = 'engine-unit'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.simpleEngineUnit, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironGearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelBearing, 2)

    local recipe = 'electric-engine-unit'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironStick, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copperCable, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electroMagnet, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelBearing, 2)

    local recipe = 'small-lamp'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 1)

    local recipe = apm.bob_rework.lib.entities.ironStick
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)

    local recipe = 'automation-science-pack'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electroMagnet, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassGearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassBearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_treated_wood_planks', 2)

    local recipe = 'logistic-science-pack'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironPipe, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.monel, 1)

    
    local recipe = 'advanced-logistics-science-pack'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'brass-chest', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 5)

    local recipe = 'rocket-fuel'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 2)

    local recipe = 'explosives'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'water', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'nitric-acid', 20)

    local recipe = 'apm_filter_charcoal'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brass, 1)
    if settings.startup['apm_bob_rework_replace_filter'].value == true then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_charcoal_brick', 0)
        apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_coal_briquette', 1)
    end


    local recipe = 'apm_lubricant_1'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_resin', 2)

    local recipe = 'apm_steel_0'
    apm.lib.utils.recipe.result.add_with_probability(recipe, 'apm_crushed_stone', 10, 20, nil)
    local recipe = 'apm_steel_1'
    apm.lib.utils.recipe.result.add_with_probability(recipe, 'apm_crushed_stone', 12, 22, nil)
    local recipe = 'apm_steel_2'
    apm.lib.utils.recipe.result.add_with_probability(recipe, 'apm_crushed_stone', 16, 24, nil)
end