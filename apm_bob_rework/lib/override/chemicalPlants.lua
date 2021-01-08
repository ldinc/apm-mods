if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildChemicalPlant = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15*tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, 10 + 5*tier.level)
end

apm.bob_rework.lib.override.chemicalPlants = function ()
    buildChemicalPlant('chemical-plant', apm.bob_rework.lib.tier.monel)
end