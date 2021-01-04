if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end


require('lib.override.machineFrames')
require('lib.override.crusher')

apm.bob_rework.lib.override.apply = function ()
    apm.bob_rework.lib.override.machineFrames()
    apm.bob_rework.lib.override.crusher()
end

