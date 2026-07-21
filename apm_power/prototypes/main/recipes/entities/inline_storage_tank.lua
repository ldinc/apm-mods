require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/entities/greenhouse.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local target = "apm_inline_storage_tank"

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = target,
}

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "iron-plate", amount = 4 },
	{ type = "item", name = "apm_rubber", amount = 4 },
	{ type = "item", name = "pipe",       amount = 4 },
}
recipe.results = {
	{ type = "item", name = target, amount = 1 }
}
recipe.main_product = target
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
