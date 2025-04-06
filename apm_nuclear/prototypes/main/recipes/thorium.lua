require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/thorium.lua"

APM_LOG_HEADER(self)

local apm_nuclear_always_show_made_in = settings.startup["apm_nuclear_always_show_made_in"].value
APM_LOG_SETTINGS(self, "apm_nuclear_always_show_made_in", apm_nuclear_always_show_made_in)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function get_raw_fluid_icons(fluid_name)
	local used_fluid = data.raw.fluid[fluid_name]
	local t_icons = {}
	for _, layer in pairs(used_fluid.icons) do
		-- we want remove the icon layer with the radioactive symbol
		if layer.icon ~= apm.lib.icons.dynamics.radioactive.icon then
			table.insert(t_icons, layer)
		end
	end
	return t_icons
end

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_oxide_pellet_th232",
	category = "chemistry",
	crafting_machine_tint = {
		primary   = { r = 0.541, g = 0.337, b = 0.170, a = 0.000 },
		secondary = { r = 0.541, g = 0.337, b = 0.170, a = 0.000 },
		tertiary  = { r = 0.541, g = 0.337, b = 0.170, a = 0.000 },
	},

	enabled = false,
	energy_required = 15,
	ingredients = {
		apm.lib.utils.builder.recipe.item.simple("APM_THORIUM", 10),
		apm.lib.utils.builder.recipe.item.simple("APM_NUCLEAR_ACID", 5),
		apm.lib.utils.builder.recipe.item.simple("APM_WATER", 5)
	},
	results = {
		{ type = "item", name = "apm_oxide_pellet_th232", amount = 1 },
		apm.lib.utils.builder.recipe.item.simple("APM_THORIUM_SLAG", 2)
	},
	main_product = "apm_oxide_pellet_th232",
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
	name = "apm_fuel_rod_thorium",
	category = "crafting-with-fluid",

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_fuel_rod_container", amount = 1 },
		{ type = "item", name = "apm_oxide_pellet_th232", amount = apm.nuclear.constants.amount_of_oxide_pellets - 1 },
		{ type = "item", name = "apm_oxide_pellet_pu239", amount = 1 }
	},
	results = {
		{ type = "item", name = "apm_fuel_rod_thorium", amount = 1 }
	},
	main_product = "apm_fuel_rod_thorium",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_fuel_rod_thorium_active")
