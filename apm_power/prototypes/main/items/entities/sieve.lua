require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/sieve.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sieve_0',
	icons = {
		apm.lib.icons.dynamics.machine.t1,
		apm.lib.icons.dynamics.lable_si
	},
	stack_size = 50,
	subgroup = "apm_power_machines_3",
	order = 'ad_a',
	place_result = "apm_sieve_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}


data:extend({ item })
