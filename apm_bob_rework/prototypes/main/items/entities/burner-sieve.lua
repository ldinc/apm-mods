require('util')

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_burner_sieve'
item.icons = {
    apm.lib.icons.dynamics.machine.t1,
    apm.lib.icons.dynamics.lable_si
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_0"
item.order = 'ad_a'
item.place_result = "apm_burner_sieve"
data:extend({item})