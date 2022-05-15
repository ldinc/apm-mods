require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/sieve.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_sinkhole'
item.icons =  {apm.lib.icons.static.sinkhole}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_3"
item.order = 'ad_a'
item.place_result = "apm_sinkhole"
data:extend({item})