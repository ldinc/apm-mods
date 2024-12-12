require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/mining_drills.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_burner_miner_drill_2',
	icons = {
		apm.power.icons.burner_mining_drill,
		apm.lib.icons.dynamics.t2
	},
	stack_size = 50,
	subgroup = "apm_power_machines_miner",
	order = 'aa_b',
	place_result = "apm_burner_miner_drill_2",

	weight = apm.lib.utils.constants.value.weight.building.small,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_steam_mining_drill',
	icons = {
		apm.power.icons.electric_mining_drill,
		apm.lib.icons.dynamics.t1
	},
	stack_size = 50,
	subgroup = "apm_power_machines_miner",
	order = 'ac_b',
	place_result = "apm_steam_mining_drill",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
