if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

local genInserterts = function (tier, eK)
    local recipe = tier.inserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, eK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    if recipe == apm.bob_rework.lib.entities.steamInserter then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 1)
    end

    local recipe = tier.filterInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 4)
    end

    local recipe = tier.stackInserter
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, eK)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    end

    local recipe = tier.stackFilterInserter
    if recipe then 
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.stackInserter, 1)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    end
end

local genYellowInserters = function ()
    local recipe = apm.bob_rework.lib.entities.yellowInserter
    local tier = apm.bob_rework.lib.tier.brass

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 1)

    local recipe = apm.bob_rework.lib.entities.yellowFilterInserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.yellowInserter, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 4)
end

apm.bob_rework.lib.override.inserters = function ()
    genInserterts(apm.bob_rework.lib.tier.bronze, 1)
    genInserterts(apm.bob_rework.lib.tier.brass, 1)
    genInserterts(apm.bob_rework.lib.tier.monel, 2)
    genInserterts(apm.bob_rework.lib.tier.steel, 2)
    genInserterts(apm.bob_rework.lib.tier.aluminium, 3)
    genInserterts(apm.bob_rework.lib.tier.titanium, 3)
    -- gen second electric tier
    genYellowInserters()
end