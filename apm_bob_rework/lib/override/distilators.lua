if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildDistilator = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local logic = tier.logic
    if tier.level == 1 then
        logic = apm.bob_rework.lib.entities.logicContact
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 4)
end

apm.bob_rework.lib.override.distilators = function ()
    buildDistilator('bob-distillery', apm.bob_rework.lib.tier.brass)
    buildDistilator('bob-distillery-2', apm.bob_rework.lib.tier.monel)
    buildDistilator('bob-distillery-3', apm.bob_rework.lib.tier.steel)
    buildDistilator('bob-distillery-4', apm.bob_rework.lib.tier.aluminium)
    buildDistilator('bob-distillery-5', apm.bob_rework.lib.tier.titanium)
end