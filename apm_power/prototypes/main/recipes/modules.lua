require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/modules.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_particle_filter_1"

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "iron-plate",           amount = 5 },
	{ type = "item", name = "apm_charcoal",         amount = 4 },
	{ type = "item", name = "apm_rubber",           amount = 2 },
	{ type = "item", name = "apm_mechanical_relay", amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_particle_filter_1', amount = 1 }
}
recipe.main_product = 'apm_particle_filter_1'
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
recipe.name = "apm_particle_filter_2"
recipe.category = 'advanced-crafting'

recipe.enabled = false
recipe.energy_required = 7.5
recipe.ingredients = {
	{ type = "item",  name = "apm_particle_filter_1", amount = 1 },
	{ type = "item",  name = "apm_filter_charcoal",   amount = 2 },
	{ type = "item",  name = "apm_steam_relay",       amount = 5 },
	{ type = "fluid", name = "water",                 amount = 50 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_particle_filter_2',         amount = 1 },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 50 }
}
recipe.main_product = 'apm_particle_filter_2'
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
recipe.name = "apm_particle_filter_3"
recipe.category = 'advanced-crafting'

recipe.enabled = false
recipe.energy_required = 10
recipe.ingredients = {
	{ type = "item",  name = "apm_particle_filter_2", amount = 1 },
	{ type = "item",  name = "copper-plate",          amount = 5 },
	{ type = "item",  name = "electronic-circuit",    amount = 5 },
	{ type = "fluid", name = "sulfuric-acid",         amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_particle_filter_3', amount = 1 }
}
recipe.main_product = 'apm_particle_filter_3'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
