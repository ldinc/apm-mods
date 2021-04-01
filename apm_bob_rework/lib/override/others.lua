if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')
require('lib.utils.debug')

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
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_treated_wood_planks', 2)
    
    local recipe = 'advanced-logistic-science-pack'
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

    local recipe = 'rail'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 2)

    local recipe = 'production-science-pack'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rail', 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-mixing-furnace', 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'productivity-module', 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'productivity-module-3', 4)
    -- sad hack
    local obj = data.raw.recipe[recipe]
    apm.bob_rework.lib.utils.debug.object(obj)
    table.insert(obj.ingredients, {type='item', name='rail', amount=40})
    table.insert(obj.ingredients, {type='item', name='productivity-module', amount=4})

    local recipe = 'apm_industrial_science_pack_0'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.logicBasic, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.stone, 5)

    local spaceship = data.raw.container['crash-site-spaceship']
    apm.bob_rework.lib.utils.debug.object(spaceship)
    spaceship.max_health = 99
    spaceship.loot = {
        {item='small-lamp',count_min=40,count_max=40},
        {item=apm.bob_rework.lib.entities.bronzeBearing,count_min=150,count_max=150},
        {item=apm.bob_rework.lib.entities.bronzeGearWheel,count_min=200,count_max=200},
        {item=apm.bob_rework.lib.entities.logicBasic,count_min=50,count_max=50},
        {item=apm.bob_rework.lib.entities.bronze,count_min=200,count_max=400},
        {item=apm.bob_rework.lib.entities.gunPowder,count_min=100,count_max=200},
        {item='piercing-rounds-magazine',count_min=200,count_max=400},
    }

end