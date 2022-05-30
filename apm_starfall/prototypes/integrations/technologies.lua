require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/integrations/recipes.lua'

APM_LOG_HEADER(self)

local apm_starfall_compat_bob = settings.startup["apm_starfall_compat_bob"].value
local apm_starfall_compat_angel = settings.startup["apm_starfall_compat_angel"].value
local apm_starfall_compat_earendel = settings.startup["apm_starfall_compat_earendel"].value
local apm_starfall_compat_reverse_factory = settings.startup["apm_starfall_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_starfall_compat_bob', apm_starfall_compat_bob)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_angel', apm_starfall_compat_angel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_earendel', apm_starfall_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_reverse_factory', apm_starfall_compat_reverse_factory)

-- Angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_starfall_compat_angel then
    apm.lib.utils.technology.add.prerequisites('apm_starfall_catalysis', 'water-treatment')
end
