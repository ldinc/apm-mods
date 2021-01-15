if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildCentrifugeRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.lightAlloy, 3)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.rubber, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
end

local buildNuclearCentrifuge = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, tier.level * 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 80 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)

end

apm.bob_rework.lib.override.centrifuges = function ()
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.centrifuge, apm.bob_rework.lib.tier.bronze)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.steamCentrifuge, apm.bob_rework.lib.tier.brass)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.advancedCentrifuge, apm.bob_rework.lib.tier.monel)
    --
    buildNuclearCentrifuge('centrifuge', apm.bob_rework.lib.tier.steel)
    buildNuclearCentrifuge('centrifuge-2', apm.bob_rework.lib.tier.aluminium)
    buildNuclearCentrifuge('centrifuge-3', apm.bob_rework.lib.tier.titanium)
end
