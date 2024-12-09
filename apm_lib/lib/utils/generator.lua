require 'util'
require('lib.log')

local self = 'lib.utils.generator'

if apm.lib.utils.generator.mod == nil then apm.lib.utils.generator.mod = {} end
if apm.lib.utils.generator.set == nil then apm.lib.utils.generator.set = {} end
if apm.lib.utils.generator.get == nil then apm.lib.utils.generator.get = {} end

--- [generator.exist]
---@param generator_name string
---@return boolean
function apm.lib.utils.generator.exist(generator_name)
	if data.raw.generator[generator_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'generator with name: "' .. tostring(generator_name) .. '" doesnt exist.'))
	end

	return false
end

--- [generator.get.by_name]
---@param generator_name string
---@return data.GeneratorPrototype
---@return boolean
function apm.lib.utils.generator.get.by_name(generator_name)
	local generator = data.raw.generator[generator_name]

	if generator then
		return generator, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('get.by_name()', 'generator with name: "' .. tostring(generator_name) .. '" doesnt exist.'))
	end

	return {}, false
end

--- [generator.set.burner_fuel_categories]
---@param generator_name string
---@param fuel_categories data.FuelCategoryID | data.FuelCategoryID[]
function apm.lib.utils.generator.set.burner_fuel_categories(generator_name, fuel_categories)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.set.fuel_category(generator, fuel_categories)
end

--- [generator.get.fuel_categories]
---@param generator_name string
---@return data.FuelCategory[]?
function apm.lib.utils.generator.get.fuel_categories(generator_name)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return nil
	end

	if not generator.energy_source and not generator.fluid_box then
		return nil
	end

	if generator.fluid_box and generator then
		if generator.fluid_box.filter ~= nil then
			if generator.fluid_box.filter == 'steam' then
				return nil
			end

			return { { name = generator.fluid_box.filter, type = 'fluid' } }
		end
	end

	if generator.fluid_box then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'default "fluid" for: ' .. tostring(generator_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [generator.update_description]
---@param generator_name string
function apm.lib.utils.generator.update_description(generator_name)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return
	end

	local fuel_categories = apm.lib.utils.generator.get.fuel_categories(generator_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(generator, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(generator, fuel_categories)
	end
end

--- [generator.set.next_upgrade]
---@param generator_name string
---@param next_upgrade string?
function apm.lib.utils.generator.set.next_upgrade(generator_name, next_upgrade)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return
	end

	apm.lib.utils.entity.set.next_upgrade(generator, next_upgrade)
end

--- [generator.overhaul]
---@param generator_name any
---@param level any
function apm.lib.utils.generator.overhaul(generator_name, level)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return
	end

	apm.lib.utils.icon.add_tier_lable(generator_name, level)

	local base_maximum_temperature = 120
	local base_fluid_usage_per_tick = 0.5
	local base_effectivity = 0.9

	local new_maximum_temperature = base_maximum_temperature + ((level - 1) * 150)
	local new_fluid_usage_per_tick = base_fluid_usage_per_tick - ((level - 1) * 0.025)
	local new_effectivity = base_effectivity + ((level - 1) * 0.01)

	generator.maximum_temperature = new_maximum_temperature
	generator.fluid_usage_per_tick = new_fluid_usage_per_tick
	generator.effectivity = new_effectivity

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'overhaul()', 'generator with name: "' .. tostring(generator_name) .. '" changed'
		))
	end
end

--- [generator.set.hidden]
---@param generator_name string
function apm.lib.utils.generator.set.hidden(generator_name)
	local generator, ok = apm.lib.utils.generator.get.by_name(generator_name)

	if not ok then
		return
	end

	generator.hidden = true
	generator.hidden_in_factoriopedia = true
end
