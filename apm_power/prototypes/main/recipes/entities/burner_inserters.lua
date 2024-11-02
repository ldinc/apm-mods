require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/burner_inserters.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_burner_filter_inserter"

recipe.enabled = true
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "burner-inserter",  amount = 1 },
	{ type = "item", name = "apm_mechanical_relay", amount = 2 },
	{ type = "item", name = "apm_gearing",      amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_burner_filter_inserter', amount = 1 }
}
recipe.main_product = 'apm_burner_filter_inserter'
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
recipe.name = "apm_burner_long_inserter"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "burner-inserter",  amount = 1 },
	{ type = "item", name = "apm_mechanical_relay", amount = 1 },
	{ type = "item", name = "apm_gearing",      amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_burner_long_inserter', amount = 1 }
}
recipe.main_product = 'apm_burner_long_inserter'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
