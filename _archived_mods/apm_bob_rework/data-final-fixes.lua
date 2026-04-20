if apm == nil then apm = {} end
if apm.bob_rework == nil then apm.bob_rework = {} end

require('lib.override.base')

require('lib.override.deadlock')

apm.bob_rework.lib.override.apply()