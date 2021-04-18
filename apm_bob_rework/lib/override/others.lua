if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')
require('lib.utils.debug')

local sulfur = function ()
    -- if resource_generator then
    -- resource_generator.setup_resource_autoplace_data("sulfur", {
    --     name = "sulfur",
    --     order = "c",
    --     base_density = 8,
    --     has_starting_area_placement = true, -- main change from original bob
    --     regular_rq_factor_multiplier = 0.1,
    -- }
    -- )
    -- else
    -- data.raw.resource["sulfur"].autoplace = resource_autoplace.resource_autoplace_settings{
    --     name = "sulfur",
    --     order = "c",
    --     base_density = 8,
    --     has_starting_area_placement = true, -- main change from original bob
    --     regular_rq_factor_multiplier = 0.1,
    -- }
    -- end
    -- data.raw.resource["sulfur"].autoplace.has_starting_area_placement = true
    -- bobmods.ores.sulfur.enabled = true
end

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

    --#
    local recipe = 'apm_crusher_machine_2'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)
    local recipe = 'apm_greenhouse_2'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)
    local recipe = 'apm_press_machine_2'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)
    local recipe = 'apm_coking_plant_2'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)
    local recipe = 'apm_centrifuge_2'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)
    local recipe = 'apm_steelworks_0'
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe,apm.bob_rework.lib.entities.steel, 15)

    apm.lib.utils.recipe.category.change('apm_treated_wood_planks_1', 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change('apm_treated_wood_planks_1b', 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change('apm_saw_blade_iron', 'crafting')
    apm.lib.utils.recipe.category.change('apm_saw_blade_iron_maintenance', 'crafting-with-fluid')

    -- setup sulfur as starting resource (because gun powder recipies)
    -- bobmods.ores.sulfur.create_autoplace = sulfur
    -- sulfur()

    local recipe = apm.bob_rework.lib.entities.nitinolPipe
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
    local recipe = apm.bob_rework.lib.entities.nitinolUnderPipe
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
end