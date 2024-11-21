require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/integrations/entities.lua'

APM_LOG_HEADER(self)

local apm_recycler_integration_bob = settings.startup["apm_recycler_integration_bob"].value
local apm_recycler_integration_angel = settings.startup["apm_recycler_integration_angel"].value
local apm_recycler_integration_earendel = settings.startup["apm_recycler_integration_earendel"].value
local apm_recycler_integration_kingarthur = settings.startup["apm_recycler_integration_kingarthur"].value
local apm_recycler_integration_sctm = settings.startup["apm_recycler_integration_sctm"].value

local apm_recycler_compat_bob = settings.startup["apm_recycler_compat_bob"].value
local apm_recycler_compat_angel = settings.startup["apm_recycler_compat_angel"].value
local apm_recycler_compat_earendel = settings.startup["apm_recycler_compat_earendel"].value
local apm_recycler_compat_kingarthur = settings.startup["apm_recycler_compat_kingarthur"].value
local apm_recycler_compat_sctm = settings.startup["apm_recycler_compat_sctm"].value

APM_LOG_SETTINGS(self, 'apm_recycler_integration_bob', apm_recycler_integration_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_angel', apm_recycler_integration_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_earendel', apm_recycler_integration_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_kingarthur', apm_recycler_integration_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_integration_sctm', apm_recycler_integration_sctm)

APM_LOG_SETTINGS(self, 'apm_recycler_compat_bob', apm_recycler_compat_bob)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_angel', apm_recycler_compat_angel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_earendel', apm_recycler_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_kingarthur', apm_recycler_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_recycler_compat_sctm', apm_recycler_compat_sctm)

-- earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['space-exploration'] and apm_recycler_compat_earendel then
	apm.lib.utils.assembler.mod.category.add('se-space-recycling-facility', 'apm_recycling_1')
	apm.lib.utils.assembler.mod.category.add('se-space-recycling-facility', 'apm_recycling_2')
	apm.lib.utils.assembler.mod.category.add('se-space-recycling-facility', 'apm_recycling_3')
	apm.lib.utils.assembler.mod.category.add('se-space-recycling-facility', 'apm_recycling_4')
end
