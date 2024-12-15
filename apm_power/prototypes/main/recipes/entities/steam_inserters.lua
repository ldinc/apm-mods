require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/steam_engines.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_steam_inserter"

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "apm_steam_engine", amount = 1 },
	{ type = "item", name = "iron-plate",       amount = 1 },
	{ type = "item", name = "iron-gear-wheel",  amount = 1 },
	{ type = "item", name = "apm_iron_bearing", amount = 1 },
	{ type = "item", name = "apm_steam_relay",  amount = 1 },
}
recipe.results = {
	{ type = 'item', name = 'apm_steam_inserter', amount = 1 }
}
recipe.main_product = 'apm_steam_inserter'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if apm.lib.features.reuse_previous_tier then
	recipe.ingredients = {
		{ type = "item", name = "apm_steam_engine", amount = 1 },
		{ type = "item", name = "pipe",             amount = 1 },
		{ type = "item", name = "burner-inserter",  amount = 1 },
	}
end

data:extend({ recipe })

-------------------------------------------------------------------------------

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_steam_inserter_long"

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "apm_steam_engine", amount = 1 },
	{ type = "item", name = "iron-plate",       amount = 1 },
	{ type = "item", name = "iron-gear-wheel",  amount = 1 },
	{ type = "item", name = "apm_iron_bearing", amount = 1 },
	{ type = "item", name = "apm_steam_relay",  amount = 1 },
}
recipe.results = {
	{ type = 'item', name = 'apm_steam_inserter_long', amount = 1 }
}
recipe.main_product = 'apm_steam_inserter_long'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if apm.lib.features.reuse_previous_tier then
	recipe.ingredients = {
		{ type = "item", name = "apm_steam_engine", amount = 1 },
		{ type = "item", name = "pipe",             amount = 1 },
		{ type = "item", name = "burner-inserter",  amount = 1 },
	}
end

data:extend({ recipe })
