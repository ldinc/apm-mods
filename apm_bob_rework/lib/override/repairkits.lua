if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildRepairKit = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
end

apm.bob_rework.lib.override.repairKits = function ()
    buildRepairKit('repair-kit', apm.bob_rework.lib.tier.bronze)
    buildRepairKit('repair-kit-2', apm.bob_rework.lib.tier.monel)
    buildRepairKit('repair-kit-3', apm.bob_rework.lib.tier.steel)
    buildRepairKit('repair-kit-4', apm.bob_rework.lib.tier.aluminium)
    buildRepairKit('repair-kit-5', apm.bob_rework.lib.tier.titanium)

    buildRepairKit('repair-pack', apm.bob_rework.lib.tier.bronze)
    buildRepairKit('repair-pack-2', apm.bob_rework.lib.tier.monel)
    buildRepairKit('repair-pack-3', apm.bob_rework.lib.tier.steel)
    buildRepairKit('repair-pack-4', apm.bob_rework.lib.tier.aluminium)
    buildRepairKit('repair-pack-5', apm.bob_rework.lib.tier.titanium)
end

apm.bob_rework.lib.override.repairKits()