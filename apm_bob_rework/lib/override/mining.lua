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

local buildMiningAdvancedRecipe = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
end

apm.bob_rework.lib.override.mining = function ()
    buildMiningRecipe(apm.bob_rework.lib.entities.burnerMiner, apm.bob_rework.lib.tier.bronze)
    buildMiningAdvancedRecipe(apm.bob_rework.lib.entities.improvedBurnerMiner, apm.bob_rework.lib.entities.burnerMiner, apm.bob_rework.lib.tier.bronze)
   
    buildMiningRecipe(apm.bob_rework.lib.entities.steamMiner, apm.bob_rework.lib.tier.brass)
    
    buildMiningRecipe(apm.bob_rework.lib.entities.electricMiner_t2, apm.bob_rework.lib.tier.monel)
    buildMiningAdvancedRecipe(apm.bob_rework.lib.entities.advancedElectricMiner_t2, apm.bob_rework.lib.entities.electricMiner_t2, apm.bob_rework.lib.tier.monel)

    -- TODO: others tier
end
