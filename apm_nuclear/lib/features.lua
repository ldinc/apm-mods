require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.features')

local self = 'apm_nuclear/lib/features.lua'

APM_LOG_HEADER(self)

if not apm.nuclear.features then apm.nuclear.features = {} end

---@type boolean
apm.nuclear.features.show_made_in =
	apm.lib.features.startup.get_boolean_value_from_setting("apm_nuclear_always_show_made_in")

APM_LOG_SETTINGS(self, "apm_nuclear_always_show_made_in", apm.nuclear.features.show_made_in)
