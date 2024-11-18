require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipes/mox.lua"

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
	name = "apm_fuel_rod_mox",
	category = "crafting-with-fluid",

	enabled = false,
	energy_required = 5,
	ingredients = {
		{ type = "item", name = "apm_fuel_rod_container", amount = 1 },
		{ type = "item", name = "apm_oxide_pellet_u238",  amount = 9 },
		{ type = "item", name = "apm_oxide_pellet_pu239", amount = 1 }
	},
	results = {
		{ type = "item", name = "apm_fuel_rod_mox", amount = 1 }
	},
	main_product = "apm_fuel_rod_mox",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_fuel_rod_mox_active")
--local item_icon_b = {apm.lib.icons.dynamics.cooling}
local item_icon_b = { apm.lib.icons.dynamics.temp_down }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_rod_mox_cooling",
	category = "apm_nuclear_cooling_0",
	subgroup = "apm_nuclear_used_fuel_cold",
	order = "ab_a",
	icons = icons,

	enabled = false,
	energy_required = 350,
	ingredients = {
		{ type = "item",  name = "apm_fuel_rod_mox_active", amount = 6 },
		{ type = "fluid", name = "water",                   amount = 1000, maximum_temperature = 20 }
	},
	results = {
		{ type = "item",  name = "apm_fuel_rod_mox_cooled",    amount = 6,   show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_hot_water",              amount = 850 },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = 150, temperature = 80 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_fuel_rod_mox_cooled")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_mox"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_rod_mox_recovery_stage_a",
	category = "chemistry",
	subgroup = "apm_nuclear_recycling_stage_a",
	order = "ab_a",
	icons = icons,
	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color
	},
	enabled = false,
	energy_required = 13.5,
	ingredients = {
		apm.lib.utils.builder.recipe.item.simple("APM_NUCLEAR_ACID", 5),
		{ type = "item", name = "apm_fuel_rod_mox_cooled", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_fuel_rod_container_worn", amount = 1,  show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = fluid.name,                    amount = 100 }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = get_raw_fluid_icons("apm_purex_solution_mox")
local item_icon_b = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local fluid = data.raw.fluid["apm_purex_solution_mox"]

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_fuel_rod_mox_recovery_stage_b",
	category = "chemistry",
	subgroup = "apm_nuclear_recycling_stage_b",
	order = "ab_a",
	icons = icons,

	crafting_machine_tint = {
		primary   = fluid.base_color,
		secondary = fluid.base_color,
		tertiary  = fluid.base_color
	},

	enabled = false,
	energy_required = 15,
	ingredients = {
		{ type = "fluid", name = "apm_tbp_30",          amount = apm.nuclear.constants.amount_of_tbp_30 },
		{ type = "fluid", name = fluid.name,            amount = 100 },
		{ type = "item",  name = "apm_waste_container", amount = 1 }
	},
	results = {
		{ type = "item",  name = "apm_oxide_pellet_u238",      amount = apm.nuclear.constants.amount_of_oxide_pellets - 4, show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_oxide_pellet_np237",     amount_min = 1,                                             amount_max = 1,                        probability = apm.nuclear.constants.probability_neptunium * 2, show_details_in_recipe_tooltip = false },
		{ type = "item",  name = "apm_radioactive_waste",      amount = 1,                                                 show_details_in_recipe_tooltip = false },
		{ type = "fluid", name = "apm_radioactive_wastewater", amount = apm.nuclear.constants.amount_of_rocow }
	},
	main_product = "",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
