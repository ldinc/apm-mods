require 'util'
require('lib.log')

local self = 'lib.utils.pump'

if apm.lib.utils.pump.get == nil then apm.lib.utils.pump.get = {} end

--- [pump.exist]
---@param pump_name string
---@return boolean
function apm.lib.utils.pump.exist(pump_name)
	if data.raw.pump[pump_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'pump with name: "' .. tostring(pump_name) .. '" dosent exist.'))
	end

	return false
end

--- [pump.get.by_name]
---@param pump_name string
---@return data.PumpPrototype
---@return boolean
function apm.lib.utils.pump.get.by_name(pump_name)
	local pump = data.raw.pump[pump_name]

	if pump then
		return pump, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'pump with name: "' .. tostring(pump_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [pump.get.fuel_categories]
---@param pump_name string
---@return data.FuelCategory[]?
function apm.lib.utils.pump.get.fuel_categories(pump_name)
	local pump, ok = apm.lib.utils.pump.get.by_name(pump_name)

	if not ok then
		return nil
	end

	if not pump.energy_source then
		return nil
	end

	if pump.energy_source.type == 'burner' then
		if pump.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(pump.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif pump.energy_source.type == 'fluid' then
		if pump.energy_source.fluid_box.filter ~= nil then
			if pump.energy_source.fluid_box.filter == 'steam' then
				return nil
			end
			
			return { { name = pump.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if pump.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'get.fuel_categories()', 'default "burner" for: ' .. tostring(pump_name)
			))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif pump.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'get.fuel_categories()', 'default "fluid" for: ' .. tostring(pump_name)
			))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [pump.update_description]
---@param pump_name any
---@return nil
function apm.lib.utils.pump.update_description(pump_name)
	local pump, ok = apm.lib.utils.pump.get.by_name(pump_name)

	if not ok then
		return nil
	end

	if not pump.energy_source then return nil end
	
	local fuel_categories = apm.lib.utils.pump.get.fuel_categories(pump_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(pump, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(pump, fuel_categories)
	end
end
