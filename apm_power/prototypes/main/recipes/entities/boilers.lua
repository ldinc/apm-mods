require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/entities/boilers.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_boiler_2"
}

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "boiler",       amount = 1 },
	{ type = "item", name = "copper-plate", amount = 30 },
	{ type = "item", name = "steel-plate",  amount = 20 }
}
recipe.results = {
	{ type = "item", name = "apm_boiler_2", amount = 1 }
}
recipe.main_product = "apm_boiler_2"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, "boiler", 1)
end

data:extend({ recipe })
