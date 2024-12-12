require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/smelting.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_stone_crucible_raw',
	icons = {
		apm.power.icons.crucible_raw
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_smelting",
	order = 'aa_c',

	weight = apm.lib.utils.constants.value.weight.default,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_stone_crucible',
	icons = {
		apm.power.icons.crucible
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_smelting",
	order = 'aa_c',

	weight = apm.lib.utils.constants.value.weight.default,
}

data:extend({ item })
