require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/integrations/generate.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_compat_bob = settings.startup["apm_energy_addon_compat_bob"].value
local apm_energy_addon_compat_earendel = settings.startup["apm_energy_addon_compat_earendel"].value
local apm_energy_addon_compat_reverse_factory = settings.startup["apm_energy_addon_compat_reverse_factory"].value
local apm_energy_addon_always_show_made_in = settings.startup["apm_energy_addon_always_show_made_in"].value

APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_bob', apm_energy_addon_compat_bob)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_earendel', apm_energy_addon_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_reverse_factory', apm_energy_addon_compat_reverse_factory)
APM_LOG_SETTINGS(self, 'apm_energy_addon_always_show_made_in', apm_energy_addon_always_show_made_in)

-- apm ------------------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------------------

--- [apm_nuclear]
if mods.apm_nuclear then
	local rtg_name = 'apm_rtg_radioisotope_thermoelectric_generator'
	local item_battery = data.raw.item[rtg_name]

	-- discharged item
	---@type data.ItemPrototype
	local item = {
		type = 'item',
		name = 'apm_decayed_rtg',
		localised_name = { "item-name.apm_decayed", { 'item-name.' .. rtg_name } },
		localised_description = { "item-description.apm_decayed" },
		icons = { apm.energy_addon.icons.rtg_decayed },
		stack_size = item_battery.stack_size,
		subgroup = item_battery.subgroup,
		order = item_battery.order .. 'z',
	}

	data:extend({ item })

	-- reprocessing recipe
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_decayed_rtg')
	local item_icon_b = { apm.lib.icons.dynamics.recycling }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = "apm_decayed_rtg_reprocessing",
		localised_name = { "recipe-name.apm_decayed", { 'item-name.' .. rtg_name } },
		category = 'chemistry',
		subgroup = item_battery.subgroup,
		order = item_battery.order .. 'z',
		icons = icons,
		enabled = false,
		energy_required = 5,
		ingredients = {
			{ type = "item", name = item.name,                amount = 5 },
			{ type = "item", name = 'apm_oxide_pellet_pu239', amount = 1 },
			{ type = "item", name = 'apm_waste_container',    amount = 1 },
			apm.lib.utils.builder.recipe.item.simple('APM_NUCLEAR_ACID', 5),
			{ type = "fluid", name = 'apm_tbp_30', amount = 100 }
		},
		results = {
			{ type = "item",  name = 'apm_oxide_pellet_np237',     amount = 5,     show_details_in_recipe_tooltip = false },
			{ type = 'item',  name = 'apm_radioactive_waste',      amount = 1,     show_details_in_recipe_tooltip = false },
			{ type = "item",  name = rtg_name,                     amount = 4 },
			{ type = 'item',  name = rtg_name,                     amount_min = 1, amount_max = 1,                        probability = 0.9, show_details_in_recipe_tooltip = false },
			{ type = "fluid", name = 'apm_radioactive_wastewater', amount = 50 }
		},
		main_product = '',
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in,
		allow_decomposition = false,
		allow_as_intermediate = false,
		allow_intermediates = false,
	}

	data:extend({ recipe })

	apm.lib.utils.item.overwrite.battery(1, rtg_name, apm.energy_addon.constants.fuel_value.apm_rtg, item.name)
	apm.lib.utils.technology.add.recipe_for_unlock('apm_nuclear_rtg', recipe.name)
end

--- [earendel's mods]
if mods['aai-vehicles-warden'] and apm_energy_addon_compat_earendel then
	apm.energy_addon.generate_electric_powered('vehicle-warden')

	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = "apm_electric_vehicle-warden",

		enabled = false,
		energy_required = 0.5,
		ingredients = {
			{ type = "item", name = "vehicle-warden",       amount = 1 },
			{ type = "item", name = "electric-engine-unit", amount = 5 },
			apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 20),
		},
		results = {
			{ type = 'item', name = 'apm_electric_vehicle-warden', amount = 1 },
		},
		main_product = 'apm_electric_vehicle-warden',
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in,
	}

	data:extend({ recipe })

	---@type data.TechnologyPrototype
	local technology = {
		type = 'technology',
		name = 'vehicle-warden-2',
		icon = '__aai-vehicles-warden__/graphics/technology/warden.png',
		icon_size = 128,
		effects = {
			{ type = 'unlock-recipe', recipe = recipe.name },
		},
		prerequisites = { 'vehicle-warden', 'electric-engine', 'battery' },
		unit = {
			count = 125,
			ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "chemical-science-pack", 1 } },
			time = 30,
		},
		order = 'aa_a',
	}

	data:extend({ technology })
end

--- [bob's mods]
if mods.bobplates and apm_energy_addon_compat_bob then
	apm.lib.utils.batteries.generate(
		2,
		'lithium-ion-battery',
		apm.energy_addon.constants.fuel_value.battery_bob_lithium_ion,
		apm.energy_addon.icons.depleted_battery_overlay,
		0.90,
		'battery-2'
	)
	apm.lib.utils.batteries.generate(
		3,
		'silver-zinc-battery',
		apm.energy_addon.constants.fuel_value.battery_bob_silver_zinc,
		apm.energy_addon.icons.depleted_battery_overlay,
		0.95,
		'battery-3'
	)
end

if mods.boblogistics and apm_energy_addon_compat_bob then
	apm.energy_addon.generate_electric_powered_locomotive('bob-locomotive-2')
	apm.energy_addon.generate_electric_powered_locomotive('bob-locomotive-3')
	apm.energy_addon.generate_electric_powered_locomotive('bob-armoured-locomotive')
	apm.energy_addon.generate_electric_powered_locomotive('bob-armoured-locomotive-2')

	apm.energy_addon.generate_electric_locomotive_new_recipe('bob-locomotive-2')
	apm.energy_addon.generate_electric_locomotive_new_tech('bob-locomotive-2', 'bob-railway-2')
	apm.energy_addon.generate_electric_locomotive_new_recipe('bob-locomotive-3')
	apm.energy_addon.generate_electric_locomotive_new_tech('bob-locomotive-3', 'bob-railway-3')
	apm.energy_addon.generate_electric_locomotive_new_recipe('bob-armoured-locomotive')
	apm.energy_addon.generate_electric_locomotive_new_tech('bob-armoured-locomotive', 'bob-armoured-railway')
	apm.energy_addon.generate_electric_locomotive_new_recipe('bob-armoured-locomotive-2')
	apm.energy_addon.generate_electric_locomotive_new_tech('bob-armoured-locomotive-2', 'bob-armoured-railway-2')
end

if mods.bobwarfare and apm_energy_addon_compat_bob then
	local bobwarfare = require("bobs.bobwarfare")

	bobwarfare.generate()
end
