if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildCentrifugeRecipe = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 10 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.rubber, 5)
end

apm.bob_rework.lib.override.centrifuges = function ()
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.centrifuge, apm.bob_rework.lib.tier.bronze)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.steamCentrifuge, apm.bob_rework.lib.tier.brass)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.advancedCentrifuge, apm.bob_rework.lib.tier.monel)
end
