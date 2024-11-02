require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/pumps.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_burner_miner_drill_2"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "burner-mining-drill", amount = 1 },
	{ type = "item", name = "apm_simple_engine", amount = 2 },
	{ type = "item", name = "apm_mechanical_relay", amount = 2 },
	{ type = "item", name = "steel-plate",      amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_burner_miner_drill_2', amount = 1 }
}
recipe.main_product = 'apm_burner_miner_drill_2'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_steam_mining_drill"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_iron_bearing", amount = 2 },
	{ type = "item", name = "iron-gear-wheel", amount = 1 },
	{ type = "item", name = "apm_steam_engine", amount = 2 },
	{ type = "item", name = "apm_rubber",   amount = 6 },
	{ type = "item", name = "steel-plate",  amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_steam_mining_drill', amount = 1 }
}
recipe.main_product = 'apm_steam_mining_drill'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
