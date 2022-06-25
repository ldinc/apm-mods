if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildBelts = function (tier)
    local recipe = tier.belt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
    apm.lib.utils.recipe.result.mod(recipe, recipe, 2)

    local recipe = tier.underBelt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)

    local recipe = tier.splitter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    if tier.level == 1 then
        apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 2)
    else
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    end

    local recipe = tier.loader
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.belt, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
        if tier.level == 1 then
            apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 2)
            apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.yellowInserter, 5)

        else
            apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 5)
            apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
        end
    end
end

apm.bob_rework.lib.override.belts = function ()
    buildBelts(apm.bob_rework.lib.tier.gray)
    -- steam same as yellow
    buildBelts(apm.bob_rework.lib.tier.yellow)
    buildBelts(apm.bob_rework.lib.tier.red)
    buildBelts(apm.bob_rework.lib.tier.blue)
end
