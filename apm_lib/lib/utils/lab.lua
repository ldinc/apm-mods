require 'util'
require('lib.log')

local self = 'lib.utils.lab'

if apm.lib.utils.lab.add == nil then apm.lib.utils.lab.add = {} end
if apm.lib.utils.lab.set == nil then apm.lib.utils.lab.set = {} end
if apm.lib.utils.lab.get == nil then apm.lib.utils.lab.get = {} end

--- [lab.exist]
---@param lab_name string
---@return boolean
function apm.lib.utils.lab.exist(lab_name)
	if data.raw.lab[lab_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'exist()', 'lab with name: "' .. tostring(lab_name) .. '" doesnt exist.'
		))
	end

	return false
end

--- [lab.get.by_name]
---@param lab_name string
---@return data.LabPrototype
---@return boolean
function apm.lib.utils.lab.get.by_name(lab_name)
	local lab = data.raw.lab[lab_name]
	if lab then
		return lab, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'exist()', 'lab with name: "' .. tostring(lab_name) .. '" doesnt exist.'
		))
	end

	return {}, false
end

--- [lab.get.fuel_categories]
---@param lab_name string
---@return data.FuelCategory[]?
function apm.lib.utils.lab.get.fuel_categories(lab_name)
	local lab, ok = apm.lib.utils.lab.get.by_name(lab_name)

	if not ok then
		return nil
	end

	if not lab.energy_source then return nil end

	if lab.energy_source.type == 'burner' then
		if lab.energy_source.fuel_categories then
			local rc = {}

			for _, fc in pairs(lab.energy_source.fuel_categories) do
				table.insert(rc, { name = fc, type = 'fuel-category' })
			end

			return rc
		end
	elseif lab.energy_source.type == 'fluid' then
		if lab.energy_source.fluid_box.filter ~= nil then
			if lab.energy_source.fluid_box.filter == 'steam' then
				return nil
			end

			return { { name = lab.energy_source.fluid_box.filter, type = 'fluid' } }
		end
	end

	if lab.energy_source.type == 'burner' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "burner" for: ' .. tostring(lab_name)))
		end

		return apm.lib.utils.fuel.get.default_category()
	elseif lab.energy_source.type == 'fluid' then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('get.fuel_categories()', 'set default "fluid" for: ' .. tostring(lab_name)))
		end

		return apm.lib.utils.fuel.get.default_fluid_category()
	end

	return nil
end

--- [lab.update_description]
---@param lab_name string
function apm.lib.utils.lab.update_description(lab_name)
	local lab, ok = apm.lib.utils.lab.get.by_name(lab_name)

	if not ok then
		return
	end

	if not lab.energy_source then
		return
	end

	local fuel_categories = apm.lib.utils.lab.get.fuel_categories(lab_name)

	if fuel_categories ~= nil then
		apm.lib.utils.description.entities.setup(lab, fuel_categories)
		--apm.lib.utils.description.entities.add_fuel_types(lab, fuel_categories)
	end
end

--- [lab.overhaul]
---@param lab_name any
function apm.lib.utils.lab.overhaul(lab_name)
	local lab, ok = apm.lib.utils.lab.get.by_name(lab_name)

	if not ok then
		return
	end

	lab.fast_replaceable_group = "lab"

	local inputs = table.deepcopy(lab.inputs)

	lab.inputs = {}

	apm.lib.utils.lab.add.science_pack(lab_name, "apm_industrial_science_pack")
	apm.lib.utils.lab.add.science_pack(lab_name, "apm_steam_science_pack")

	for _, science_pack in pairs(inputs) do
		apm.lib.utils.lab.add.science_pack(lab_name, science_pack)
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('overhaul()', 'lab with name: "' .. tostring(lab_name) .. '" changed.'))
	end
end

--- [check_for_science_packs]
---@param lab data.LabPrototype
---@param science_pack string
---@return boolean
local function check_for_science_packs(lab, science_pack)
	for s in pairs(lab.inputs) do
		if s == science_pack then
			return true
		end
	end

	return false
end

--- [lab.add.science_pack]
---@param lab_name string
---@param science_pack string
function apm.lib.utils.lab.add.science_pack(lab_name, science_pack)
	local lab, ok = apm.lib.utils.lab.get.by_name(lab_name)

	if not ok then
		return
	end

	if not check_for_science_packs(lab, science_pack) then
		table.insert(lab.inputs, science_pack)

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'add.science_pack()',
				'added: "' .. tostring(science_pack) .. '"  to "' .. tostring(lab_name) .. '"'
			))
		end

		return
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'add.science_pack()',
			'cant add: "' .. tostring(science_pack) .. '"  to "' .. tostring(lab_name) .. '" is allready there.'
		))
	end
end
