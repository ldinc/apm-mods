require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/crushers.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_crusher_machine_0'
item.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_c
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_0"
item.order = 'ab_a'
item.place_result = "apm_crusher_machine_0"
data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_crusher_machine_1'
item.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_c
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_2"
item.order = 'ab_a'
item.place_result = "apm_crusher_machine_1"
data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_crusher_machine_2'
item.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_c
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_4"
item.order = 'aa_a'
item.place_result = "apm_crusher_machine_2"
data:extend({ item })
