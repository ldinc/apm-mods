require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/tools.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_saw_blade_iron"
}

recipe.categories = { "advanced-crafting" }

recipe.enabled = false
recipe.energy_required = 1
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item", name = "iron-plate",        amount = 2 },
	{ type = "item", name = "apm_sealing_rings", amount = 2 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item", name = "apm_saw_blade_iron", amount = 1 }
}
recipe.main_product = "apm_saw_blade_iron"
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
	name = "apm_saw_blade_steel"
}

recipe.categories = { "advanced-crafting" }

recipe.enabled = false
recipe.energy_required = 1
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item", name = "steel-plate",       amount = 1 },
	{ type = "item", name = "apm_sealing_rings", amount = 2 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item", name = "apm_saw_blade_steel", amount = 1 }
}
recipe.main_product = "apm_saw_blade_steel"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_saw_blade_iron_used")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_saw_blade_iron_maintenance"
}

recipe.categories = { "advanced-crafting" }
recipe.subgroup = "apm_power_tools"
recipe.order = "ae_b"
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item",  name = "apm_saw_blade_iron_used", amount = 5 },
	{ type = "fluid", name = "water",                   amount = 30 },
	{ type = "item",  name = "apm_crushed_stone",       amount = 2 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item",  name = "apm_saw_blade_iron", amount = 4 },
	{ type = "item",  name = "apm_saw_blade_iron", amount_min = 1, amount_max = 1,        independent_probability = 0.5,           ignored_by_stats = 1, ignored_by_productivity = 1 },
	{ type = "fluid", name = "apm_dirt_water",     amount = 30,    ignored_by_stats = 30, ignored_by_productivity = 30 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_saw_blade_steel_used")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_saw_blade_steel_maintenance"
}

recipe.categories = { "crafting-with-fluid" }
recipe.subgroup = "apm_power_tools"
recipe.order = "af_b"
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3
---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "item",  name = "apm_saw_blade_steel_used", amount = 5 },
	{ type = "fluid", name = "water",                    amount = 30 },
	{ type = "item",  name = "apm_crushed_stone",        amount = 2 }
}
---@type ProductPrototype[]
recipe.results = {
	{ type = "item",  name = "apm_saw_blade_steel", amount = 4 },
	{ type = "item",  name = "apm_saw_blade_steel", amount_min = 1, amount_max = 1,        independent_probability = 0.95,          ignored_by_stats = 1, ignored_by_productivity = 1 },
	{ type = "fluid", name = "apm_dirt_water",      amount = 30,    ignored_by_stats = 30, ignored_by_productivity = 30 }
}
recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in
recipe.allow_decomposition = false
recipe.allow_as_intermediate = false
recipe.allow_intermediates = false

data:extend({ recipe })
