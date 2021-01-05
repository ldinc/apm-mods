if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')


local buildBelts = function (tier)
    local recipe = tier.main.belt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 2)

    local recipe = tier.main.underBelt
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.belt, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 2)

    local recipe = tier.main.splitter
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.belt, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 2)
    if tier.level == 1 then
        apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 2)
    else
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 2)
    end

    local recipe = tier.main.loader
    if recipe then
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.belt, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 2)
        if tier.level == 1 then
            apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicContact, 2)
            apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.yellowInserter, 5)

        else
            apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.inserter, 5)
            apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, 2)
        end
    end
end

apm.bob_rework.lib.override.belts = function ()
    buildBelts(apm.bob_rework.lib.tier.bronze)
    buildBelts(apm.bob_rework.lib.tier.brass)
end
