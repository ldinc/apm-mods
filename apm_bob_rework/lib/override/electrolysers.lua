if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildElectrolyser = function (recipe, tier)
    local logic = tier.logic
    if tier.level == 1 then
        logic = apm.bob_rework.lib.entities.logicContact
    end

    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.silver, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1)

end

apm.bob_rework.lib.override.electrolysers = function ()
    buildElectrolyser('electrolyser', apm.bob_rework.lib.tier.brass)
    buildElectrolyser('electrolyser-2', apm.bob_rework.lib.tier.monel)
    buildElectrolyser('electrolyser-3', apm.bob_rework.lib.tier.steel)
    buildElectrolyser('electrolyser-4', apm.bob_rework.lib.tier.aluminium)
    buildElectrolyser('electrolyser-5', apm.bob_rework.lib.tier.titanium)
end