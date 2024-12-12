require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/fuels.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_coal_crushed',
	icons = {
		apm.power.icons.coal_crushed
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_coal",
	order = 'aa_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_coal_briquette',
	icons = {
		apm.power.icons.coal_brick
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_coal",
	order = 'ab_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_coke',
	icons = {
		apm.lib.icons.chunk_bg_w,
		apm.power.icons.coke_chunk
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_coke",
	order = 'aa_a',
	fuel_category = 'apm_refined_chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_coke_crushed',
	icons = {
		apm.lib.icons.crushed_bg_w,
		apm.power.icons.coke_crushed
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_coke",
	order = 'ab_a',
	fuel_category = 'apm_refined_chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_coke_brick',
	icons = {
		apm.lib.icons.briquette_bg_w,
		apm.power.icons.coke_brick
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_coke",
	order = 'ac_a',
	fuel_category = 'apm_refined_chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_wood_pellets',
	icons = {
		apm.power.icons.wood_crushed
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_wood",
	order = 'ac_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_wood_briquette',
	icons = {
		apm.power.icons.wood_brick
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_wood",
	order = 'ad_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_charcoal',
	icons = {
		apm.power.icons.charcoal_chunk
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_charcoal",
	order = 'aa_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_charcoal_brick',
	icons = {
		apm.power.icons.charcoal_brick
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_charcoal",
	order = 'ab_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",


	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
