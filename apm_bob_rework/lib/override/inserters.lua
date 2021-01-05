if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

local genInserterts = function (tier)
    local recipe = tier.main.inserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 1)
    if recipe == apm.bob_rework.lib.entities.steamInserter then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pipe, 1)
    end

    local recipe = tier.main.filterInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.inserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 4)
    end

    local recipe = tier.main.stackInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 5)
    end

    local recipe = tier.main.stackFilterInserter
    if recipe then 
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.stackInserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 5)
    end
end

local genYellowInserters = function ()
    local recipe = apm.bob_rework.lib.entities.yellowInserter
    local tier = apm.bob_rework.lib.tier.brass

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 1)

    local recipe = apm.bob_rework.lib.entities.yellowFilterInserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.yellowInserter, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 4)
end

apm.bob_rework.lib.override.inserters = function ()
    genInserterts(apm.bob_rework.lib.tier.bronze)
    genInserterts(apm.bob_rework.lib.tier.brass)
    -- gen second electric tier
    genYellowInserters()
end