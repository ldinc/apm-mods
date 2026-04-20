if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

local buildRepairKit = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
end

apm.bob_rework.lib.override.repairKits = function()
    buildRepairKit('repair-kit', t.gray)
    buildRepairKit('repair-kit-2', t.red)
    buildRepairKit('repair-kit-3', t.blue)

    buildRepairKit('repair-pack', t.gray)
    buildRepairKit('repair-pack-2', t.red)
    buildRepairKit('repair-pack-3', t.blue)
end

apm.bob_rework.lib.override.repairKits()
