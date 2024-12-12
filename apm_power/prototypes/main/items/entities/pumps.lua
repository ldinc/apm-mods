require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/pumps.lua'

APM_LOG_HEADER(self)

local item_icon_a = apm.lib.utils.icon.get.from_item('pump')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_pump_0',
	icons = icons,
	stack_size = 50,
	subgroup = "apm_power_inserter",
	order = 'ba_a',
	place_result = "apm_pump_0",

	weight = apm.lib.utils.constants.value.weight.building.small,
}


data:extend({ item })
