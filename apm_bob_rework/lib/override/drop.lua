if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

apm.bob_rework.lib.override.drop = function ()
    apm.lib.utils.recipe.remove('apm_gearing')
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.machineFrame)
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.steamMachineFrame)
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.advancedMachineFrame)
end