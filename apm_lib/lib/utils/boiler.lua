require 'util'
require('lib.log')

local self = 'lib.utils.boiler'

if not apm.lib.utils.boiler.mod then apm.lib.utils.boiler.mod = {} end
if not apm.lib.utils.boiler.set then apm.lib.utils.boiler.set = {} end
if not apm.lib.utils.boiler.get then apm.lib.utils.boiler.get = {} end


function apm.lib.utils.boiler.exist(boiler_name)
	if data.raw.boiler[boiler_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'boiler with name: "' .. tostring(boiler_name) .. '" dosent exist.'))
	end

	return false
end

--- [boiler.get.by_name]
---@param boiler_name string
---@return data.BoilerPrototype
---@return boolean
function apm.lib.utils.boiler.get.by_name(boiler_name)
	local boiler = data.raw.boiler[boiler_name]
	if boiler then
		return boiler, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'boiler with name: "' .. tostring(boiler_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [boiler.get.fuel_categories]
---@param boiler_name string
---@return data.FuelCategoryID[]?
function apm.lib.utils.boiler.get.fuel_categories(boiler_name)
	local boiler, ok = apm.lib.utils.boiler.get.by_name(boiler_name)

	if not ok then
		return nil
	end
	if not boiler.energy_source then
		return nil
	end

	if boiler.energy_source.type == 'burner' then
		if boiler.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(boiler.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif boiler.energy_source.type == 'fluid' then
		if boiler.energy_source.fluid_box.filter ~= nil then
			return { { name = boiler.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if boiler.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'default "burner" for: ' .. tostring(boiler_name)))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif boiler.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'default "fluid" for: ' .. tostring(boiler_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [boiler.update_description]
---@param boiler_name string
function apm.lib.utils.boiler.update_description(boiler_name)
	local boiler, ok = apm.lib.utils.boiler.get.by_name(boiler_name)

	if not ok then
		return
	end

	if not boiler.energy_source then
		return
	end

	local fuel_categories = apm.lib.utils.boiler.get.fuel_categories(boiler_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(boiler, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(boiler, fuel_categories)
	end
end

--- [boiler.set.next_upgrade]
---@param boiler_name string
---@param next_upgrade string
function apm.lib.utils.boiler.set.next_upgrade(boiler_name, next_upgrade)
	local boiler, ok = apm.lib.utils.boiler.get.by_name(boiler_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.set.next_upgrade(boiler, next_upgrade)
end

--- [boiler.overhaul]
---@param boiler_name string
---@param level number
function apm.lib.utils.boiler.overhaul(boiler_name, level)
	local boiler, ok = apm.lib.utils.boiler.get.by_name(boiler_name)

	if not ok then
		return
	end

	apm.lib.utils.icon.add_tier_lable(boiler_name, level)

	local base_energy_consumption = 1800000
	local base_target_temperature = 120
	local base_effectivity = 0.8
	local base_emissions_per_minute = 25

	local new_energy_source_effectivity = base_effectivity + ((level - 1) * 0.03)
	local new_target_temperature = base_target_temperature + ((level - 1) * 150)
	local new_energy_consumption = base_energy_consumption * level
	local new_emissions_per_minute = base_emissions_per_minute - ((level - 1) * 2.5)

	if boiler.energy_source.type == 'burner' then
		boiler.fast_replaceable_group = 'boiler'
		boiler.target_temperature = new_target_temperature
		boiler.energy_consumption = new_energy_consumption .. 'W'
		boiler.energy_source.effectivity = new_energy_source_effectivity
		boiler.energy_source.fuel_inventory_size = 1
		boiler.energy_source.burnt_inventory_size = 1
		boiler.energy_source.fuel_categories = { 'apm_refined_chemical' }
		boiler.energy_source.emissions_per_minute = { pollution = new_emissions_per_minute }
		--apm.lib.utils.entity.add.fuel_category(boiler, 'apm_refined_chemical')
		--apm.lib.utils.entity.del.fuel_category(boiler, 'chemical')

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('overhaul()', 'boiler with name: "' .. tostring(boiler_name) .. '" changed'))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'overhaul()',
			'boiler with name: "' .. tostring(boiler_name) .. '" has not energy_source.type = "burner"'
		))
	end
end

--- [boiler.set.hidden]
---@param boiler_name string
function apm.lib.utils.boiler.set.hidden(boiler_name)
	local boiler, ok = apm.lib.utils.boiler.get.by_name(boiler_name)

	if not ok then
		return
	end

	boiler.hidden = true
	boiler.hidden_in_factoriopedia = true
end
