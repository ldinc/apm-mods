require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/offshore_pumps.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_offshore_pump_0"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_rubber",        amount = 2 },
	{ type = "item", name = "pipe",              amount = 3 },
	{ type = "item", name = "apm_simple_engine", amount = 2 },
	{ type = "item", name = "iron-plate",        amount = 2 },
}
recipe.results = {
	{ type = 'item', name = 'apm_offshore_pump_0', amount = 1 }
}
recipe.main_product = 'apm_offshore_pump_0'
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
recipe.name = "apm_offshore_pump_1"

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_rubber",           amount = 4 },
	{ type = "item", name = "steel-plate",          amount = 1 },
	{ type = "item", name = "electric-engine-unit", amount = 2 },
	{ type = "item", name = "electronic-circuit",   amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_offshore_pump_1', amount = 1 }
}
recipe.main_product = 'apm_offshore_pump_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, "apm_offshore_pump_0" , 1)
end

data:extend({ recipe })
