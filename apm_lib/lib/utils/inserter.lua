require 'util'
require('lib.log')

local self = 'lib.utils.inserter'

if apm.lib.utils.inserter.get == nil then apm.lib.utils.inserter.get = {} end
if apm.lib.utils.inserter.burner == nil then apm.lib.utils.inserter.burner = {} end
if apm.lib.utils.inserter.burner.mod == nil then apm.lib.utils.inserter.burner.mod = {} end

--- [inserter.exist]
---@param inserter_name string
---@return boolean
function apm.lib.utils.inserter.exist(inserter_name)
	if data.raw.inserter[inserter_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'inserter with name: "' .. tostring(inserter_name) .. '" dosent exist.'))
	end

	return false
end

--- [inserter.get.by_name]
---@param inserter_name string
---@return data.InserterPrototype
---@return boolean
function apm.lib.utils.inserter.get.by_name(inserter_name)
	local inserter = data.raw.inserter[inserter_name]

	if inserter then
		return inserter, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'inserter with name: "' .. tostring(inserter_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [inserter.get.fuel_categories]
---@param inserter_name string
---@return data.FuelCategory[]?
function apm.lib.utils.inserter.get.fuel_categories(inserter_name)
	local inserter, ok = apm.lib.utils.inserter.get.by_name(inserter_name)

	if not ok then
		return nil
	end

	if not inserter.energy_source then return nil end

	if inserter.energy_source.type == 'burner' then
		if inserter.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(inserter.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif inserter.energy_source.type == 'fluid' then
		if inserter.energy_source.fluid_box.filter ~= nil then
			return { { name = inserter.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if inserter.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "burner" for: ' .. tostring(inserter_name)))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif inserter.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "fluid" for: ' .. tostring(inserter_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [inserter.update_description]
---@param inserter_name string
function apm.lib.utils.inserter.update_description(inserter_name)
	local inserter, ok = apm.lib.utils.inserter.get.by_name(inserter_name)

	if not ok then
		return nil
	end

	if not inserter.energy_source then return end

	local fuel_categories = apm.lib.utils.inserter.get.fuel_categories(inserter_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(inserter, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(inserter, fuel_categories)
	end
end

--- [inserter.burner.overhaul]
---@param inserter_name string
function apm.lib.utils.inserter.burner.overhaul(inserter_name)
	local inserter, ok = apm.lib.utils.inserter.get.by_name(inserter_name)

	if not ok then
		return
	end

	if inserter.energy_source.type == 'burner' then
		inserter.energy_source.burnt_inventory_size = 1
		inserter.energy_source.fuel_categories = { 'chemical', 'apm_refined_chemical' }

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('burner.overhaul()', 'inserter with name: "' .. tostring(inserter_name) .. '"changed'))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'burner.overhaul()',
			'inserter with name: "' .. tostring(inserter_name) .. '" dosent has energy_source.type == "burner"'
		))
	end
end
