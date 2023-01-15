require('util')
require('__apm_lib_ldinc__.lib.log')

local inline_storage_tank = require('graphics.inline_storage_tank')

local self = 'apm_power/prototypes/main/items/entities/greenhouse.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_inline_storage_tank'
item.icons = {
    inline_storage_tank.icon,
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "storage"
item.order = 'aist_a'
item.place_result = "apm_inline_storage_tank"
data:extend({item})