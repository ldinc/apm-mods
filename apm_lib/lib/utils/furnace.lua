require 'util'
require('lib.log')

local self = 'lib.utils.furnace'

if apm.lib.utils.furnace.mod == nil then apm.lib.utils.furnace.mod = {} end
if apm.lib.utils.furnace.mod.category == nil then apm.lib.utils.furnace.mod.category = {} end
if apm.lib.utils.furnace.get == nil then apm.lib.utils.furnace.get = {} end
if apm.lib.utils.furnace.set == nil then apm.lib.utils.furnace.set = {} end

--- [furnace.get.by_name]
---@param furnace_name string
---@return data.FurnacePrototype
---@return boolean
function apm.lib.utils.furnace.get.by_name(furnace_name)
	local furnace = data.raw.furnace[furnace_name]

	if furnace then
		return furnace, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'furnace with name: "' .. tostring(furnace_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [furnace.mod.category.add]
---@param furnace_name string
---@param category string
function apm.lib.utils.furnace.mod.category.add(furnace_name, category)
	local furnace, ok = apm.lib.utils.furnace.get.by_name(furnace_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.add.crafting_category(furnace, category)
end

--- [furnace.get.fuel_categories]
---@param furnace_name string
---@return data.FuelCategoryID[]?
function apm.lib.utils.furnace.get.fuel_categories(furnace_name)
	local furnace, ok = apm.lib.utils.furnace.get.by_name(furnace_name)

	if not ok then
		return nil
	end

	if not furnace.energy_source then
		return nil
	end

	if furnace.energy_source.type == 'burner' then
		if furnace.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(furnace.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif furnace.energy_source.type == 'fluid' then
		if furnace.energy_source.fluid_box.filter ~= nil then
			return { { name = furnace.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if furnace.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'default "burner" for: ' .. tostring(furnace_name)))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif furnace.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'default "fluid" for: ' .. tostring(furnace_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [furnace.update_description]
---@param furnace_name string
function apm.lib.utils.furnace.update_description(furnace_name)
	local furnace, ok = apm.lib.utils.furnace.get.by_name(furnace_name)

	if not ok then
		return
	end

	if not furnace.energy_source then
		return
	end

	local fuel_categories = apm.lib.utils.furnace.get.fuel_categories(furnace_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(furnace, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(furnace, fuel_categories)
	end
end

--- [furnace.overhaul]
---@param furnace_name string
---@param only_refined boolean
function apm.lib.utils.furnace.overhaul(furnace_name, only_refined)
	local furnace, ok = apm.lib.utils.furnace.get.by_name(furnace_name)

	if not ok then
		return
	end

	if furnace.energy_source.type == 'burner' then
		furnace.energy_source.burnt_inventory_size = 1
		furnace.energy_source.fuel_categories = nil

		if only_refined then
			apm.lib.utils.entity.set.fuel_category(furnace, 'apm_refined_chemical')
		else
			apm.lib.utils.entity.set.fuel_category(furnace, { 'chemical', 'apm_refined_chemical' })
		end

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('overhaul()', 'furnace with name: "' .. tostring(furnace_name) .. '" changed'))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'overhaul()',
			'furnace with name: "' .. tostring(furnace_name) .. '" dosent have energy_source.type == "burner"'
		))
	end
end

--- [furnace.set.hidden]
---@param furnace_name string
function apm.lib.utils.furnace.set.hidden(furnace_name)
	local furnace, ok = apm.lib.utils.furnace.get.by_name(furnace_name)

	if not ok then
		return
	end

	furnace.hidden = true
	furnace.hidden_in_factoriopedia = true
end
