require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/furnaces.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_puddling_furnace_0',
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_pf
	},
	stack_size = 50,
	subgroup = "apm_power_machines_1",
	order = 'ab_a',
	place_result = "apm_puddling_furnace_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {
	type = 'item',
	name = 'apm_steelworks_0',
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_sw
	},
	stack_size = 50,
	subgroup = "apm_power_machines_4",
	order = 'ag_a',
	place_result = "apm_steelworks_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {
	type = 'item',
	name = 'apm_steelworks_1',
	icons = {
		apm.lib.icons.dynamics.machine.t3,
		apm.lib.icons.dynamics.lable_sw
	},
	stack_size = 50,
	subgroup = "apm_power_machines_5",
	order = 'ag_a',
	place_result = "apm_steelworks_1",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
