if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local logic = require "lib.entities.logic"
local alloys = require "lib.entities.alloys"
local nuclear = require('lib.entities.nuclear')
local m = require('lib.entities.materials')
local t = require('lib.tier.base')

local buildNuclearRecipies = function()
    local mod = apm.lib.utils.recipe.ingredient.mod
    local recipe = 'apm_fuel_rod_container'
    mod(recipe, m.carbon, 5)

    recipe = 'apm_breeder_container'
    mod(recipe, m.carbon, 5)
    mod(recipe, alloys.lead, 5)

    recipe = 'apm_breeder_container_worn_maintenance'
    mod(recipe, m.carbon, 4)
    mod(recipe, alloys.lead, 4)

    recipe = 'apm_fuel_rod_container_maintenance'
    mod(recipe, m.carbon, 5)
    mod(recipe, alloys.lead, 4)

    recipe = 'apm_rtg_radioisotope_thermoelectric_generator'
    mod(recipe, alloys.lead, 10)

    recipe = 'apm_shielded_nuclear_fuel_cell'
    mod(recipe, alloys.lead, 4)

    recipe = 'nuclear-reactor'
    mod(recipe, alloys.lead, 500)
    mod(recipe, t.red.frame, 25)

    recipe = 'apm_nuclear_breeder'
    mod(recipe, alloys.lead, 250)
    mod(recipe, t.red.frame, 25)

    recipe = 'apm_hexafluoride_sample'
    mod(recipe, alloys.lead, 2)

    recipe = 'nuclear-reactor-2'
    mod(recipe, alloys.lead, 750)
    mod(recipe, t.red.frame, 25)
    mod(recipe, m.refined.concrete, 750)

    recipe = 'nuclear-reactor-3'
    mod(recipe, alloys.lead, 1000)
    mod(recipe, m.refined.concrete, 1250)
    mod(recipe, t.red.frame, 25)
    mod(recipe, alloys.tungstenCarbide, 1250)

    recipe = nuclear.rtg
    mod(recipe, 'apm_oxide_pellet_pu239', 2)
    mod(recipe, 'apm_depleted_uranium_ingots', 10)
    mod(recipe, alloys.lead, 20)
    mod(recipe, logic.PU, 20)

    mod('satellite', 'apm_rtg_radioisotope_thermoelectric_generator', 0)
    mod('satellite', recipe, 25)
    apm.lib.utils.recipe.remove('apm_rtg_radioisotope_thermoelectric_generator')

    -- change deuterium fuel cell 2 for super reactor
    recipe = nuclear.deuterium.cell.II
    mod(recipe, apm.bob_rework.lib.entities.chem.deuterium, 1200)
    mod(recipe, nuclear.fusion.catalyst, 1)
    local itm = data.raw.item[recipe]
    if itm then
        itm.fuel_value = '540GJ'
    end
end

buildNuclearRecipies()
