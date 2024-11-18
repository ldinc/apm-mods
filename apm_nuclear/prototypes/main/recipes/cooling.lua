require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local self = "apm_nuclear/prototypes/main/recipes/cooling.lua"

APM_LOG_HEADER(self)

local apm_nuclear_always_show_made_in = settings.startup["apm_nuclear_always_show_made_in"].value
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
local recipe = {}
recipe.type = "recipe"
recipe.name = "hot_water_cooling"
recipe.category = "apm_fluid_cooling_0"
recipe.icons = icons

recipe.subgroup = "apm_nuclear_cooling_tower"
recipe.order = "ab_a"
recipe.crafting_machine_tint = {
	primary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	secondary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	tertiary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	quaternary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
}

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	{ type = "fluid", name = "apm_hot_water", amount = 500 }
}
recipe.results = {
	{ type = "fluid", name = "water", amount = 500 }
}
recipe.main_product = "water"
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_nuclear_always_show_made_in

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
local recipe = {}
recipe.type = "recipe"
recipe.name = "steam_condensing"
recipe.category = "apm_fluid_cooling_0"
recipe.icons = icons

recipe.subgroup = "apm_nuclear_cooling_tower"
recipe.order = "ab_b"
recipe.crafting_machine_tint = {
	primary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	secondary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	tertiary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
	quaternary = { r = 1.000, g = 1.000, b = 1.000, a = 0.500 },
}

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	{ type = "fluid", name = "steam", amount = 500 }
}
recipe.results = {
	{ type = "fluid", name = "water", amount = 500 }
}
recipe.main_product = "water"
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_nuclear_always_show_made_in

data:extend({ recipe })
