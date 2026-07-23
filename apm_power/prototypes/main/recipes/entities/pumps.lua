require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/entities/pumps.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_pump_0"
}

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_rubber",        amount = 2 },
	{ type = "item", name = "pipe",              amount = 3 },
	{ type = "item", name = "apm_gearing",       amount = 2 },
	{ type = "item", name = "apm_simple_engine", amount = 2 },
	{ type = "item", name = "iron-plate",        amount = 1 },
}
recipe.results = {
	{ type = "item", name = "apm_pump_0", amount = 1 }
}
recipe.main_product = "apm_pump_0"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
