require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/integrations/generate.lua'

APM_LOG_HEADER(self)

apm.lib.utils.recycling.metal.generation()
apm.lib.utils.recycling.scrap.generate()
