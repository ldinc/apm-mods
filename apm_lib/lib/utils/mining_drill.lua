require 'util'
require('lib.log')

local self = 'lib.utils.mining_drill'

if apm.lib.utils.mining_drill.get == nil then apm.lib.utils.mining_drill.get = {} end
if apm.lib.utils.mining_drill.set == nil then apm.lib.utils.mining_drill.set = {} end
if apm.lib.utils.mining_drill.burner == nil then apm.lib.utils.mining_drill.burner = {} end
if apm.lib.utils.mining_drill.burner.mod == nil then apm.lib.utils.mining_drill.burner.mod = {} end

--- [mining_drill.exist]
---@param mining_drill_name string
---@return boolean
function apm.lib.utils.mining_drill.exist(mining_drill_name)
	if data.raw['mining-drill'][mining_drill_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('mining-drill with name: "' .. tostring(mining_drill_name) .. '" doesnt exist.'))
	end

	return false
end

--- [mining_drill.get.by_name]
---@param mining_drill_name string
---@return data.MiningDrillPrototype
---@return boolean
function apm.lib.utils.mining_drill.get.by_name(mining_drill_name)
	local mining_drill = data.raw['mining-drill'][mining_drill_name]
	if mining_drill then
		return mining_drill, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('mining-drill with name: "' .. tostring(mining_drill_name) .. '" doesnt exist.'))
	end

	return {}, false
end

--- [mining_drill.get.fuel_categories]
---@param mining_drill_name string
---@return data.FuelCategory[]?
function apm.lib.utils.mining_drill.get.fuel_categories(mining_drill_name)
	local mining_drill, ok = apm.lib.utils.mining_drill.get.by_name(mining_drill_name)

	if not ok then
		return nil
	end

	if not mining_drill.energy_source then
		return nil
	end

	if mining_drill.energy_source.type == 'burner' then
		if mining_drill.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(mining_drill.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif mining_drill.energy_source.type == 'fluid' then
		if mining_drill.energy_source.fluid_box.filter ~= nil then
			if mining_drill.energy_source.fluid_box.filter == 'steam' then
				return nil
			end

			return { { name = mining_drill.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if mining_drill.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "burner" for: ' .. tostring(mining_drill_name)))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif mining_drill.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "fluid" for: ' .. tostring(mining_drill_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [mining_drill.update_description]
---@param mining_drill_name string
function apm.lib.utils.mining_drill.update_description(mining_drill_name)
	local mining_drill, ok = apm.lib.utils.mining_drill.get.by_name(mining_drill_name)

	if not ok or not mining_drill.energy_source then
		return
	end

	local fuel_categories = apm.lib.utils.mining_drill.get.fuel_categories(mining_drill_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(mining_drill, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(mining_drill, fuel_categories)
	end
end

--- [mining_drill.burner.overhaul]
---@param mining_drill_name string
---@param level number?
function apm.lib.utils.mining_drill.burner.overhaul(mining_drill_name, level)
	local mining_drill, ok = apm.lib.utils.mining_drill.get.by_name(mining_drill_name)

	if not ok then
		return
	end

	if not mining_drill.energy_source.type == 'burner' then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'burner.overhaul()',
				'mining-drill with name: "' .. tostring(mining_drill_name) .. '" has not energy_source.type == "burner".'
			))
		end

		return
	end

	local base_mining_speed = 0.25
	local base_energy_usage = 115000
	local base_emissions_per_minute = 6

	local new_base_emissions_per_minute = base_emissions_per_minute * (1 + ((level - 1) * 0.25))
	local new_mining_speed = base_mining_speed + ((level - 1) * 0.15)
	local new_energy_usage = base_energy_usage + ((level - 1) * 75000)

	mining_drill.mining_speed = new_mining_speed
	mining_drill.energy_usage = new_energy_usage .. 'W'

	mining_drill.energy_source = apm.lib.utils.builders.energy_source.new_burner(
		{ 'chemical', 'apm_refined_chemical' },
		{ pollution = new_base_emissions_per_minute }
	)

	-- mining_drill.energy_source.effectivity = 0.42

	mining_drill.resource_searching_radius = 0.99 + level - 1
	mining_drill.radius_visualisation_picture = {
		filename =
		"__base__/graphics/entity/electric-mining-drill/electric-mining-drill-radius-visualization.png",
		width = 10,
		height = 10
	}

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('burner.overhaul()', 'mining-drill with name: "' .. tostring(mining_drill_name) .. '" changed.'))
	end
end

--- [mining_drill.set.hidden]
---@param mining_drill_name string
function apm.lib.utils.mining_drill.set.hidden(mining_drill_name)
	local mining_drill, ok = apm.lib.utils.mining_drill.get.by_name(mining_drill_name)

	if not ok then
		return
	end

	mining_drill.hidden = true
	mining_drill.hidden_in_factoriopedia = true
end
