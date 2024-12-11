require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/lib/data-interfaces.lua'

APM_LOG_HEADER(self)

local bool = require("bool")

if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end

---@type boolean
apm.lib.features.reuse_previous_tier = bool.startup("apm_power_machine_reusable_recipies")
