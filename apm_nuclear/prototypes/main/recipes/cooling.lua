require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local self = "apm_nuclear/prototypes/main/recipes/cooling.lua"

APM_LOG_HEADER(self)

local apm_nuclear_always_show_made_in = false

local v = settings.startup["apm_nuclear_always_show_made_in"].value

if type(v) == "boolean" then
	apm_nuclear_always_show_made_in = v
end

APM_LOG_SETTINGS(self, "apm_nuclear_always_show_made_in", apm_nuclear_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_fluid("apm_hot_water")
--local item_icon_b = {apm.lib.icons.dynamics.cooling}
local item_icon_b = { apm.lib.icons.dynamics.temp_down }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "hot_water_cooling",
	category = "apm_fluid_cooling_0",
	icons = icons,

	subgroup = "apm_nuclear_cooling_tower",
	order = "ab_a",
	crafting_machine_tint = {
		primary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		secondary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		tertiary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		quaternary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	},

	enabled = false,
	energy_required = 3.5,
	ingredients = {
		{ type = "fluid", name = "apm_hot_water", amount = 500 }
	},
	results = {
		{ type = "fluid", name = "water", amount = 500 }
	},

	main_product = "water",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}


data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_fluid("steam")
--local item_icon_b = {apm.lib.icons.dynamics.cooling}
local item_icon_b = { apm.lib.icons.dynamics.temp_down }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "steam_condensing",
	category = "apm_fluid_cooling_0",
	icons = icons,

	subgroup = "apm_nuclear_cooling_tower",
	order = "ab_b",
	crafting_machine_tint = {
		primary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		secondary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		tertiary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
		quaternary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	},

	enabled = false,
	energy_required = 3.5,
	ingredients = {
		{ type = "fluid", name = "steam", amount = 5000 }
	},
	results = {
		{ type = "fluid", name = "water", amount = 500 }
	},
	main_product = "water",
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_nuclear_always_show_made_in,
}

data:extend({ recipe })
