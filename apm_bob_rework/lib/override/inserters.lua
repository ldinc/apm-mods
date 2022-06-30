if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local ins = require('lib.entities.buildings.inserters')
local t = require('lib.tier.base')

local genInserterts = function (tier, eK)
    local recipe = tier.inserter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, eK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    if recipe == ins.basic.steam then
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

apm.bob_rework.lib.override.inserters = function ()
    genInserterts(t.gray, 1)
    genInserterts(t.steam, 1)
    genInserterts(t.yellow, 1)
    genInserterts(t.red, 2)
    genInserterts(t.blue, 3)
end