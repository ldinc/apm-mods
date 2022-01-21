if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildMiningRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 5)
end

local buildImprovedBurnerMinerRecipe = function ()
    local recipe = apm.bob_rework.lib.entities.improvedBurnerMiner
    local tier = apm.bob_rework.lib.tier.bronze

    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.burnerMiner, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
end

apm.bob_rework.lib.override.mining = function ()
    buildMiningRecipe(apm.bob_rework.lib.entities.burnerMiner, apm.bob_rework.lib.tier.bronze)
    buildImprovedBurnerMinerRecipe()
    buildMiningRecipe(apm.bob_rework.lib.entities.steam, apm.bob_rework.lib.tier.brass)
    buildMiningRecipe(apm.bob_rework.lib.entities.steamMiner, apm.bob_rework.lib.tier.brass)

end
