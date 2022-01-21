if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildNuclearRecipies = function ()
    local recipe = 'apm_fuel_rod_container'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.carbon, 5)

    local recipe = 'apm_breeder_container'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.carbon, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 5)

    local recipe = 'apm_breeder_container_worn_maintenance'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.carbon, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 4)

    local recipe = 'apm_fuel_rod_container_maintenance'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.carbon, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 4)

    local recipe = 'apm_rtg_radioisotope_thermoelectric_generator'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 10)

    local recipe = 'apm_shielded_nuclear_fuel_cell'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 4)

    local recipe = 'nuclear-reactor'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 500)

    local recipe = 'apm_nuclear_breeder'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 250)

    local recipe = 'apm_hexafluoride_sample'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 2)

    local recipe = 'nuclear-reactor-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 750)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.refinedConcrete, 750)

    local recipe = 'nuclear-reactor-3'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 1000)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.refinedConcrete, 1250)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungstenCarbide, 1250)

    -- merge rtg with bob
    -- apm.lib.utils.recipe.remove('apm_rtg_radioisotope_thermoelectric_generator')
    
    
    local recipe = 'rtg'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_oxide_pellet_pu239', 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicProcessing, 20)

    apm.lib.utils.recipe.ingredient.mod('satellite', 'apm_rtg_radioisotope_thermoelectric_generator', 0)
    apm.lib.utils.recipe.ingredient.mod('satellite', recipe, 25)
    apm.lib.utils.recipe.remove('apm_rtg_radioisotope_thermoelectric_generator')



end

buildNuclearRecipies()