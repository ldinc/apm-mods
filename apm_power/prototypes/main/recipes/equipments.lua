require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/equipments.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_equipment_burner_generator_basic"

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 5),
	{ type = "item", name = "electric-engine-unit", amount = 5 },
	{ type = "item", name = "copper-plate",     amount = 10 },
	{ type = "item", name = "steel-plate",      amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_equipment_burner_generator_basic', amount = 1 }
}
recipe.main_product = 'apm_equipment_burner_generator_basic'
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
recipe.name = "apm_equipment_burner_generator_advanced"


recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	{ type = "item", name = "apm_equipment_burner_generator_basic", amount = 1 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 5),
	apm.lib.utils.builder.recipe.item.simple('APM_GEAR_T4', 5),
	{ type = "item", name = "steel-plate",                      amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_equipment_burner_generator_advanced', amount = 1 }
}
recipe.main_product = 'apm_equipment_burner_generator_advanced'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
