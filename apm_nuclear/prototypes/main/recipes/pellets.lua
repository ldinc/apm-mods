require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/pellets.lua"

APM_LOG_HEADER(self)

local apm_nuclear_always_show_made_in = settings.startup["apm_nuclear_always_show_made_in"].value
APM_LOG_SETTINGS(self, "apm_nuclear_always_show_made_in", apm_nuclear_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid = data.raw.fluid["apm_nuclear_hexafluoride_002"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_oxide_pellet_u238",
	category = "chemistry",
	enabled = false,
	energy_required = 2,
	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color,
	},
	ingredients = {
		{ type = "fluid", name = fluid.name, amount = 5 },
		apm.lib.utils.builder.recipe.item.simple("APM_WATER", 2.5)
	},
	results = {
		{ type = "item", name = "apm_oxide_pellet_u238", amount = 1 }
	},
	main_product = "apm_oxide_pellet_u238",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid = data.raw.fluid["apm_nuclear_hexafluoride_047"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_oxide_pellet_u235",
	category = "chemistry",
	enabled = false,
	energy_required = 2.5,

	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color,
	},
	ingredients = {
		{ type = "fluid", name = fluid.name, amount = 5 },
		apm.lib.utils.builder.recipe.item.simple("APM_WATER", 2.5)
	},
	results = {
		{ type = "item", name = "apm_oxide_pellet_u235", amount = 1 }
	},
	main_product = "apm_oxide_pellet_u235",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
