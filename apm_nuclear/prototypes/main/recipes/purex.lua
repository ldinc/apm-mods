require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/purex.lua"

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
	name = "apm_nuclear_ash",
	category = "smelting",

	enabled = false,
	energy_required = 3.5,
	ingredients = {
		{ type = "item", name = "coal", amount = 5 }
	},
	results = {
		{ type = "item", name = "apm_nuclear_ash", amount = 10 }
	},
	main_product = "apm_nuclear_ash",
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
	name = "apm_phosphorus",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.860, g = 0.180, b = 0.067 },
		secondary = { r = 0.860, g = 0.280, b = 0.067 },
		tertiary  = { r = 0.860, g = 0.360, b = 0.067 },
	},

	enabled = false,
	energy_required = 2,
	ingredients = {
		{ type = "fluid", name = "steam",           amount = 50 },
		{ type = "item",  name = "apm_nuclear_ash", amount = 10 }
	},
	results = {
		{ type = "item", name = "apm_phosphorus", amount = 1 }
	},
	main_product = "apm_phosphorus",
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
	name = "apm_phosphorpentachlorid",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.730, g = 0.800, b = 0.800 },
		secondary = { r = 0.860, g = 0.280, b = 0.067 },
		tertiary  = { r = 0.900, g = 1.000, b = 1.000 },
	},

	enabled = false,
	energy_required = 2,
	ingredients = {
		{ type = "item", name = "apm_phosphorus", amount = 2 }
	},
	results = {
		{ type = "item", name = "apm_phosphorpentachlorid", amount = 2 }
	},
	main_product = "apm_phosphorpentachlorid",
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
	name = "apm_phosphoroxychlorid",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.730, g = 0.800, b = 0.800 },
		secondary = { r = 0.860, g = 0.280, b = 0.067 },
		tertiary  = { r = 0.900, g = 1.000, b = 1.000 },
	},

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_phosphorpentachlorid", amount = 5 }
	},
	results = {
		{ type = "fluid", name = "apm_phosphoroxychlorid", amount = 50 }
	},
	main_product = "apm_phosphoroxychlorid",
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
	name = "apm_trimethyl_phosphate",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.730, g = 0.800, b = 0.800 },
		secondary = { r = 0.860, g = 0.280, b = 0.067 },
		tertiary  = { r = 0.900, g = 1.000, b = 1.000 },
	},

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "fluid", name = "petroleum-gas",  amount = 50 },
		{ type = "item",  name = "apm_phosphorus", amount = 5 }
	},
	results = {
		{ type = "fluid", name = "apm_trimethyl_phosphate", amount = 50 }
	},
	main_product = "apm_trimethyl_phosphate",
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
	name = "apm_tbp_30",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.730, g = 0.800, b = 0.600 },
		secondary = { r = 0.800, g = 0.700, b = 0.600 },
		tertiary  = { r = 0.730, g = 0.800, b = 0.600 },
	},

	enabled = false,
	energy_required = 3,
	ingredients = {
		{ type = "fluid", name = "light-oil",               amount = 70 },
		{ type = "fluid", name = "apm_trimethyl_phosphate", amount = 30 }
	},
	results = {
		{ type = "fluid", name = "apm_tbp_30", amount = 100 }
	},
	main_product = "apm_tbp_30",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
