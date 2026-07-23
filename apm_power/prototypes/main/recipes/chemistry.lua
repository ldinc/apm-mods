require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/chemistry.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_treated_wood_planks")
local item_icon_b = apm.lib.utils.icon.get.from_item("apm_saw_blade_iron")
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_1",
	categories = { "advanced-crafting" },
	subgroup = "apm_power_intermediates",
	order = "ag_a",
	icons = icons,

	enabled = false,
	energy_required = 4,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "item",  name = "wood",               amount = 5 },
		{ type = "item",  name = "apm_saw_blade_iron", amount = 1 },
		{ type = "fluid", name = "apm_creosote",       amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "item", name = "apm_treated_wood_planks", amount = 10 },
		{ type = "item", name = "apm_saw_blade_iron_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_treated_wood_planks")
local item_icon_b = apm.lib.utils.icon.get.from_item("apm_saw_blade_iron")
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_1b",
	categories = { "advanced-crafting" },
	subgroup = "apm_power_intermediates",
	order = "ag_a",
	icons = icons,

	enabled = false,
	energy_required = 4,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "item",  name = "wood",               amount = 5 },
		{ type = "item",  name = "apm_saw_blade_iron", amount = 1 },
		{ type = "fluid", name = "heavy-oil",          amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "item", name = "apm_treated_wood_planks", amount = 10 },
		{ type = "item", name = "apm_saw_blade_iron_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_treated_wood_planks")
local item_icon_b = apm.lib.utils.icon.get.from_item("apm_saw_blade_steel")
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_2",
	categories = { "crafting-with-fluid" },
	subgroup = "apm_power_intermediates",
	order = "ag_a",
	icons = icons,

	enabled = false,
	energy_required = 4,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "item",  name = "wood",                amount = 5 },
		{ type = "item",  name = "apm_saw_blade_steel", amount = 1 },
		{ type = "fluid", name = "apm_creosote",        amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "item", name = "apm_treated_wood_planks",  amount = 15 },
		{ type = "item", name = "apm_saw_blade_steel_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_treated_wood_planks")
local item_icon_b = apm.lib.utils.icon.get.from_item("apm_saw_blade_steel")
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.6, { -6, -3 })
local item_icon_c = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_treated_wood_planks_2b",
	categories = { "crafting-with-fluid" },
	subgroup = "apm_power_intermediates",
	order = "ag_b",
	icons = icons,

	enabled = false,
	energy_required = 4,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "item",  name = "wood",                amount = 5 },
		{ type = "item",  name = "apm_saw_blade_steel", amount = 1 },
		{ type = "fluid", name = "heavy-oil",           amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "item", name = "apm_treated_wood_planks",  amount = 15 },
		{ type = "item", name = "apm_saw_blade_steel_used", amount = 1, ignored_by_stats = 1, ignored_by_productivity = 1 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe("basic-oil-processing")
local fluid_icon = apm.lib.utils.icon.get.from_item("wood")
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_wood_1",
	categories = { "oil-processing" },
	subgroup = "apm_power_fluid",
	order = "ba_a",
	icons = icons,

	enabled = false,
	energy_required = 4.5,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "item",  name = "wood",  amount = 10 },
		{ type = "fluid", name = "steam", amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "fluid", name = "apm_creosote",      amount = 80 },
		{ type = "fluid", name = "apm_coke_oven_gas", amount = 20 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe("basic-oil-processing")
local fluid_icon = apm.lib.utils.icon.get.from_fluid("apm_creosote")
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_creosote_1",
	categories = { "oil-processing" },
	subgroup = "apm_power_fluid",
	order = "ba_b",
	icons = icons,

	enabled = false,
	energy_required = 4.5,
	---@type IngredientPrototype[]
	ingredients = {
		{ type = "fluid", name = "apm_creosote", amount = 100 },
		{ type = "fluid", name = "steam",        amount = 50 }
	},
	---@type ProductPrototype[]
	results = {
		{ type = "fluid", name = "heavy-oil",     amount = 25 },
		{ type = "fluid", name = "light-oil",     amount = 20 },
		{ type = "fluid", name = "petroleum-gas", amount = 15 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_made_in = apm.lib.features.show.made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe_icon = apm.lib.utils.icon.get.from_recipe("basic-oil-processing")
recipe_icon = apm.lib.utils.icons.mod(recipe_icon, 1, { 4, 0 })
local fluid_icon = apm.lib.utils.icon.get.from_fluid("apm_coke_oven_gas")
fluid_icon = apm.lib.utils.icons.mod(fluid_icon, 0.6, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ recipe_icon, fluid_icon })

---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_refining_coke_oven_gas_1"
}

recipe.categories = { "chemistry" }
recipe.subgroup = "apm_power_fluid"
recipe.order = "ba_c"
recipe.icons = icons

recipe.crafting_machine_tint = {
	primary = { r = 0.764, g = 0.596, b = 0.780, a = 1.000 },   -- #c298c6ff
	secondary = { r = 0.762, g = 0.551, b = 0.844, a = 1.000 }, -- #c28cd7ff
	tertiary = { r = 0.895, g = 0.773, b = 0.596, a = 1.000 },  -- #e4c597ff
	quaternary = { r = 1.000, g = 0.734, b = 0.290, a = 1.000 }, -- #ffbb49ff
}

recipe.enabled = false
recipe.energy_required = 4.5

---@type IngredientPrototype[]
recipe.ingredients = {
	{ type = "fluid", name = "apm_coke_oven_gas", amount = 100 }
}

---@type ProductPrototype[]
recipe.results = {
	{ type = "fluid", name = "petroleum-gas", amount = 10 }
}

recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
