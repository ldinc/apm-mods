if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildPumpRecipe = function (tier)
    local recipe = tier.main.pump
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pipe, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 3)
end

local buildOffshore = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pump, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 1)
end

apm.bob_rework.lib.override.pumps = function ()
    buildPumpRecipe(apm.bob_rework.lib.tier.bronze)
    -- buildPumpRecipe(apm.bob_rework.lib.entities.steamPress, apm.bob_rework.lib.tier.brass)
    buildOffshore('apm_offshore_pump_0', apm.bob_rework.lib.tier.bronze)
    -- TODO: electric offshore_pump
end
