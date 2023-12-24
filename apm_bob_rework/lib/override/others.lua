local storages = require "lib.entities.buildings.storages"
local alloys   = require "lib.entities.alloys"
local product  = require "lib.entities.product"
local frames   = require "lib.entities.frames"
local energy   = require "lib.entities.buildings.energy"
local pipes    = require "lib.entities.pipes"
local bob      = require "lib.entities.bob"
local logistics= require "lib.entities.logistics"
local combat   = require "lib.entities.combat"
local rocket   = require "lib.entities.new.rocket"
local recipies = require "lib.entities.recipies"
local science  = require "lib.entities.science"
local modules  = require "lib.entities.modules"
local furnaces = require "lib.entities.buildings.furnaces"
local fluids   = require "lib.entities.fluids"
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


local enableRecipeOnStart = function(name)
    local obj = data.raw['recipe'][name]
    obj.enabled = true
end

apm.bob_rework.lib.override.others = function()
    local recipe = ''

    local mod = function (itm, cnt)
        apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt)
    end

    local clear = function ()
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
    end

    local disable = apm.lib.utils.recipe.disable

    recipe = p.egenerator
    clear()
    mod(plates.iron, 2)
    mod(p.stick, 1)
    mod(p.bearing.brass, 2)
    mod(wire.copper, 2)
    mod(p.magnet, 8)

    recipe = 'train-stop'
    clear()
    mod(plates.iron, 10)
    mod(p.stick, 2)
    mod(logic.steam, 5)
    mod(materials.brick, 5)

    recipe = 'engine-unit'
    clear()
    mod(p.pistions, 8)
    mod(plates.iron, 4)
    mod(p.stick, 4)
    mod(p.gearwheel.brass, 10)
    mod(p.bearing.brass, 2)

    recipe = 'electric-engine-unit'
    clear()
    mod(p.stick, 1)
    mod(plates.iron, 2)
    mod(wire.copper, 4)
    mod(p.magnet, 6)
    mod(p.bearing.brass, 2)

    recipe = 'small-lamp'
    mod(materials.glass, 1)

    recipe = p.stick
    clear()
    mod(plates.steel, 1)

    recipe = 'automation-science-pack'
    clear()
    mod(p.magnet, 2)
    mod(p.gearwheel.brass, 2)
    mod(materials.planks, 2)

    recipe = 'advanced-logistic-science-pack'
    mod(storages.chest.brass, 0)
    mod(materials.plastic, 5)

    recipe = 'rocket-fuel'
    mod(materials.plastic, 5)
    mod(p.rubber, 2)
    mod(plates.steel, 2)

    recipe = 'explosives'
    mod('water', 0)
    mod('nitric-acid', 20)

    recipe = 'apm_filter_charcoal'
    clear()
    mod(alloys.brass, 1)
    mod(materials.coke, 1)

    recipe = 'apm_filter_charcoal_used_recycling'
    clear()
    mod('apm_filter_charcoal_used', 3)
    mod(materials.coke, 2)
    mod('water', 30)

    recipe = 'apm_lubricant_1'
    mod('apm_resin', 2)

    recipe = 'rail'
    mod(plates.steel, 2)

    -- enabled sieve on startup
    recipe = product.sieve.iron
    enableRecipeOnStart(recipe)
    mod(plates.iron, 1)

    -- enableRecipeOnStart(energy.pole.small)
    enableRecipeOnStart(alloys.bronze)
    disable(recipies.chemistry.plastic.old)

    recipe = 'apm_industrial_science_pack_0'
    mod(logic.mechanical, 1)
    mod(materials.stone, 5)

    --#
    -- recipe = 'apm_crusher_machine_2'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    -- recipe = 'apm_greenhouse_2'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    -- recipe = 'apm_press_machine_2'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    -- recipe = 'apm_coking_plant_2'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    -- recipe = 'apm_centrifuge_2'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    -- recipe = 'apm_steelworks_0'
    -- mod(alloys.invar, 0)
    -- mod(plates.steel, 15)

    recipe = 'apm_stone_brick_raw_with_wed_mud'
    mod(materials.mud.wet, 5)
    mod(product.crushed.stone, 0)

    recipe = materials.refined.concrete
    mod(plates.steel, 0)
    mod(product.stick, 8)

    recipe = product.sieve.iron
    apm.lib.utils.recipe.result.mod(recipe, recipe, 5)

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

    local target = 'apm_equipment_burner_generator_basic'
    local itm = data.raw["generator-equipment"][target]
    itm.power = "500kW"

    target = 'apm_equipment_burner_generator_advanced'
    itm = data.raw["generator-equipment"][target]
    itm.power = "1000kW"

    recipe = data.raw.recipe['apm_machine_frame_steam']
    recipe.localised_name = { "entity-name.primitive-frame", { "entity-name.primitive-frame" } }

    local itm = data.raw.item[frames.steam]
    itm.localised_name = { "entity-name.primitive-frame", { "entity-name.primitive-frame" } }

    recipe = product.gearwheel.titanium
    clear()
    mod(alloys.titanium, 1)

    recipe = 'satellite'
    mod('radar-5', 0)
    mod('radar-2', 1)

    recipe = 'waterfill'
    mod(product.explosives, 0)
    mod(product.cliff.explosives, 2)

    recipe = 'deepwaterfill'
    mod(product.explosives, 0)
    mod(product.cliff.explosives, 5)

    recipe = 'shallowwaterfill'
    mod(product.explosives, 0)
    mod(product.cliff.explosives, 1)

    recipe = 'mudwaterfill'
    mod(product.explosives, 0)
    mod(product.cliff.explosives, 1)

    -- recipe = science.production
    -- clear()
    -- mod(logistics.rail.element, 1)
    -- mod(furnaces.mixing.electric, 1)
    -- mod(modules.productivity.II, 4)
    -- mod(modules.effectivity.II, 4)

    -- recipe = science.logistics
    -- mod(logistics.belt.basic, 0)
    -- mod(logistics.belt.yellow, 1)

    disable(frames.basic)
    disable(pipes.base.copper)
    disable(pipes.under.copper)
    disable(bob.generator.burner)
    disable(logistics.belt.slow)
    disable(bob.product.recipe.resin)
    disable(bob.product.recipe.rubber)
    disable(logic.circuit.low)
    disable(combat.disabled.turret.rifle)
    disable(combat.ammo.magazine.firearm)

    recipe = pipes.sinkhole.large
    mod(pipes.base.iron, 100)
    mod(materials.refined.concrete, 80)
    mod(materials.concrete, 0)
    mod(product.rubber, 20)

    recipe = 'apm_seawater_centrifuging'
    apm.lib.utils.recipe.energy_required.mod(recipe, 1)
    apm.lib.utils.recipe.result.mod(recipe, fluids.water, 200)

    apm.lib.utils.recipe.energy_required.mod('apm_wood_ash_production', 0.5)

    apm.lib.utils.assembler.mod.category.add('electric-chemical-mixing-furnace', 'apm_electric_smelting')

    apm.lib.utils.recipe.category.change('apm_pyrolysis_charcoal_3', 'apm_coking_2')
end
