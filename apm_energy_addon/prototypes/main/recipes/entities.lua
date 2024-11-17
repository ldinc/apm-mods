require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/recipes/entities.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_always_show_made_in = settings.startup["apm_energy_addon_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_energy_addon_always_show_made_in', apm_energy_addon_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_battery_charging_station"

recipe.enabled = false
recipe.energy_required = 0.5
recipe.ingredients = {
	{ type = "item", name = "assembling-machine-2", amount = 1 },
	{ type = "item", name = "copper-cable",     amount = 20 },
	{ type = "item", name = "steel-plate",      amount = 6 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 15)
}
recipe.results = {
	{ type = 'item', name = 'apm_battery_charging_station', amount = 1 }
}
recipe.main_product = 'apm_battery_charging_station'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_energy_addon_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_battery_discharging_station"

recipe.enabled = false
recipe.energy_required = 0.5
recipe.ingredients = {
	{ type = "item", name = "assembling-machine-2", amount = 1 },
	{ type = "item", name = "copper-cable",     amount = 20 },
	{ type = "item", name = "steel-plate",      amount = 6 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 15)
}
recipe.results = {
	{ type = 'item', name = 'apm_battery_discharging_station', amount = 1 }
}
recipe.main_product = 'apm_battery_discharging_station'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_energy_addon_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_equipment_energy_transmitter"

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 5),
	{ type = "item", name = "electric-engine-unit", amount = 5 },
	{ type = "item", name = "copper-plate",     amount = 20 },
	{ type = "item", name = "steel-plate",      amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_equipment_energy_transmitter', amount = 1 }
}
recipe.main_product = 'apm_equipment_energy_transmitter'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
