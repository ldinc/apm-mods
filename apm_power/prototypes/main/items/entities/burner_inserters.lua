require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/burner_inserters.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_burner_long_inserter',
	icons = {
		apm.power.icons.burner_long_inserter
	},
	stack_size = 50,
	subgroup = "apm_power_inserter",
	order = 'ab_c',
	place_result = "apm_burner_long_inserter",

	weight = apm.lib.utils.constants.value.weight.building.inserter,
}

data:extend({ item })