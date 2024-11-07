require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/lib/data-interfaces.lua'

APM_LOG_HEADER(self)

if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end

---@type boolean
apm.lib.features.burner_inserter_with_infinite_energy_source = false

if type(settings.startup["apm_burner_inserter_with_infinite_energy_source"].value) == "boolean" then
	apm.lib.features.burner_inserter_with_infinite_energy_source =
	settings.startup["apm_burner_inserter_with_infinite_energy_source"].value
end
