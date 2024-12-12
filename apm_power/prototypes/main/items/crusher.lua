require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/crusher.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_crusher_drums',
	icons = {
		apm.power.icons.crusher_drums
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ac_a',

	weight = apm.lib.utils.constants.value.weight.product.drums,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_crusher_drums_used',
	icons = {
		apm.power.icons.crusher_drums_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ac_b',

	weight = apm.lib.utils.constants.value.weight.product.drums,
}

data:extend({ item })