--local item_icon_b = {apm.lib.icons.dynamics.cooling}
local item_icon_b = { apm.lib.icons.dynamics.temp_down }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_cell_thorium_cooling",
	icons = icons,
	category = "apm_nuclear_cooling_0",
	subgroup = "apm_nuclear_used_fuel_cold",
	order = "ad_a",

	energy_required = 320,
	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	ingredients = {
		{ type = "item",  name = "apm_fuel_rod_thorium_active", amount = 6 },
		{ type = "fluid", name = "water",                       amount = 1000, maximum_temperature = 20 }
	},
	results = {
		{ type = "item",  name = "apm_fuel_rod_thorium_cooled", amount = 6,  show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_hot_water",               amount = 950 },
		{ type = "fluid", name = "apm_radioactive_wastewater",  amount = 50, temperature = 90 }
	},
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_fuel_rod_thorium_cooled")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_thorium"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_cell_thorium_recovery_stage_a",
	icons = icons,
	category = "chemistry",
	subgroup = "apm_nuclear_recycling_stage_a",
	order = "ad_a",
	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color,
	},

	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	energy_required = 13.5,
	ingredients = {
		apm.lib.utils.builder.recipe.item.simple("APM_NUCLEAR_ACID", 5),
		{ type = "item", name = "apm_fuel_rod_thorium_cooled", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_fuel_rod_container_worn", amount = 1,  show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = fluid.name,                    amount = 100 }
	},
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = get_raw_fluid_icons("apm_purex_solution_thorium")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_thorium"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_cell_thorium_recovery_stage_b",
	icons = icons,
	category = "chemistry",
	subgroup = "apm_nuclear_recycling_stage_b",
	order = "ad_a",
	crafting_machine_tint = {
		primary   = fluid.flow_color,
		secondary = fluid.flow_color,
		tertiary  = fluid.flow_color,
	},

	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	energy_required = 15,
	ingredients = {
		{ type = "fluid", name = "apm_tbp_30",          amount = apm.nuclear.constants.amount_of_tbp_30 },
		{ type = "fluid", name = fluid.name,            amount = 100 },
		{ type = "item",  name = "apm_waste_container", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_oxide_pellet_u235",      amount = 1,                                    show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_u238",      amount = 6,                                    show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_np237",     amount_min = 1,                                amount_max = 1,                        probability = apm.nuclear.constants.probability_neptunium / 3, show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_pu239",     amount_min = 1,                                amount_max = 1,                        probability = apm.nuclear.constants.probability_plutonium / 3, show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_radioactive_waste",      amount = 1,                                    show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = apm.nuclear.constants.amount_of_rocow }
		-- {type="item", name="bob-fusion-catalyst", amount=1}
	},
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
	name = "apm_breeder_thorium",
	category = "crafting-with-fluid",

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_breeder_container",  amount = 1 },
		{ type = "item", name = "apm_oxide_pellet_th232", amount = 9 },
		{ type = "item", name = "apm_oxide_pellet_pu239", amount = 1 }
	},
	results = {
		{ type = "item", name = "apm_breeder_thorium", amount = 1 }
	},
	requester_paste_multiplier = 4,
	main_product = "apm_breeder_thorium",
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
	name = "apm_breeder_thorium_loaded",
	category = "crafting-with-fluid",

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_breeder_thorium", amount = 1 },
		{ type = "item", name = "apm_fuel_rod_mox",    amount = 1 }
	},
	results = {
		{ type = "item", name = "apm_breeder_thorium_loaded", amount = 1 }
	},
	requester_paste_multiplier = 4,
	main_product = "apm_breeder_thorium_loaded",
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_breeder_thorium_active")
--local item_icon_b = {apm.lib.icons.dynamics.cooling}
local item_icon_b = { apm.lib.icons.dynamics.temp_down }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_breeder_thorium_cooling",
	icons = icons,
	category = "apm_nuclear_cooling_0",
	subgroup = "apm_nuclear_breeding_thorium",
	order = "ad_a",

	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	energy_required = 380.0,
	ingredients = {
		{ type = "item",  name = "apm_breeder_thorium_active", amount = 6 },
		{ type = "fluid", name = "water",                      amount = 1000, maximum_temperature = 20 }
	},
	results = {
		{ type = "item",  name = "apm_breeder_thorium_cooled", amount = 6,  show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_hot_water",              amount = 950 },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = 50, temperature = 90 }
	},
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
	name = "apm_breeder_thorium_unloading",
	category = "advanced-crafting",
	subgroup = "apm_nuclear_breeding_thorium",
	order = "ae_a",
	icons = {
		apm.nuclear.icons.breeder_thorium_unloading
	},

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_breeder_thorium_cooled", amount = 1 }
	},
	results = {
		{ type = "item", name = "apm_breeder_thorium_seperated", amount = 1, show_details_in_recipe_tooltip = false },
		{ type = "item", name = "apm_fuel_rod_mox_cooled",       amount = 1, show_details_in_recipe_tooltip = false }
	},
	requester_paste_multiplier = 4,
	main_product = "apm_breeder_thorium_seperated",
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_breeder_thorium_seperated")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_thorium_breeder"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_breeder_thorium_seperation_process_a",
	icons = icons,
	category = "chemistry",
	subgroup = "apm_nuclear_breeding_thorium",
	order = "af_a",
	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color,
	},

	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	energy_required = 3.5,
	ingredients = {
		apm.lib.utils.builder.recipe.item.simple("APM_NUCLEAR_ACID", 5),
		{ type = "item", name = "apm_breeder_thorium_seperated", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_breeder_container_worn", amount = 1,  show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = fluid.name,                   amount = 100 }
	},
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = get_raw_fluid_icons("apm_purex_solution_thorium_breeder")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_thorium_breeder"]
recipe.crafting_machine_tint = {
	primary   = fluid.flow_color,
	secondary = fluid.flow_color,
	tertiary  = fluid.flow_color,
}

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_breeder_thorium_seperation_process_b",
	icons = icons,
	category = "chemistry",
	subgroup = "apm_nuclear_breeding_thorium",
	order = "af_b",

	allow_decomposition = false,
	allow_as_intermediate = false,
	allow_intermediates = false,
	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "fluid", name = "apm_tbp_30",          amount = apm.nuclear.constants.amount_of_tbp_30 },
		{ type = "fluid", name = fluid.name,            amount = 100 },
		{ type = "item",  name = "apm_waste_container", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_oxide_pellet_u238",      amount = 5,                                    show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_np237",     amount = 4,                                    show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_pu239",     amount_min = 1,                                amount_max = 1,                        probability = apm.nuclear.constants.probability_plutonium / 2, show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_radioactive_waste",      amount = 1,                                    show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = apm.nuclear.constants.amount_of_rocow }
		-- {type="item", name="bob-fusion-catalyst", amount=1},
	},
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
