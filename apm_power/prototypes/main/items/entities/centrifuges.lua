require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/centrifuges.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_centrifuge_0',
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_ce
	},
	stack_size = 50,
	subgroup = "apm_power_machines_0",
	order = 'af_a',
	place_result = "apm_centrifuge_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}


data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_centrifuge_1',
	icons = {
		apm.lib.icons.dynamics.machine.t1,
		apm.lib.icons.dynamics.lable_ce
	},
	stack_size = 50,
	subgroup = "apm_power_machines_2",
	order = 'af_a',
	place_result = "apm_centrifuge_1",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_centrifuge_2',
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_ce
	},
	stack_size = 50,
	subgroup = "apm_power_machines_4",
	order = 'af_a',
	place_result = "apm_centrifuge_2",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}


data:extend({ item })
