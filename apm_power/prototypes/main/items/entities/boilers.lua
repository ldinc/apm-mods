require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/boilers.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_boiler_2',
	icons = {
		apm.power.icons.boiler,
		apm.lib.icons.dynamics.t2
	},

	stack_size = 50,
	subgroup = "energy",
	order = "b[steam-power]-b[apm_boiler_2]",
	place_result = "apm_boiler_2",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
