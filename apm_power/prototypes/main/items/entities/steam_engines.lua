require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/steam_engines.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_steam_engine_2',
	icons = {
		apm.power.icons.steam_engine,
		apm.lib.icons.dynamics.t2
	},
	stack_size = 10,
	subgroup = "energy",
	order = "b[steam-power]-c[steam-engine]",
	place_result = "apm_steam_engine_2",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
