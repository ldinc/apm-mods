require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/intermediates.lua"

APM_LOG_HEADER(self)

local apm_nuclear_always_show_made_in = settings.startup["apm_nuclear_always_show_made_in"].value
APM_LOG_SETTINGS(self, "apm_nuclear_always_show_made_in", apm_nuclear_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_rod_container",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item", name = "steel-plate", amount = 4 }
	},
	results = {
		{ type = "item", name = "apm_fuel_rod_container", amount = 1 }
	},
	main_product = "apm_fuel_rod_container",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_fuel_rod_container_worn")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_rod_container_maintenance",
	category = "crafting-with-fluid",
	subgroup = "apm_nuclear_products",
	order = "aa_b",
	icons = icons,

	enabled = false,
	energy_required = 10,
	ingredients = {
		{ type = "item",  name = "apm_fuel_rod_container_worn", amount = 5 },
		{ type = "item",  name = "steel-plate",                 amount = 5 },
		{ type = "fluid", name = "water",                       amount = 50 }
	},
	results = {
		{ type = "item",  name = "apm_fuel_rod_container",     amount = 4 },
		{ type = "item",  name = "apm_fuel_rod_container",     amount_min = 1, amount_max = 1, probability = 0.85 },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = 50 },
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_products = true,
	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_breeder_container",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 4,
	ingredients = {
		{ type = "item", name = "steel-plate",                 amount = 2 },
		{ type = "item", name = "copper-plate",                amount = 5 },
		{ type = "item", name = "apm_depleted_uranium_ingots", amount = 10 }
	},
	results = {
		{ type = "item", name = "apm_breeder_container", amount = 1 }
	},
	main_product = "apm_breeder_container",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_breeder_container_worn")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })


---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_breeder_container_worn_maintenance",
	category = "crafting-with-fluid",
	subgroup = "apm_nuclear_products",
	order = "ab_b",
	icons = icons,

	enabled = false,
	energy_required = 10,
	ingredients = {
		{ type = "item",  name = "apm_breeder_container_worn",  amount = 5 },
		{ type = "item",  name = "copper-plate",                amount = 5 },
		{ type = "item",  name = "apm_depleted_uranium_ingots", amount = 5 },
		{ type = "fluid", name = "water",                       amount = 50 }
	},
	results = {
		{ type = "item",  name = "apm_breeder_container",      amount = 4 },
		{ type = "item",  name = "apm_breeder_container",      amount_min = 1, amount_max = 1, probability = 0.85 },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = 50 },
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_products = true,
	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_waste_container",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 2,
	ingredients = {
		{ type = "item", name = "iron-plate", amount = 5 }
	},
	results = {
		{ type = "item", name = "apm_waste_container", amount = 1 }
	},
	main_product = "apm_waste_container",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_depleted_uranium_metal_mixture",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 1.75,
	ingredients = {
		{ type = "item", name = "apm_oxide_pellet_u238", amount = 2 },
		{ type = "item", name = "iron-plate",            amount = 2 }
	},
	results = {
		{ type = "item", name = "apm_depleted_uranium_metal_mixture", amount = 2 }
	},
	main_product = "apm_depleted_uranium_metal_mixture",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_depleted_uranium_ingots",
	category = "apm_electric_smelting",

	enabled = false,
	energy_required = 4.5,
	ingredients = {
		{ type = "item", name = "apm_depleted_uranium_metal_mixture", amount = 2 }
	},
	results = {
		{ type = "item", name = "apm_depleted_uranium_ingots", amount = 2 }
	},
	main_product = "apm_depleted_uranium_ingots",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_rtg_radioisotope_thermoelectric_generator",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 12,
	ingredients = {
		{ type = "item", name = "iron-plate",                  amount = 10 },
		{ type = "item", name = "copper-plate",                amount = 10 },
		{ type = "item", name = "processing-unit",             amount = 5 },
		{ type = "item", name = "apm_depleted_uranium_ingots", amount = 10 },
		{ type = "item", name = "apm_oxide_pellet_pu239",      amount = 2 }
	},
	results = {
		{ type = "item", name = "apm_rtg_radioisotope_thermoelectric_generator", amount = 1 }
	},
	main_product = "apm_rtg_radioisotope_thermoelectric_generator",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_hexafluoride_sample",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.574, g = 1, b = 0, a = 0.000 },
		secondary = { r = 0.474, g = 1, b = 0, a = 0.000 },
		tertiary  = { r = 0.374, g = 1, b = 0, a = 0.000 }
	},

	enabled = false,
	energy_required = 3.5,
	ingredients = {
		{ type = "item",  name = "iron-plate",                   amount = 1 },
		{ type = "fluid", name = "apm_nuclear_hexafluoride_012", amount = 10 },
	},
	results = {
		{ type = "item", name = "apm_hexafluoride_sample", amount = 1 }
	},
	main_product = "apm_hexafluoride_sample",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
