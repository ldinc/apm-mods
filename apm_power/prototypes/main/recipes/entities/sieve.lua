require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/sieve.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_sieve_0"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "apm_steam_engine",        amount = 2 },
	{ type = "item", name = "apm_machine_frame_steam", amount = 3 },
	{ type = "item", name = "iron-stick",              amount = 30 },
	{ type = "item", name = "stone-brick",             amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_sieve_0', amount = 1 }
}
recipe.main_product = 'apm_sieve_0'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
