require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/air_cleaner.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_filter_charcoal"
}

recipe.categories = { "advanced-crafting" }

recipe.enabled = false
recipe.energy_required = 1
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item", name = "steel-plate",        amount = 1 },
	{ type = "item", name = "apm_charcoal_brick", amount = 1 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item", name = "apm_filter_charcoal", amount = 3 }
}
recipe.main_product = "apm_filter_charcoal"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_filter_charcoal_used_recycling"
}

recipe.subgroup = "apm_power_tools"
recipe.order = "ab_b"
recipe.icons = {
	apm.power.icons.filter_charcoal_used,
	apm.lib.icons.dynamics.recycling
}

recipe.categories = { "crafting-with-fluid" }
recipe.enabled = false
recipe.energy_required = 2
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "fluid", name = "water",                    amount = 30 },
	{ type = "item",  name = "apm_filter_charcoal_used", amount = 3 },
	{ type = "item",  name = "apm_charcoal_brick",       amount = 1 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item",  name = "apm_filter_charcoal",           amount = 2,     ignored_by_stats = 2,  ignored_by_productivity = 2 },
	{ type = "item",  name = "apm_filter_charcoal",           amount_min = 1, amount_max = 1,        independent_probability = 0.95, ignored_by_stats = 1, ignored_by_productivity = 1 },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 30,    ignored_by_stats = 30, ignored_by_productivity = 30 }
}
recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in
recipe.allow_decomposition = false
recipe.allow_as_intermediate = false
recipe.allow_intermediates = false

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_air_cleaning_1"
}

recipe.categories = { "apm_air_cleaner" }
recipe.subgroup = "apm_power_fluid"
recipe.order = "ca_a"
recipe.icons = {
	apm.lib.icons.dynamics.air,
	apm.lib.icons.dynamics.t1
}

recipe.enabled = false
recipe.energy_required = 25
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item", name = "apm_filter_charcoal", amount = 1 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item",  name = "apm_filter_charcoal_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 },
	{ type = "fluid", name = "apm_dirt_water",           amount = 25 }
}
recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_air_cleaning_2"
}

recipe.categories = { "apm_air_cleaner" }
recipe.subgroup = "apm_power_fluid"
recipe.order = "ca_b"
recipe.icons = {
	apm.lib.icons.dynamics.air,
	apm.lib.icons.dynamics.t2
}

recipe.enabled = false
recipe.energy_required = 25
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item",  name = "apm_filter_charcoal", amount = 1 },
	{ type = "fluid", name = "sulfuric-acid",       amount = 30 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item",  name = "apm_filter_charcoal_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 },
	{ type = "item",  name = "apm_ammonium_sulfate",     amount = 15 },
	{ type = "fluid", name = "apm_dirt_water",           amount = 25 }
}
recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
