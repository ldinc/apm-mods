require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_recycling/prototypes/main/items.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_recycling_machine_0",
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_r
	},
	stack_size = 10,

	subgroup = "apm_recycling_machines",
	order = "aa_a",
	place_result = "apm_recycling_machine_0",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_recycling_machine_1",
	icons = {
		apm.lib.icons.dynamics.machine.t1,
		apm.lib.icons.dynamics.lable_r
	},
	stack_size = 10,
	subgroup = "apm_recycling_machines",
	order = "aa_b",
	place_result = "apm_recycling_machine_1",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_recycling_machine_2",
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_r
	},
	stack_size = 10,
	subgroup = "apm_recycling_machines",
	order = "aa_c",
	place_result = "apm_recycling_machine_2",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_recycling_machine_3",
	icons = {
		apm.lib.icons.dynamics.machine.t3,
		apm.lib.icons.dynamics.lable_r
	},
	stack_size = 10,
	subgroup = "apm_recycling_machines",
	order = "aa_d",
	place_result = "apm_recycling_machine_3",
}

data:extend({ item })
