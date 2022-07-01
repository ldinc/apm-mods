local storages = require "lib.entities.buildings.storages"
local alloys   = require "lib.entities.alloys"
local product  = require "lib.entities.product"
local frames   = require "lib.entities.frames"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')
require('lib.utils.debug')
local materials = require "lib.entities.materials"
local logic = require "lib.entities.logic"
local plates = require "lib.entities.plates"
local wire = require('lib.entities.wires')
local p = require('lib.entities.product')

local sulfur = function()
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

apm.bob_rework.lib.override.others = function()
    local mod = apm.lib.utils.recipe.ingredient.mod

    local recipe = p.egenerator
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, plates.iron, 2)
    mod(recipe, p.stick, 1)
    mod(recipe, p.bearing.steel, 2)
    mod(recipe, wire.copper, 2)
    mod(recipe, p.magnet, 10)

    recipe = 'train-stop'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, plates.iron, 10)
    mod(recipe, p.stick, 2)
    mod(recipe, logic.steam, 5)
    mod(recipe, materials.brick, 5)

    recipe = 'engine-unit'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, p.pistons, 8)
    mod(recipe, plates.iron, 4)
    mod(recipe, p.stick, 4)
    mod(recipe, p.gearwheel.iron, 10)
    mod(recipe, p.bearing.steel, 2)

    recipe = 'electric-engine-unit'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, p.stick, 1)
    mod(recipe, plates.iron, 2)
    mod(recipe, wire.copper, 4)
    mod(recipe, p.magnet, 12)
    mod(recipe, p.bearing.steel, 2)

    recipe = 'small-lamp'
    mod(recipe, materials.glass, 1)

    recipe = p.stick
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, plates.steel, 1)

    recipe = 'automation-science-pack'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, p.magnet, 2)
    mod(recipe, p.gearwheel.brass, 2)
    mod(recipe, materials.planks, 2)

    recipe = 'advanced-logistic-science-pack'
    mod(recipe, storages.chest.brass, 0)
    mod(recipe, materials.plastic, 5)

    recipe = 'rocket-fuel'
    mod(recipe, materials.plastic, 5)
    mod(recipe, p.rubber, 2)
    mod(recipe, plates.steel, 2)

    recipe = 'explosives'
    mod(recipe, 'water', 0)
    mod(recipe, 'nitric-acid', 20)

    recipe = 'apm_filter_charcoal'
    mod(recipe, plates.steel, 0)
    mod(recipe, alloys.brass, 1)
    if settings.startup['apm_bob_rework_replace_filter'].value == true then
        mod(recipe, 'apm_charcoal_brick', 0)
        mod(recipe, 'apm_coal_briquette', 1)

        local recipe = 'apm_filter_charcoal_used_recycling'
        mod(recipe, 'apm_charcoal_brick', 0)
        mod(recipe, 'apm_coal_briquette', 3)
    end


    recipe = 'apm_lubricant_1'
    mod(recipe, 'apm_resin', 2)

    recipe = 'rail'
    mod(recipe, plates.steel, 2)

    recipe = 'production-science-pack'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    mod(recipe, 'rail', 40)
    mod(recipe, 'electric-mixing-furnace', 1)
    mod(recipe, 'productivity-module', 4)
    mod(recipe, 'productivity-module-3', 4)
    -- sad hack
    local obj = data.raw.recipe[recipe]
    -- apm.bob_rework.lib.utils.debug.object(obj)
    table.insert(obj.ingredients, { type = 'item', name = 'rail', amount = 40 })
    table.insert(obj.ingredients, { type = 'item', name = 'productivity-module', amount = 4 })

    recipe = 'apm_industrial_science_pack_0'
    mod(recipe, logic.mechanical, 1)
    mod(recipe, materials.stone, 5)

    --#
    recipe = 'apm_crusher_machine_2'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_greenhouse_2'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_press_machine_2'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_coking_plant_2'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_centrifuge_2'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_steelworks_0'
    mod(recipe, alloys.invar, 0)
    mod(recipe, plates.steel, 15)

    recipe = 'apm_stone_brick_raw_with_wed_mud'
    mod(recipe, materials.mud.wet, 5)
    mod(recipe, product.crushed.stone, 0)

    recipe = materials.refined.concrete
    mod(recipe, plates.steel, 0)
    mod(recipe, product.stick, 8)

    recipe = product.bearing.titanium
    mod(recipe, product.bearing.balls.titanium, 0)
    mod(recipe, product.bearing.balls.ceramic, 16)

    apm.lib.utils.recipe.category.change('apm_treated_wood_planks_1', 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change('apm_treated_wood_planks_1b', 'crafting-with-fluid')
    apm.lib.utils.recipe.category.change('apm_saw_blade_iron', 'crafting')
    apm.lib.utils.recipe.category.change('apm_saw_blade_iron_maintenance', 'crafting-with-fluid')

    -- setup sulfur as starting resource (because gun powder recipies)
    -- bobmods.ores.sulfur.create_autoplace = sulfur
    -- sulfur()

    -- add stone for sifting machine
    apm.lib.utils.recipe.result.add_with_probability('apm_dry_mud_sifting_iron', 'stone', 2, 8, 1)
    apm.lib.utils.recipe.result.add_with_probability('apm_dry_mud_sifting_copper', 'stone', 1, 8, 1)
    -- apm_dry_mud_sifting_iron
    -- apm_dry_mud_sifting_copper

    -- buf personal egen

    local modify = settings.startup['apm_bob_rework_replace_filter'].value == true

    local target = 'apm_equipment_burner_generator_basic'
    local itm = data.raw["generator-equipment"][target]
    itm.power = "500kW"
    if modify then
        itm.burner.effectivity = "0.1"
    end

    target = 'apm_equipment_burner_generator_advanced'
    itm = data.raw["generator-equipment"][target]
    itm.power = "1000kW"
    if modify then
        itm.burner.effectivity = "0.14"
    end

    recipe = data.raw.recipe['apm_machine_frame_steam']
    recipe.localised_name = { "entity-name.primitive-frame", { "entity-name.primitive-frame" } }

    local itm = data.raw.item[frames.steam]
    itm.localised_name = { "entity-name.primitive-frame", { "entity-name.primitive-frame" } }
end
