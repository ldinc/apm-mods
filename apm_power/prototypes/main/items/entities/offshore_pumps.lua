require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/offshore_pumps.lua'

APM_LOG_HEADER(self)


local item_icon_a = apm.lib.utils.icon.get.from_item('offshore-pump')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_offshore_pump_0',
	icons = icons,
	stack_size = 50,
	subgroup = "apm_power_machines_miner",
	order = 'ab_a',
	place_result = "apm_offshore_pump_0",

	weight = apm.lib.utils.constants.value.weight.building.small,
}

data:extend({ item })

local item_icon_a = apm.lib.utils.icon.get.from_item('offshore-pump')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_offshore_pump_1',
	icons = icons,
	stack_size = 50,
	subgroup = "apm_power_machines_miner",
	order = 'ab_b',
	place_result = "apm_offshore_pump_1",

	weight = apm.lib.utils.constants.value.weight.building.small,
}

data:extend({ item })
