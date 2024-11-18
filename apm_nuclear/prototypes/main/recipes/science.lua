require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/science.lua"

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
	name = "apm_nuclear_science_pack",
	category = "advanced-crafting",

	enabled = false,
	energy_required = 21,
	ingredients = {
		{ type = "item", name = "processing-unit",             amount = 3 },
		{ type = "item", name = "apm_oxide_pellet_np237",      amount = 1 },
		{ type = "item", name = "apm_hexafluoride_sample",     amount = 5 },
		{ type = "item", name = "apm_depleted_uranium_ingots", amount = 10 }
	},
	results = {
		{ type = "item", name = "apm_nuclear_science_pack", amount = 3 }
	},
	main_product = "apm_nuclear_science_pack",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
