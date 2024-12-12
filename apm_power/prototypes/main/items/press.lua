require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/press.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_press_plates',
	icons = {
		apm.power.icons.press_plates
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ad_a',

	weight = apm.lib.utils.constants.value.weight.plate,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_press_plates_used',
	icons = {
		apm.power.icons.press_plates_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ad_b',

	weight = apm.lib.utils.constants.value.weight.plate,
}

data:extend({ item })
