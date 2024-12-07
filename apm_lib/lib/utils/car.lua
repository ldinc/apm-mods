require 'util'
require('lib.log')

local self = 'lib.utils.car'

if not apm.lib.utils.car.get then apm.lib.utils.car.get = {} end
if not apm.lib.utils.car.add then apm.lib.utils.car.add = {} end
if not apm.lib.utils.car.set then apm.lib.utils.car.set = {} end


function apm.lib.utils.car.exist(car_name)
	if data.raw.car[car_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'car with name: "' .. tostring(car_name) .. '" dosent exist.'))
	end

	return false
end

--- [car.get.by_name]
---@param car_name string
---@return data.CarPrototype
---@return boolean
function apm.lib.utils.car.get.by_name(car_name)
	local car = data.raw.car[car_name]
	if car then
		return car, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'car with name: "' .. tostring(car_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [car.get.fuel_categories]
---@param car_name string
---@return data.FuelCategoryID[]?
function apm.lib.utils.car.get.fuel_categories(car_name)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return nil
	end

	if not car.energy_source then return nil end

	if car.energy_source then
		if car.energy_source.type == 'burner' then
			if car.energy_source.fuel_categories then
				return car.energy_source.fuel_categories
			end

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO('get.fuel_categories()', 'default "burner" for: ' .. tostring(car_name)))
			end

			return apm.lib.utils.fuel.get.default_category()
		end
	end

	return nil
end

--- [car.update_description]
---@param car_name string
function apm.lib.utils.car.update_description(car_name)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return
	end

	if not car.energy_source or not (car.energy_source.type == "burner") then
		return
	end

	local fuel_categories = apm.lib.utils.car.get.fuel_categories(car_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(car, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(car, fuel_categories)
	end
end

--- [car.overhaul]
---@param car_name string
function apm.lib.utils.car.overhaul(car_name)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return
	end

	local base_emissions_per_minute = 2

	if not car.energy_source or not (car.energy_source.type == "burner") then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING('overhaul()', 'car with name: "' .. tostring(car_name) .. '" has no property: burner'))
		end

		return
	end

	if apm.lib.utils.entity.has.fuel_category(car, 'apm_electrical') then
		return
	end

	car.energy_source.burnt_inventory_size = car.energy_source.fuel_inventory_size
	car.energy_source.emissions_per_minute = { pollution = base_emissions_per_minute }

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('overhaul()', 'car with name: "' .. tostring(car_name) .. '" changed...'))
	end
end

--- [car.effectivity]
---@param car_name string
---@param value number
function apm.lib.utils.car.set.effectivity(car_name, value)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return
	end

	car.effectivity = value
end

--- [car.overhaul_all]
function apm.lib.utils.car.overhaul_all()
	for car, _ in pairs(data.raw.car) do
		apm.lib.utils.car.overhaul(car)
	end
end

--- [car.add.fuel_category]
---@param car_name string
---@param category data.FuelCategoryID
function apm.lib.utils.car.add.fuel_category(car_name, category)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.add.fuel_category(car, category)
end

--- [car.set.fuel_category]
---@param car_name string
---@param categories data.FuelCategoryID[] | data.FuelCategoryID
function apm.lib.utils.car.set.fuel_category(car_name, categories)
	local car, ok = apm.lib.utils.car.get.by_name(car_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.set.fuel_category(car, categories)
end
