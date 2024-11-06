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


-- ----------------------------------------------------------------------------


local item_icon_a = apm.lib.utils.icon.get.from_item("pipe-to-ground")
local item_icon_b = {apm.lib.icons.dynamics.cooling}
local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})

local item = {}
item.type = 'item'
item.name = 'apm_sinkhole_small'
item.icons =  icons
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_3"
item.order = 'ad_a'
item.place_result = "apm_sinkhole_small"
data:extend({item})