require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/entities/steam_engines.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_steam_engine_2"
}

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	-- {type="item", name="steam-engine", amount=1},
	{ type = "item", name = "apm_gearing",       amount = 10 },
	{ type = "item", name = "apm_steam_engine",  amount = 6 },
	{ type = "item", name = "apm_electromagnet", amount = 12 },
	{ type = "item", name = "steel-plate",       amount = 10 }
}
recipe.results = {
	{ type = "item", name = "apm_steam_engine_2", amount = 1 }
}
recipe.main_product = "apm_steam_engine_2"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, "steam-engine", 1) -- like apm_boiler_2 (apm_steam_engine_1 does not exist)
end

data:extend({ recipe })
