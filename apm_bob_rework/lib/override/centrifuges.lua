if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildCentrifugeRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3 * tier.level)
    if tier.extraConstructionAlloy then
        local count = 8
        if tier.level == 1 then
            count = 10
        end
        if tier.level > 1 then
            count = 12
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 5 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.rubber, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
end

local buildNuclearCentrifuge = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, tier.level * 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 100 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 50 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 100 + 10 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 40 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 100 + 10 * tier.level)
end

apm.bob_rework.lib.override.centrifuges = function()
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.centrifuge, apm.bob_rework.lib.tier.gray)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.steamCentrifuge, apm.bob_rework.lib.tier.steam)
    buildCentrifugeRecipe(apm.bob_rework.lib.entities.advancedCentrifuge, apm.bob_rework.lib.tier.red)
    --
    buildNuclearCentrifuge('centrifuge', apm.bob_rework.lib.tier.red)
    -- buildNuclearCentrifuge('centrifuge-2', apm.bob_rework.lib.tier.aluminium)
    -- buildNuclearCentrifuge('centrifuge-3', apm.bob_rework.lib.tier.titanium)
end
