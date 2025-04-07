require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_energy_addon/lib/functions.lua'

APM_LOG_HEADER(self)

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.energy_addon.overhaul(vehicle_name)
	local vehicle

	if apm.lib.utils.car.exist(vehicle_name) then
		vehicle = data.raw.car[vehicle_name]
	elseif apm.lib.utils.locomotive.exist(vehicle_name) then
		vehicle = data.raw.locomotive[vehicle_name]
	elseif apm.lib.utils.spidertron.exist(vehicle_name) then
		vehicle = data.raw["spider-vehicle"][vehicle_name]
	else
		return
	end

	if not vehicle or not vehicle.energy_source or vehicle.energy_source.type ~= "burner" then
		return
	end

	vehicle.localised_description = { "entity-description.apm_electric" }

	local fuel_inventory_size = 2

	if vehicle.energy_source.fuel_inventory_size > 3 then
		fuel_inventory_size = 3
	end

	local burnt_inventory_size = fuel_inventory_size

	vehicle.energy_source = apm.lib.utils.builders.energy_source.new_electroaccum(
		fuel_inventory_size,
		burnt_inventory_size
	)
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.energy_addon.generate_electric_powered(name)
	local item_icon_a = apm.lib.utils.icon.get.from_item(name)
	local item_icon_b = { apm.energy_addon.icons.electric_symbol }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
	local item_car = data.raw['item-with-entity-data'][name]
	local item_name = 'apm_electric_' .. name

	---@type data.ItemPrototype
	local item = {
		type = 'item',
		name = item_name,
		localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } },
		icons = icons,
		--item.icon_mipmaps = 4
		stack_size = item_car.stack_size,
		subgroup = item_car.subgroup,
		order = item_car.order .. 'z',
		place_result = item_name,
	}

	data:extend({ item })

	local car = table.deepcopy(data.raw.car[name])

	local car_original_ico = apm.lib.utils.icon.get.from("car", name)
	local car_ico = apm.lib.utils.icon.merge({ car_original_ico, item_icon_b })

	car.name = item.name
	car.localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } }
	car.icon = nil
	car.icons = car_ico
	car.minable = { mining_time = 0.4, result = item.name }
	car.energy_source.smoke = nil

	if car.sound_no_fuel then
		car.sound_no_fuel.filename = "__apm_resource_pack_ldinc__/sounds/car/car-no-fuel-1.ogg"
	end

	if car.working_sound.main_sounds then
		car.working_sound.main_sounds = {
			sound = {
				filename = "__apm_resource_pack_ldinc__/sounds/car/car-engine.ogg",
				volume = 1.0,
			},
			match_volume_to_activity = true,
			fade_in_ticks = 10,
			activity_to_volume_modifiers = {
				multiplier = 2.0,
				offset = 1.0,
				inverted = true,
			},
		}
	end

	car.working_sound.activate_sound = nil
	car.working_sound.deactivate_sound = nil
	data:extend({ car })

	apm.energy_addon.overhaul(item.name)
end

function apm.energy_addon.generate_electric_powered_locomotive(name)
	local item_icon_a = apm.lib.utils.icon.get.from_item(name)
	local item_icon_b = { apm.energy_addon.icons.electric_symbol }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
	local item_car = data.raw['item-with-entity-data'][name]
	local item = {}

	item.type = 'item'
	item.name = 'apm_electric_' .. name
	item.localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } }
	item.icons = icons
	--item.icon_mipmaps = 4
	item.stack_size = item_car.stack_size
	item.subgroup = item_car.subgroup
	item.order = item_car.order .. 'z'
	item.place_result = item.name
	data:extend({ item })

	local locomotive = table.deepcopy(data.raw.locomotive[name])
	local locomotive_original_ico = apm.lib.utils.icon.get.from("locomotive", name)
	local locomotive_ico = apm.lib.utils.icon.merge({ locomotive_original_ico, item_icon_b })

	locomotive.name = item.name
	locomotive.localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } }
	locomotive.icon = nil
	locomotive.icons = locomotive_ico
	locomotive.minable = { mining_time = 0.4, result = item.name }
	locomotive.energy_source.smoke = nil

	-- -- locomotive.sound_no_fuel[1].filename = "__apm_resource_pack_ldinc__/sounds/car/car-no-fuel-1.ogg"
	-- -- locomotive.working_sound.sound.filename = "__apm_resource_pack_ldinc__/sounds/car/car-engine.ogg"
	-- locomotive.working_sound.sound.volume = 1.0

	locomotive.working_sound.activate_sound = nil
	locomotive.working_sound.deactivate_sound = nil
	data:extend({ locomotive })

	apm.energy_addon.overhaul(item.name)
end

function apm.energy_addon.generate_electric_locomotive_new_recipe(name)
	local resultName = "apm_electric_" .. name
	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = resultName,
		enabled = false,
		energy_required = 0.5,
		ingredients = {
			{ type = "item", name = name,                   amount = 1 },
			{ type = "item", name = "electric-engine-unit", amount = 24 },
			apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 20)
		},
		results = {
			{ type = 'item', name = resultName, amount = 1 }
		},
		main_product = resultName,
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in or true,
	}

	data:extend({ recipe })
end

function apm.energy_addon.generate_electric_locomotive_new_tech(name, suffix)
	local tName = 'apm_electric_' .. suffix
	local itmName = "apm_electric_" .. name

	---@type data.TechnologyPrototype
	local technology = {
		type = 'technology',
		name = tName,
		icon = '__base__/graphics/technology/railway.png',
		icon_size = 256,
		icon_mipmaps = 4,
		effects = {
			{ type = 'unlock-recipe', recipe = itmName },
		},
		prerequisites = { suffix, 'electric-engine', 'battery' },
		unit = {
			count = 125,
			ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "military-science-pack", 1 }, { "chemical-science-pack", 1 } },
			time = 30,
		},
		order = 'aa_a',
	}

	data:extend({ technology })
end

function apm.energy_addon.generate_electric_powered_spidertron(name)
	local item_icon_a = apm.lib.utils.icon.get.from_item(name)
	local item_icon_b = { apm.energy_addon.icons.electric_symbol }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
	local item_spidertron = data.raw['item-with-entity-data'][name]
	local e_name = 'apm_electric_' .. name

	---@type data.ItemPrototype
	local item = {

		type = 'item',
		name = e_name,
		localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } },
		icons = icons,
		--item.icon_mipmaps = 4,
		stack_size = item_spidertron.stack_size,
		subgroup = item_spidertron.subgroup,
		order = item_spidertron.order .. 'z',
		place_result = e_name,
	}

	data:extend({ item })

	local spidertron = table.deepcopy(data.raw["spider-vehicle"][name])
	local spidertron_original_ico = apm.lib.utils.icon.get.from("spider-vehicle", name)
	local spidertron_ico = apm.lib.utils.icon.merge({ spidertron_original_ico, item_icon_b })

	spidertron.name = item.name
	spidertron.localised_name = { "entity-name.apm_electric", { 'entity-name.' .. name } }
	spidertron.icon = nil
	spidertron.icons = spidertron_ico
	spidertron.minable = { mining_time = 0.4, result = item.name }
	spidertron.energy_source.smoke = nil

	-- -- locomotive.sound_no_fuel[1].filename = "__apm_resource_pack_ldinc__/sounds/car/car-no-fuel-1.ogg"
	-- -- locomotive.working_sound.sound.filename = "__apm_resource_pack_ldinc__/sounds/car/car-engine.ogg"
	-- locomotive.working_sound.sound.volume = 1.0

	spidertron.working_sound.activate_sound = nil
	spidertron.working_sound.deactivate_sound = nil
	data:extend({ spidertron })

	apm.energy_addon.overhaul(item.name)
end

function apm.energy_addon.generate_electric_spidertron_new_recipe(name)
	local resultName = "apm_electric_" .. name
	---@type data.RecipePrototype
	local recipe = {
		type = "recipe",
		name = resultName,
		enabled = false,
		energy_required = 0.5,
		ingredients = {
			{ type = "item", name = name,                   amount = 1 },
			{ type = "item", name = "electric-engine-unit", amount = 48 },
			apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T6', 40)
		},
		results = {
			{ type = 'item', name = resultName, amount = 1 }
		},
		main_product = resultName,
		requester_paste_multiplier = 4,
		always_show_products = true,
		always_show_made_in = apm_energy_addon_always_show_made_in or true,
	}

	data:extend({ recipe })
end

function apm.energy_addon.generate_electric_spidertron_new_tech(name, suffix)
	local tName = 'apm_electric_' .. suffix
	local itmName = "apm_electric_" .. name

	---@type data.TechnologyPrototype
	local technology = {
		type = 'technology',
		name = tName,
		icon = '__base__/graphics/technology/spidertron.png',
		icon_size = 256,
		icon_mipmaps = 4,
		effects = {
			{ type = 'unlock-recipe', recipe = itmName },
		},
		prerequisites = { suffix, 'electric-engine', 'battery' },
		unit = {
			count = 125,
			ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 }, { "military-science-pack", 1 }, { "chemical-science-pack", 1 } },
			time = 30,
		},
		order = 'aa_a',
	}

	data:extend({ technology })

	apm.lib.utils.technology.force.update_science_packs(technology.name)
end