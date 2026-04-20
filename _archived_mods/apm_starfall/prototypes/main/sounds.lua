require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/sounds.lua'

APM_LOG_HEADER(self)

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local sound = {}
sound.type = "sound"
sound.name = "apm_meteorite_discovered"
sound.variations = {}
sound.variations[1] = {}
sound.variations[1].filename = "__apm_resource_pack_ldinc__/sounds/notification/apm_meteorite_discovered.ogg"
sound.variations[1].volume = 0.75
data:extend({sound})

-- Sound ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
sound = table.deepcopy(sound)
sound.name = "apm_meteorite_impact"
sound.variations[1].filename = "__apm_resource_pack_ldinc__/sounds/ambient/apm_meteorite_impact.ogg"
data:extend({sound})
