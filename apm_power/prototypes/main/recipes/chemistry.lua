require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/chemistry.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_iron')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_1",
	category = 'advanced-crafting',
	subgroup = "apm_power_intermediates",
	order = 'ag_a',
	icons = icons,

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item",  name = "wood",               amount = 5 },
		{ type = "item",  name = "apm_saw_blade_iron", amount = 1 },
		{ type = "fluid", name = "apm_creosote",       amount = 50 }
	},
	results = {
		{ type = 'item', name = 'apm_treated_wood_planks', amount = 10 },
		{ type = "item", name = "apm_saw_blade_iron_used", amount = 1, catalyst_amount = 1 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_iron')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_1b",
	category = 'advanced-crafting',
	subgroup = "apm_power_intermediates",
	order = 'ag_a',
	icons = icons,

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item",  name = "wood",               amount = 5 },
		{ type = "item",  name = "apm_saw_blade_iron", amount = 1 },
		{ type = "fluid", name = "heavy-oil",          amount = 50 }
	},
	results = {
		{ type = 'item', name = 'apm_treated_wood_planks', amount = 10 },
		{ type = "item", name = "apm_saw_blade_iron_used", amount = 1, catalyst_amount = 1 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_steel')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_2",
	category = 'crafting-with-fluid',
	subgroup = "apm_power_intermediates",
	order = 'ag_a',
	icons = icons,

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item",  name = "wood",                amount = 5 },
		{ type = "item",  name = "apm_saw_blade_steel", amount = 1 },
		{ type = "fluid", name = "apm_creosote",        amount = 50 }
	},
	results = {
		{ type = 'item', name = 'apm_treated_wood_planks',  amount = 15 },
		{ type = "item", name = "apm_saw_blade_steel_used", amount = 1, catalyst_amount = 1 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_treated_wood_planks')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_steel')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_2b",
	category = 'crafting-with-fluid',
	subgroup = "apm_power_intermediates",
	order = 'ag_b',
	icons = icons,

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item",  name = "wood",                amount = 5 },
		{ type = "item",  name = "apm_saw_blade_steel", amount = 1 },
		{ type = "fluid", name = "heavy-oil",           amount = 50 }
	},
	results = {
		{ type = 'item', name = 'apm_treated_wood_planks',  amount = 15 },
		{ type = "item", name = "apm_saw_blade_steel_used", amount = 1, catalyst_amount = 1 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_item('wood')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_wood_1",
	category = 'oil-processing',
	subgroup = "apm_power_fluid",
	order = 'ba_a',
	icons = icons,

	enabled = false,
	energy_required = 4.5,
	ingredients = {
		{ type = "item",  name = "wood",  amount = 10 },
		{ type = "fluid", name = "steam", amount = 50 }
	},
	results = {
		{ type = 'fluid', name = 'apm_creosote',      amount = 80 },
		{ type = "fluid", name = "apm_coke_oven_gas", amount = 20 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_creosote')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_creosote_1",
	category = 'oil-processing',
	subgroup = "apm_power_fluid",
	order = 'ba_b',
	icons = icons,

	enabled = false,
	energy_required = 4.5,
	ingredients = {
		{ type = "fluid", name = "apm_creosote", amount = 100 },
		{ type = "fluid", name = "steam",        amount = 50 }
	},
	results = {
		{ type = 'fluid', name = 'heavy-oil',     amount = 25 },
		{ type = "fluid", name = "light-oil",     amount = 20 },
		{ type = "fluid", name = "petroleum-gas", amount = 15 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe('basic-oil-processing')
recipe_icon = apm.lib.utils.icons.mod(recipe_icon, 1, { 4, 0 })
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_coke_oven_gas')
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_coke_oven_gas_1",
	category = 'chemistry',
	subgroup = "apm_power_fluid",
	order = 'ba_c',
	icons = icons,
	crafting_machine_tint = {
		primary = { r = 0.764, g = 0.596, b = 0.780, a = 1.000 }, -- #c298c6ff
		secondary = { r = 0.762, g = 0.551, b = 0.844, a = 1.000 }, -- #c28cd7ff
		tertiary = { r = 0.895, g = 0.773, b = 0.596, a = 1.000 }, -- #e4c597ff
		quaternary = { r = 1.000, g = 0.734, b = 0.290, a = 1.000 }, -- #ffbb49ff
	},

	enabled = false,
	energy_required = 4.5,
	ingredients = {
		{ type = "fluid", name = "apm_coke_oven_gas", amount = 100 }
	},
	results = {
		{ type = "fluid", name = "petroleum-gas", amount = 10 }
	},
	main_product = '',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })
