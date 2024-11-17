require 'util'
require('lib.log')

local self = 'lib.utils.batteries'

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.batteries.generate(level, battery_name, fuel_value, overlay, probability, technology_name)
	if not apm.lib.utils.item.exist(battery_name) then return end
	local item_battery = data.raw.item[battery_name]

	local item_icon_a = apm.lib.utils.icon.get.from_item(battery_name)
	local item_icon_b = { overlay }
	local item_icon_c = { apm.lib.icons.dynamics.recycling }


	local battery_fuel_value = apm.lib.utils.string.convert_to_number(fuel_value)
	local energy_charging_station = apm.lib.utils.string.convert_to_number(
		apm.energy_addon.constants.energy_usage_charging_station
	)

	local energy_required = battery_fuel_value * 6 / energy_charging_station

	-- discharged item
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

	---@type data.ItemPrototype
	local item = {

		type = 'item',
		name = 'apm_discharged_' .. battery_name,
		localised_name = { "item-name.apm_discharged", { 'item-name.' .. battery_name } },
		localised_description = { "item-description.apm_discharged" },
		icons = icons,
		icon_mipmaps = 4,
		stack_size = item_battery.stack_size,
		subgroup = item_battery.subgroup,
		order = item_battery.order .. 'z',
	}

	data:extend({ item })

	-- charging recipe
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = "apm_charging_" .. tostring(battery_name),
		localised_name = { "recipe-name.apm_charging", { 'item-name.' .. battery_name } },
		category = 'apm_electric_charging',

		subgroup = item_battery.subgroup,
		order = item_battery.order .. 'z',
		icons = icons,

		enabled = false,
		energy_required = energy_required,
		ingredients = {
			{ type = "item", name = item.name, amount = 6 }
		},
		results = {
			{ type = 'item', name = battery_name, amount = 5 },
			{ type = 'item', name = battery_name, amount_min = 1, amount_max = 1, probability = probability, show_details_in_recipe_tooltip = false }
		},
		main_product = '',
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = true,
		allow_decomposition = false,
		allow_as_intermediate = false,
		allow_intermediates = false,
	}

	data:extend({ recipe })

	-- add technologie unlock
	apm.lib.utils.technology.add.recipe_for_unlock(technology_name, recipe.name)

	-- overwrite battery
	apm.lib.utils.item.overwrite.battery(level, battery_name, fuel_value, item.name)

	APM_LOG_INFO(self, 'generate()', 'generated item recipes and for: "' .. tostring(battery_name) .. '"')
end
