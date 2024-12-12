require('util')
require('__apm_lib_ldinc__.lib.log')

local item_sounds = require("__base__.prototypes.item_sounds")

local self = 'apm_power/prototypes/main/items/air_cleaner.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_filter_charcoal',
	icons = {
		apm.power.icons.filter_charcoal
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ab_a',
	inventory_move_sound = item_sounds.metal_small_inventory_move,
	pick_sound = item_sounds.metal_small_inventory_pickup,
	drop_sound = item_sounds.metal_small_inventory_move,

	weight = apm.lib.utils.constants.value.weight.product.filter,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_filter_charcoal_used',
	icons = {
		apm.power.icons.filter_charcoal_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_tools",
	order = 'ab_b',
	inventory_move_sound = item_sounds.metal_small_inventory_move,
	pick_sound = item_sounds.metal_small_inventory_pickup,
	drop_sound = item_sounds.metal_small_inventory_move,

	weight = apm.lib.utils.constants.value.weight.product.filter,
}


data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_ammonium_sulfate',
	icons = {
		apm.power.icons.ammonium_sulfate
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_greenhouse",
	order = 'ab_c',
	inventory_move_sound = item_sounds.resource_inventory_move,
	pick_sound = item_sounds.resource_inventory_pickup,
	drop_sound = item_sounds.resource_inventory_move,

	weight = apm.lib.utils.constants.value.weight.chemistry,
}


data:extend({ item })
