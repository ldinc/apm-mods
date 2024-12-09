require 'util'
require('lib.log')

local self = 'lib.utils.fuel'

if apm.lib.utils.fuel.category == nil then apm.lib.utils.fuel.category = {} end
if apm.lib.utils.fuel.add == nil then apm.lib.utils.fuel.add = {} end
if apm.lib.utils.fuel.get == nil then apm.lib.utils.fuel.get = {} end
if apm.lib.utils.fuel.set == nil then apm.lib.utils.fuel.set = {} end
if apm.lib.utils.fuel.exlude_list == nil then apm.lib.utils.fuel.exlude_list = {} end
if apm.lib.utils.fuel.entity == nil then apm.lib.utils.fuel.entity = {} end
if apm.lib.utils.fuel.entity.add == nil then apm.lib.utils.fuel.entity.add = {} end
if apm.lib.utils.fuel.entities == nil then apm.lib.utils.fuel.entities = {} end
if apm.lib.utils.fuel.entities.add == nil then apm.lib.utils.fuel.entities.add = {} end

---@return data.FuelCategory[]
function apm.lib.utils.fuel.get.default_category()
	return { { name = "chemical", type = "fuel-category" } }
end

---@return data.FuelCategory[]
function apm.lib.utils.fuel.get.default_fluid_category()
	return { { name = "apm_petrol", type = "fuel-category" } }
end

---@return data.FuelCategoryID[]
function apm.lib.utils.fuel.get.default_nuclear_category_ids()
	return { "apm_nuclear_uranium", "apm_nuclear_mox", "apm_nuclear_neptunium", "apm_nuclear_thorium" }
end


--- [fuel.add.to_exlude_list]
---@param entity_name any
function apm.lib.utils.fuel.add.to_exlude_list(entity_name)
	apm.lib.utils.fuel.exlude_list[entity_name] = true

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'add.to_exlude_list()',
			'add entity: "' .. tostring(entity_name) .. '" to fuel overhoule exlude_list'
		))
	end
end

--- [fuel.get_base_fuel_value]
---@return data.Energy
function apm.lib.utils.fuel.get_base_fuel_value()
	local fuel_value = 2.5

	if settings.startup['apm_power_coal_value_01779'] then
		converted = tonumber(settings.startup['apm_power_coal_value_01779'].value) -- value is MJ
		if converted then
			fuel_value = converted

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO('get_base_fuel_value()', 'from settings: ' .. tostring(fuel_value)))
			end
		else
			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO('get_base_fuel_value()', 'invalid settings: ' .. tostring(fuel_value)))
			end
		end
	end

	if apm.power.overwrites.data_stage.coal_fuel_value then
		fuel_value = apm.power.overwrites.data_stage.coal_fuel_value

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get_base_fuel_value()', 'interface overwrite: ' .. tostring(fuel_value)))
		end
	end

	return tostring(fuel_value * 1000000) .. 'J'
end

--- [fuel.overwrite_coal_fuel_value]
--- the coal fuel value is the base for all other callculations
function apm.lib.utils.fuel.overwrite_coal_fuel_value()
	local item, ok = apm.lib.utils.item.get_by_name("coal")
	if not ok then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING('overwrite_coal_fuel_value()', 'there is no ITEM: coal'))
		end

		return
	end

	local fuel_value = apm.lib.utils.fuel.get_base_fuel_value()

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('overwrite_coal_fuel_value()', 'set coal fuel value to: ' .. tostring(fuel_value)))
	end

	item.fuel_value = fuel_value
end

--- [fuel.get_coal_fuel_value()]
---@return data.Energy
function apm.lib.utils.fuel.get_coal_fuel_value()
	---@type data.ItemPrototype, boolean
	local item, ok = apm.lib.utils.item.get_by_name("coal")
	if not ok then
		return apm.lib.utils.fuel.get_base_fuel_value()
	end


	if not apm.lib.utils.item.exist('coal') then
		return apm.lib.utils.fuel.get_base_fuel_value()
	end

	return item.fuel_value
end

--- [fuel.overwrite_emissions_multiplier]
---@param item_name string
---@param emissions_multiplier number
function apm.lib.utils.fuel.overwrite_emissions_multiplier(item_name, emissions_multiplier)
	---@type data.ItemPrototype, boolean
	local item, ok = apm.lib.utils.item.get_by_name("coal")
	if not ok then
		return
	end

	item.fuel_emissions_multiplier = emissions_multiplier
end

--- [fuel.overhaul]
---@param level number
---@param item_name string
---@param multiplicator number
---@param burnt_result string
---@param fuel_category data.FuelCategoryID
function apm.lib.utils.fuel.overhaul(level, item_name, multiplicator, burnt_result, fuel_category)
	if not apm.lib.utils.item.exist(item_name) then return end

	if burnt_result then
		if not apm.lib.utils.item.exist(burnt_result) then return end
	end

	local item = data.raw.item[item_name]

	local base_value = apm.lib.utils.string.convert_to_number(apm.lib.utils.fuel.get_coal_fuel_value())
	local base_emissions_value = 1.4
	local base_acceleration_multiplier = 0.8
	local base_top_speed_multiplier = 0.8

	local new_value = tostring(apm.lib.utils.math.round(base_value * multiplicator, 2)) .. 'J'
	local new_emissions_multiplier = apm.lib.utils.math.round(base_emissions_value - (level * 0.10), 2)
	if new_emissions_multiplier < 0.8 then
		new_emissions_multiplier = 0.8
	end
	local new_acceleration_multiplier = apm.lib.utils.math.round(base_acceleration_multiplier + (0.06 * level), 2)
	local new_top_speed_multiplier = apm.lib.utils.math.round(base_top_speed_multiplier + (0.06 * level), 2)

	if not fuel_category then
		fuel_category = 'chemical'
	end

	item.fuel_value                   = new_value
	item.fuel_category                = fuel_category
	item.fuel_emissions_multiplier    = new_emissions_multiplier
	item.fuel_acceleration_multiplier = new_acceleration_multiplier
	item.fuel_top_speed_multiplier    = new_top_speed_multiplier
	item.burnt_result                 = burnt_result

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'overhaul()',
			'item/fluid with name: "' ..
			tostring(item_name) ..
			'" changed. New fuel value: "' ..
			tostring(new_value) ..
			'" with burnt_result: "' .. tostring(burnt_result) .. '" with category: "' .. tostring(fuel_category) .. '"'
		))
	end
end

--- [fuel.category.create]
---@param category_name string
function apm.lib.utils.fuel.category.create(category_name)
	local recipe_category = {}

	recipe_category.type = "fuel-category"
	recipe_category.name = category_name

	data:extend({ recipe_category })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('category.create()', 'created category with name: "' .. tostring(category_name) .. '"'))
	end
end
