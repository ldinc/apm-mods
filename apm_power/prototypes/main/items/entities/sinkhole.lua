require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/sieve.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sinkhole',
	icons = { apm.lib.icons.static.sinkhole },
	stack_size = 50,
	subgroup = "apm_power_machines_3",
	order = 'ad_a',
	place_result = "apm_sinkhole",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })


-- ----------------------------------------------------------------------------


local item_icon_a = apm.lib.utils.icon.get.from_item("pipe-to-ground")
local item_icon_b = { apm.lib.icons.dynamics.cooling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sinkhole_small',
	icons = icons,
	stack_size = 50,
	subgroup = "apm_power_machines_3",
	order = 'ad_a',
	place_result = "apm_sinkhole_small",

	weight = apm.lib.utils.constants.value.weight.building.small,
}

data:extend({ item })
