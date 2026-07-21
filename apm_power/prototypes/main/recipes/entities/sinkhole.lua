require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/entities/sieve.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_sinkhole"
}

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "pipe",       amount = 30 },
	{ type = "item", name = "concrete",   amount = 50 },
	{ type = "item", name = "apm_rubber", amount = 50 }
}
recipe.results = {
	{ type = "item", name = "apm_sinkhole", amount = 1 }
}
recipe.main_product = "apm_sinkhole"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })

--------------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_sinkhole_small"
}

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "pipe",       amount = 20 },
	{ type = "item", name = "apm_rubber", amount = 20 }
}
recipe.results = {
	{ type = "item", name = "apm_sinkhole_small", amount = 1 }
}
recipe.main_product = "apm_sinkhole_small"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
