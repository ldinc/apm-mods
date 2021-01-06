if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

apm.bob_rework.lib.override.drop = function ()
    apm.lib.utils.recipe.remove('apm_gearing')
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.machineFrame)
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.steamMachineFrame)
    apm.lib.utils.recipe.remove(apm.bob_rework.lib.entities.advancedMachineFrame)

    apm.lib.utils.recipe.remove('boiler-2-from-oil-boiler')
    apm.lib.utils.recipe.remove('boiler-3-from-heat-exchanger')
    apm.lib.utils.recipe.remove('boiler-3-from-oil-boiler-2')
    apm.lib.utils.recipe.remove('boiler-4-from-heat-exchanger-2')
    apm.lib.utils.recipe.remove('boiler-4-from-oil-boiler-3')
    apm.lib.utils.recipe.remove('boiler-5-from-heat-exchanger-4')
    apm.lib.utils.recipe.remove('boiler-5-from-heat-exchanger-3')
    apm.lib.utils.recipe.remove('boiler-5-from-oil-boiler-4')
    apm.lib.utils.recipe.remove('oil-boiler-2-from-boiler-3')
    apm.lib.utils.recipe.remove('oil-boiler-3-from-boiler-4')
    apm.lib.utils.recipe.remove('oil-boiler-4-from-boiler-5')
end