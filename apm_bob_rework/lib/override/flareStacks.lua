if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildFlare = function (recipe)
    local tier = apm.bob_rework.lib.tier.monel
    if recipe == 'incinerator' then
        tier = apm.bob_rework.lib.tier.brass
    end
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 4)
end


local buildGasVenting = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 4)
end

apm.bob_rework.lib.override.flareStacks = function ()
    buildGasVenting('vent-stack', apm.bob_rework.lib.tier.monel)
    buildFlare('flare-stack')
    buildFlare('incinerator')
    buildFlare('electric-incinerator')

    -- local obj = data.raw.furnace['electric-incinerator']
    -- obj.result_inventory_size = 1
end