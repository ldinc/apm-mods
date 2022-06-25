if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildPumpRecipe = function (tier)
    local recipe = tier.pump
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 3)
    local constructionAlloy = tier.constructionAlloy
    -- if tier.level == apm.bob_rework.lib.tier.monel.level then
    --     constructionAlloy = apm.bob_rework.lib.entities.iron
    -- end
    apm.lib.utils.recipe.ingredient.mod(recipe, constructionAlloy, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    local logic = tier.logic
    -- if tier.level == apm.bob_rework.lib.tier.monel.level then
    --     logic = apm.bob_rework.lib.entities.logicContact
    -- end
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, tier.level*2 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 3)
end

local buildOffshore = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local alloy = apm.bob_rework.lib.entities.iron
    local pipe = apm.bob_rework.lib.entities.ironPipe
    if tier.level == 0 then 
        alloy = tier.constructionAlloy
        pipe = tier.pipe
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
end

apm.bob_rework.lib.override.pumps = function ()
    buildPumpRecipe(apm.bob_rework.lib.tier.yellow)
    buildPumpRecipe(apm.bob_rework.lib.tier.red)
    buildPumpRecipe(apm.bob_rework.lib.tier.blue)
    -- buildPumpRecipe(apm.bob_rework.lib.tier.aluminium)
    -- buildPumpRecipe(apm.bob_rework.lib.tier.titanium)

    buildOffshore('apm_offshore_pump_0', apm.bob_rework.lib.tier.gray)
    buildOffshore('apm_offshore_pump_1', apm.bob_rework.lib.tier.yellow)
end
