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
local recipe = {
	type = "recipe",
	name = "apm_battery_charging_station",

	enabled = false,
	energy_required = 0.5,
	ingredients = {
		{ type = "item", name = "assembling-machine-2", amount = 1 },
		{ type = "item", name = "copper-cable",         amount = 20 },
		{ type = "item", name = "steel-plate",          amount = 6 },
		apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 15)
	},
	results = {
		{ type = 'item', name = 'apm_battery_charging_station', amount = 1 }
	},
	main_product = 'apm_battery_charging_station',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_energy_addon_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_battery_discharging_station",

	enabled = false,
	energy_required = 0.5,
	ingredients = {
		{ type = "item", name = "assembling-machine-2", amount = 1 },
		{ type = "item", name = "copper-cable",         amount = 20 },
		{ type = "item", name = "steel-plate",          amount = 6 },
		apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 15)
	},
	results = {
		{ type = 'item', name = 'apm_battery_discharging_station', amount = 1 }
	},
	main_product = 'apm_battery_discharging_station',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_energy_addon_always_show_made_in,
}

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_equipment_energy_transmitter",
	enabled = false,
	energy_required = 3.5,
	ingredients = {
		apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 5),
		{ type = "item", name = "electric-engine-unit", amount = 5 },
		{ type = "item", name = "copper-plate",         amount = 20 },
		{ type = "item", name = "steel-plate",          amount = 5 }
	},
	results = {
		{ type = 'item', name = 'apm_equipment_energy_transmitter', amount = 1 }
	},
	main_product = 'apm_equipment_energy_transmitter',
	requester_paste_multiplier = 4,
	always_show_products = true,
	always_show_made_in = apm_power_always_show_made_in,
}

data:extend({ recipe })
