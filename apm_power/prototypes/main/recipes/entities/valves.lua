require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/valves.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_valve_0"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "pipe",             amount = 1 },
	{ type = "item", name = "iron-plate",       amount = 2 },
	{ type = "item", name = "apm_rubber",       amount = 1 },
	{ type = "item", name = "apm_mechanical_relay", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_valve_0', amount = 1 }
}
recipe.main_product = 'apm_valve_0'
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
recipe.name = "apm_valve_1"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "pipe",             amount = 1 },
	{ type = "item", name = "iron-plate",       amount = 2 },
	{ type = "item", name = "apm_rubber",       amount = 1 },
	{ type = "item", name = "apm_mechanical_relay", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_valve_1', amount = 1 }
}
recipe.main_product = 'apm_valve_1'
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
recipe.name = "apm_valve_2"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "pipe",             amount = 1 },
	{ type = "item", name = "iron-plate",       amount = 2 },
	{ type = "item", name = "apm_rubber",       amount = 1 },
	{ type = "item", name = "apm_mechanical_relay", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_valve_2', amount = 1 }
}
recipe.main_product = 'apm_valve_2'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
