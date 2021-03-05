if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildChemicalPlant = function (recipe, tier, compressor)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15*tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 5)
    local count = 1
    if tier.level >= 4 then
        count = 2
    end
    -- apm.lib.utils.recipe.ingredient.mod(recipe, compressor, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.tier.pump, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.filter, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 10 + 5*tier.level)
    -- apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 10)
end

apm.bob_rework.lib.override.chemicalPlants = function ()
    buildChemicalPlant('chemical-plant', apm.bob_rework.lib.tier.monel, 'air-pump')
    buildChemicalPlant('chemical-plant-2', apm.bob_rework.lib.tier.steel, 'air-pump-2')
    buildChemicalPlant('chemical-plant-3', apm.bob_rework.lib.tier.aluminium, 'air-pump-3')
    buildChemicalPlant('chemical-plant-4', apm.bob_rework.lib.tier.titanium, 'air-pump-4')
end