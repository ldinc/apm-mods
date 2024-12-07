require 'util'
require('lib.log')

local self = 'lib.utils.equipment'

if not apm.lib.utils.equipment.get then apm.lib.utils.equipment.get = {} end
if not apm.lib.utils.equipment.add then apm.lib.utils.equipment.add = {} end
if not apm.lib.utils.equipment.set then apm.lib.utils.equipment.set = {} end

-- Locals ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local prototypes = { 'generator-equipment' }


--- [equipment.exist]
---@param equipment_name string
---@return boolean
function apm.lib.utils.equipment.exist(equipment_name)
	for _, prototype in pairs(prototypes) do
		if data.raw[prototype][equipment_name] then
			return true
		end
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'equipment with name: "' .. tostring(equipment_name) .. '" dosent exist.'))
	end

	return false
end

--- [equipment.get.type]
---@param equipment_name string
---@return string?
function apm.lib.utils.equipment.get.type(equipment_name)
	for _, prototype in pairs(prototypes) do
		if data.raw[prototype][equipment_name] then
			return prototype
		end
	end
	return nil
end

--- [equipment.get.fuel_categories]
---@param equipment_name string
---@return data.FuelCategory[]?
function apm.lib.utils.equipment.get.fuel_categories(equipment_name)
	if not apm.lib.utils.equipment.exist(equipment_name) then
		return nil
	end

	local prototype = apm.lib.utils.equipment.get.type(equipment_name)

	local equipment = data.raw[prototype][equipment_name]
	if not equipment.burner then
		return nil
	end

	if equipment.burner.fuel_category then
		return { { name = equipment.burner.fuel_category, type = 'fuel-category' } }
	elseif equipment.burner.fuel_categories then
		local rc = {}

		for _, fc in pairs(equipment.burner.fuel_categories) do
			table.insert(rc, { name = fc, type = 'fuel-category' })
		end

		return rc
	end

	if equipment.energy_source then
		if equipment.energy_source.type == 'burner' then
			if APM_CAN_LOG_INFO then
				log(APM_MSG_WARNING('get.fuel_categories()', 'default "burner" for: ' .. tostring(equipment_name)))
			end

			return apm.lib.utils.fuel.get.default_category()
		elseif equipment.energy_source.type == 'fluid' then
			if APM_CAN_LOG_WARN then
				log(APM_MSG_WARNING('get.fuel_categories()', 'default "fluid" for: ' .. tostring(equipment_name)))
			end

			return apm.lib.utils.fuel.get.default_fluid_category()
		end
	end

	return nil
end

--- [equipment.update_description]
---@param equipment_name string
function apm.lib.utils.equipment.update_description(equipment_name)
	if not apm.lib.utils.equipment.exist(equipment_name) then
		return
	end

	local prototype = apm.lib.utils.equipment.get.type(equipment_name)
	local equipment = data.raw[prototype][equipment_name]

	if not equipment.burner then
		return
	end
	--equipment.localised_description = {"", {"apm_info_fuel_equipment_manager"}}

	local fuel_categories = apm.lib.utils.equipment.get.fuel_categories(equipment_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(equipment, fuel_categories)
	end
end
