require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/tools.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_saw_blade_iron',
	icons = {
		apm.power.icons.saw_blade_iron
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ae_a',

	weight = apm.lib.utils.constants.value.weight.product.saw,
}

data:extend({ item })


---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_saw_blade_iron_used',
	icons = {
		apm.power.icons.saw_blade_iron_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ae_b',

	weight = apm.lib.utils.constants.value.weight.product.saw,
}

data:extend({ item })


---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_saw_blade_steel',
	icons = {
		apm.power.icons.saw_blade_steel
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'af_a',

	weight = apm.lib.utils.constants.value.weight.product.saw,
}

data:extend({ item })


---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_saw_blade_steel_used',
	icons = {
		apm.power.icons.saw_blade_steel_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'af_b',

	weight = apm.lib.utils.constants.value.weight.product.saw,
}

data:extend({ item })
