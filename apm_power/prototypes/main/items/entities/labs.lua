require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/labs.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_lab_0',
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_l
	},
	stack_size = 50,
	subgroup = "apm_power_machines_0",
	order = 'ae_a',
	place_result = "apm_lab_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_lab_1',
	icons = {
		apm.lib.icons.dynamics.machine.t1,
		apm.lib.icons.dynamics.lable_l
	},
	stack_size = 50,
	subgroup = "apm_power_machines_2",
	order = 'ae_a',
	place_result = "apm_lab_1",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
