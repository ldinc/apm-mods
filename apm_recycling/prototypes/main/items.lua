require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/items.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_recycling_machine_0'
item.icons = {
    apm.lib.icons.dynamics.machine.t0,
    apm.lib.icons.dynamics.lable_r
}
item.stack_size = 10
item.group = "apm_recycling"
item.subgroup = "apm_recycling_machines"
item.order = 'aa_a'
item.place_result = "apm_recycling_machine_0"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_recycling_machine_1'
item.icons = {
    apm.lib.icons.dynamics.machine.t1,
    apm.lib.icons.dynamics.lable_r
}
item.stack_size = 10
item.group = "apm_recycling"
item.subgroup = "apm_recycling_machines"
item.order = 'aa_b'
item.place_result = "apm_recycling_machine_1"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_recycling_machine_2'
item.icons = {
    apm.lib.icons.dynamics.machine.t2,
    apm.lib.icons.dynamics.lable_r
}
item.stack_size = 10
item.group = "apm_recycling"
item.subgroup = "apm_recycling_machines"
item.order = 'aa_c'
item.place_result = "apm_recycling_machine_2"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_recycling_machine_3'
item.icons = {
    apm.lib.icons.dynamics.machine.t3,
    apm.lib.icons.dynamics.lable_r
}
item.stack_size = 10
item.group = "apm_recycling"
item.subgroup = "apm_recycling_machines"
item.order = 'aa_d'
item.place_result = "apm_recycling_machine_3"
data:extend({item})
