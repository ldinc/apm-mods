require 'util'
require('lib.log')

local self = 'lib.utils.locomotive'

if apm.lib.utils.locomotive.add == nil then apm.lib.utils.locomotive.add = {} end
if apm.lib.utils.locomotive.get == nil then apm.lib.utils.locomotive.get = {} end
if apm.lib.utils.locomotive.has == nil then apm.lib.utils.locomotive.has = {} end

--- [locomotive.exist]
---@param locomotive_name string
---@return boolean
function apm.lib.utils.locomotive.exist(locomotive_name)
	if data.raw.locomotive[locomotive_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'locomotive with name: "' .. tostring(locomotive_name) .. '" dosent exist.'))
	end

	return false
end

--- [locomotive.get.by_name]
---@param locomotive_name string
---@return data.LocomotivePrototype
---@return boolean
function apm.lib.utils.locomotive.get.by_name(locomotive_name)
	local locomotive = data.raw.locomotive[locomotive_name]

	if locomotive then
		return locomotive, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'locomotive with name: "' .. tostring(locomotive_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [locomotive.get.fuel_categories]
---@param locomotive_name string
---@return data.FuelCategory[]?
function apm.lib.utils.locomotive.get.fuel_categories(locomotive_name)
	local locomotive, ok = apm.lib.utils.locomotive.get.by_name(locomotive_name)

	if not ok then
		return nil
	end

	if locomotive.energy_source then
		if locomotive.energy_source.fuel_categories then
			local rc = {}
			for _, fc in pairs(locomotive.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end

		if locomotive.energy_source.type == 'burner' then
			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO('get.fuel_categories()', 'set default "burner" for: ' .. tostring(locomotive_name)))
			end

			return apm.lib.utils.fuel.get.default_category()
		end
	end

	return nil
end

--- [locomotive.update_description]
---@param locomotive_name string
function apm.lib.utils.locomotive.update_description(locomotive_name)
	local locomotive, ok = apm.lib.utils.locomotive.get.by_name(locomotive_name)

	if not ok then
		return
	end

	if not locomotive.energy_source then return end

	local fuel_categories = apm.lib.utils.locomotive.get.fuel_categories(locomotive_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(locomotive, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(locomotive, fuel_categories)
	end
end

--- [locomotive.add.fuel_category]
---@param locomotive_name string
---@param fuel_category data.FuelCategoryID
function apm.lib.utils.locomotive.add.fuel_category(locomotive_name, fuel_category)
	local locomotive, ok = apm.lib.utils.locomotive.get.by_name(locomotive_name)

	if not ok then
		return
	end

	if locomotive.energy_source then
		if not apm.lib.utils.entity.has.fuel_category(locomotive, fuel_category) then
			table.insert(locomotive.energy_source.fuel_categories, fuel_category)

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add.fuel_category()',
					'locomotive with name: "' ..
					tostring(locomotive_name) .. '" added: "' .. tostring(fuel_category) .. '" as fuel_category'
				))
			end
		else
			if APM_CAN_LOG_WARN then
				log(APM_MSG_WARNING(
					'add.fuel_category()',
					'locomotive with name: "' ..
					tostring(locomotive_name) .. '" allready has "' .. tostring(fuel_category) .. '" as fuel_category'
				))
			end
		end
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'add.fuel_category()',
				'locomotive with name: "' .. tostring(locomotive_name) .. '" has no property: burner..'
			))
		end
	end
end

--- [locomotive.overhaul]
---@param locomotive_name string
function apm.lib.utils.locomotive.overhaul(locomotive_name)
	local locomotive, ok = apm.lib.utils.locomotive.get.by_name(locomotive_name)

	if not ok then
		return
	end

	local base_emissions_per_minute = 4

	if not locomotive.energy_source then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'overhaul()',
				'locomotive with name: "' .. tostring(locomotive_name) .. '" has no property: burner.'
			))
		end

		return
	end

	if apm.lib.utils.entity.has.fuel_category(locomotive, 'apm_electrical') then
		return
	end

	locomotive.energy_source.burnt_inventory_size = locomotive.energy_source.fuel_inventory_size
	locomotive.energy_source.emissions_per_minute = {pollution = base_emissions_per_minute}
	locomotive.energy_source.effectivity = 0.42

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('overhaul()', 'locomotive with name: "' .. tostring(locomotive_name) .. '" changed.'))
	end
end

--- [locomotive.overhaul_all]
function apm.lib.utils.locomotive.overhaul_all()
	for locomotive, _ in pairs(data.raw.locomotive) do
		apm.lib.utils.locomotive.overhaul(locomotive)
	end
end
