require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/intermediates.lua'

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_resin',
	icons = {
		apm.power.icons.resin
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_greenhouse",
	order = 'aa_a',

	weight = apm.lib.utils.constants.value.weight.product.resin,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_rubber',
	icons = {
		apm.power.icons.rubber
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'aa_a',

	weight = apm.lib.utils.constants.value.weight.product.rubber,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_gearing',
	icons = {
		apm.power.icons.gearing
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_a',

	weight = apm.lib.utils.constants.value.weight.product.gearing,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_wood_board',
	icons = {
		apm.power.icons.wood_board
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ac_a',

	weight = apm.lib.utils.constants.value.weight.product.motherboard,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_mechanical_relay',
	icons = {
		apm.power.icons.mechanical_relay
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ad_a',

	weight = apm.lib.utils.constants.value.weight.product.motherboard,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_steam_relay',
	icons = {
		apm.power.icons.steam_relay
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ad_b',

	weight = apm.lib.utils.constants.value.weight.product.motherboard,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_sealing_rings',
	icons = {
		apm.power.icons.sealing_rings
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'af_a',

	weight = apm.lib.utils.constants.value.weight.product.sealing_rings,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_treated_wood_planks',
	icons = {
		apm.power.icons.treated_wood_planks
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ag_a',
	fuel_category = 'chemical',
	fuel_value = "1MJ",

	weight = apm.lib.utils.constants.value.weight.product.defaults,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_electromagnet',
	icons = {
		apm.power.icons.electromagnet
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ah_a',

	weight = apm.lib.utils.constants.value.weight.product.motherboard,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_egen_unit',
	icons = {
		apm.power.icons.electric_generator_unit
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ah_a',

	weight = apm.lib.utils.constants.value.weight.product.engine,
}

data:extend({ item })


---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_crushed_stone',
	icons = {
		{ icon = apm.power.icons.crushed_stone.filename, icon_size = apm.power.icons.crushed_stone.icon_size, tint = apm.power.icons.crushed_stone.tint }
	},
	pictures = {
		apm.power.icons.crushed_stone,
		apm.power.icons.crushed_stone_1,
		apm.power.icons.crushed_stone_2,
		apm.power.icons.crushed_stone_3
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'aj_a',

	weight = apm.lib.utils.constants.value.weight.crushed_ore,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_stone_brick_raw',
	icons = {
		apm.power.icons.stone_brick_raw
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ak_a',

	weight = apm.lib.utils.constants.value.weight.default,
}

data:extend({ item })
---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_pistions',
	icons = {
		apm.power.icons.pistions
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_b',

	weight = apm.lib.utils.constants.value.weight.product.pistons,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_simple_engine',
	icons = {
		apm.power.icons.simple_engine
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_c',

	weight = apm.lib.utils.constants.value.weight.product.engine,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_steam_engine',
	icons = {
		apm.power.icons.steam_engine_unit
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_d',

	weight = apm.lib.utils.constants.value.weight.product.engine,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_basic',
	icons = {
		apm.power.icons.machine_frame_basic
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_e',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_basic_used',
	icons = {
		apm.power.icons.machine_frame_basic_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_f',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_steam',
	icons = {
		apm.power.icons.machine_frame_steam
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_g',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_steam_used',
	icons = {
		apm.power.icons.machine_frame_steam_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_h',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_advanced',
	icons = {
		apm.power.icons.machine_frame_advanced
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_i',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_iron_bearing_ball',
	icons = {
		apm.power.icons.iron_bearing_ball
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_i',

	weight = apm.lib.utils.constants.value.weight.product.bearing_ball,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_iron_bearing',
	icons = {
		apm.power.icons.iron_bearing
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_i',

	weight = apm.lib.utils.constants.value.weight.product.bearing,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_machine_frame_advanced_used',
	icons = {
		apm.power.icons.machine_frame_advanced_used
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_j',

	weight = apm.lib.utils.constants.value.weight.product.frame,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_gun_powder',
	icons = {
		apm.power.icons.gun_powder
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_power_intermediates",
	order = 'ab_j',

	weight = apm.lib.utils.constants.value.weight.product.gun_powder,
}

data:extend({ item })
