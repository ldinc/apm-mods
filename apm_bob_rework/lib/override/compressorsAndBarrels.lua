if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildCompressor = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.filter, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
end

local buildBarrelling = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)

end

local buildGasVenting = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 4 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 4)
end

apm.bob_rework.lib.override.compressorsAndBarrels = function ()
    buildCompressor('air-pump', apm.bob_rework.lib.tier.red)
    buildCompressor('air-pump-2', apm.bob_rework.lib.tier.blue)

    buildBarrelling('water-pump', apm.bob_rework.lib.tier.red)
    buildBarrelling('water-pump-2', apm.bob_rework.lib.tier.blue)

    buildGasVenting('void-pump', apm.bob_rework.lib.tier.yellow)
end