require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/greenhouse.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_tree_seeds',
	icons = {
		apm.power.icons.tree_seeds
	},
	stack_size = 50,
	subgroup = "apm_greenhouse",
	order = 'ab_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.product.tree_seeds,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_fertiliser_1',
	icons = {
		apm.power.icons.fertiliser_1
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_greenhouse",
	order = 'ab_b',

	weight = apm.lib.utils.constants.value.weight.default,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_fertiliser_2',
	icons = {
		apm.power.icons.fertiliser_2
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_greenhouse",
	order = 'ab_c',

	weight = apm.lib.utils.constants.value.weight.default,
}

data:extend({ item })