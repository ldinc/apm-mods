require('util')
require('__apm_lib_ldinc__.lib.log')

local inline_storage_tank = require('graphics.inline_storage_tank')

local self = 'apm_power/prototypes/main/items/entities/greenhouse.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_inline_storage_tank',
	icons = {
		inline_storage_tank.icon,
	},
	stack_size = 50,
	subgroup = "storage",
	order = 'aist_a',
	place_result = "apm_inline_storage_tank",

	weight = apm.lib.utils.constants.value.weight.building.small,
}

data:extend({ item })
