require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/greenhouse.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_greenhouse_0',
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_gh
	},
	stack_size = 50,
	subgroup = "apm_power_machines_1",
	order = 'aa_a',
	place_result = "apm_greenhouse_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_greenhouse_1',
	icons = {
		apm.lib.icons.dynamics.machine.t1,
		apm.lib.icons.dynamics.lable_gh
	},
	stack_size = 50,
	subgroup = "apm_power_machines_3",
	order = 'aa_a',
	place_result = "apm_greenhouse_1",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_greenhouse_2',
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_gh
	},
	stack_size = 50,
	subgroup = "apm_power_machines_4",
	order = 'aa_a',
	place_result = "apm_greenhouse_2",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
