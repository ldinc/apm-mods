if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildRadar = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local logic = tier.logic
    if tier.level == 1 then
        logic = apm.bob_rework.enities.logicContact
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.enities.electricEngineUnit, tier.level)
end

apm.bob_rework.lib.override.radars = function ()
    buildRadar('radar', apm.bob_rework.lib.tier.brass)
    buildRadar('radar-2', apm.bob_rework.lib.tier.monel)
    buildRadar('radar-3', apm.bob_rework.lib.tier.steel)
    buildRadar('radar-4', apm.bob_rework.lib.tier.aluminium)
    buildRadar('radar-5', apm.bob_rework.lib.tier.titanium)
end

apm.bob_rework.lib.override.radars()