require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/steam_inserters.lua'

local icon_path = "__apm_resource_pack_ldinc__/graphics/icons/"


APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = "item"
item.name = "apm_steam_inserter"
item.icon = icon_path .. "apm_steam_inserter.png"
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_inserter"
item.order = 'aa_a'
item.place_result = "apm_steam_inserter"
data:extend({ item })

local item = {}
item.type = "item"
item.name = "apm_steam_inserter_long"
item.icon = icon_path .. "apm_steam_inserter_long.png"
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_inserter"
item.order = 'aa_a'
item.place_result = "apm_steam_inserter_long"
data:extend({ item })
