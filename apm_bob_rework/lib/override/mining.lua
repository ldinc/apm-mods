if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildMiningRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 8 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 14 + 4*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 12 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12 + 3*tier.level)
    if tier.level > 1 then 
        apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironStick, 8 + 3*tier.level)
    end
    if tier.level < 1 then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 0)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 1)
    end
end

local buildMiningAdvancedRecipe = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
end

local buildYellowMiner = function ()
    local recipe, tier = apm.bob_rework.lib.entities.electricMiner_t2, apm.bob_rework.lib.tier.yellow
    local engine = apm.bob_rework.lib.entities.electricEngineUnit
    local logic = apm.bob_rework.lib.entities.logicContact

    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironStick, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 15)
end

apm.bob_rework.lib.override.mining = function ()
    buildMiningRecipe(apm.bob_rework.lib.entities.burnerMiner, apm.bob_rework.lib.tier.gray)
    buildMiningAdvancedRecipe(apm.bob_rework.lib.entities.improvedBurnerMiner, apm.bob_rework.lib.entities.burnerMiner, apm.bob_rework.lib.tier.gray)
   
    buildMiningRecipe(apm.bob_rework.lib.entities.steamMiner, apm.bob_rework.lib.tier.steam)
    
    -- buildMiningRecipe(apm.bob_rework.lib.entities.electricMiner_t2, apm.bob_rework.lib.tier.brass)
    buildYellowMiner()
    --TODO: addd m2 & mk3
    -- buildMiningRecipe(apm.bob_rework.lib.entities.advancedElectricMiner_t2, apm.bob_rework.lib.tier.monel)
    -- buildMiningAdvancedRecipe(apm.bob_rework.lib.entities.advancedElectricMiner_t2, apm.bob_rework.lib.entities.electricMiner_t2, apm.bob_rework.lib.tier.monel)

    -- buildMiningRecipe(apm.bob_rework.lib.entities.electricMiner_t3, apm.bob_rework.lib.tier.steel)
    -- buildMiningRecipe(apm.bob_rework.lib.entities.electricMiner_t4, apm.bob_rework.lib.tier.aluminium)
    -- buildMiningRecipe(apm.bob_rework.lib.entities.electricMiner_t5, apm.bob_rework.lib.tier.titanium)
end
