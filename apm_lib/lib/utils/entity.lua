require 'util'
require('lib.log')

local self = 'lib.utils.entity'

if apm.lib.utils.entity.has == nil then apm.lib.utils.entity.has = {} end
if apm.lib.utils.entity.get == nil then apm.lib.utils.entity.get = {} end
if apm.lib.utils.entity.add == nil then apm.lib.utils.entity.add = {} end
if apm.lib.utils.entity.del == nil then apm.lib.utils.entity.del = {} end
if apm.lib.utils.entity.set == nil then apm.lib.utils.entity.set = {} end

--- [entity.prototype_list]
--- Set default list of handled prorotypes for some fns (like next_upgrade and etc)
---@return string[]
function apm.lib.utils.entity.prototype_list()
	local prototypes = {
		'assembling-machine',
		'boiler',
		'inserter',
		'lab',
		'locomotive',
		'mining-drill',
		'reactor',
		'ammo-turret',
		'car',
		'generator',
	}

	return prototypes
end

--- [ntity.has.fuel_category]
---@param entity any
---@param category data.FuelCategoryID
---@return boolean
function apm.lib.utils.entity.has.fuel_category(entity, category)
	if entity.burner then
		if entity.burner.fuel_categories then
			for i = 1, #entity.burner.fuel_categories do
				if entity.burner.fuel_categories[i] == category then return true end
			end
		end

		if entity.burner.fuel_categories == nil and category == 'chemical' then
			return true
		end
	end

	if entity.energy_source and entity.energy_source.type == 'burner' then
		if entity.energy_source.fuel_categories then
			for i = 1, #entity.energy_source.fuel_categories do
				if entity.energy_source.fuel_categories[i] == category then return true end
			end
		end

		if entity.energy_source.fuel_category == nil and entity.energy_source.fuel_categories == nil and category == 'chemical' then
			return true
		end
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'has.fuel_categories()',
			'entity: "' .. tostring(entity.name) .. '" does not have a fuel_category'
		))
	end

	return false
end

--- [entity.get.fuel_categories]
---@param entity any
---@return data.FuelCategoryID[]?
function apm.lib.utils.entity.get.fuel_categories(entity)
	if entity.burner then
		if not entity.burner.fuel_categories then
			return { "chemical" }
		end

		if entity.burner.fuel_categories then
			return entity.burner.fuel_categories
		end
	end

	if entity.energy_source and entity.energy_source.type == 'burner' then
		if not entity.energy_source.fuel_categories then
			return { 'chemical' }
		end
		if entity.energy_source.fuel_categories then
			return entity.energy_source.fuel_categories
		end
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'get.fuel_categories()',
			'entity: "' .. tostring(entity.name) .. '" does not have a fuel_category'
		))
	end

	return nil
end

--- [add.fuel_category]
---@param entity any
---@param category data.FuelCategoryID
function apm.lib.utils.entity.add.fuel_category(entity, category)
	if apm.lib.utils.entity.has.fuel_category(entity, category) then
		return
	end

	if entity.burner then
		if not entity.burner.fuel_categories then
			entity.burner.fuel_categories = { 'chemical' }
		end

		if entity.burner.fuel_categories then
			table.insert(entity.burner.fuel_categories, category)

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add.fuel_category()',
					'added: "' .. tostring(category) .. '" to entity: "' .. tostring(entity.name) .. '"'
				))
			end
		end
	elseif entity.energy_source and entity.energy_source.type == 'burner' then
		if not entity.energy_source.fuel_categories then
			entity.energy_source.fuel_categories = { 'chemical' }
		end

		if entity.energy_source.fuel_categories then
			table.insert(entity.energy_source.fuel_categories, category)

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add.fuel_category()',
					'added: "' .. tostring(category) .. '" to entity: "' .. tostring(entity.name) .. '"'
				))
			end
		end
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'add.fuel_category()',
				'entity: "' .. tostring(entity.name) .. '" does not have a burner energy source'
			))
		end
	end
end

--- [entity.del.fuel_category]
---@param entity any
---@param category data.FuelCategoryID
function apm.lib.utils.entity.del.fuel_category(entity, category)
	if not apm.lib.utils.entity.has.fuel_category(entity, category) then
		return
	end

	local old = apm.lib.utils.entity.get.fuel_categories(entity)
	if not old then
		old = {}
	end

	---@type data.FuelCategoryID[]
	local fc = {}

	for _, candidate in ipairs(old) do
		if candidate ~= category then
			table.insert(fc, candidate)
		end
	end

	if entity.burner then
		if not entity.burner.fuel_categories then
			entity.burner.fuel_categories = fc
		end

		if entity.burner.fuel_categories then
			entity.burner.fuel_categories = fc

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'del.fuel_category()',
					'deleted: "' .. tostring(category) .. '" from entity: "' .. tostring(entity.name) .. '"'
				))
			end
		end
	elseif entity.energy_source and entity.energy_source.type == 'burner' then
		if not entity.energy_source.fuel_categories then
			entity.energy_source.fuel_categories = fc
		end

		if entity.energy_source.fuel_categories then
			entity.energy_source.fuel_categories = fc

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add.fuel_category()',
					'deleted: "' .. tostring(category) .. '" from entity: "' .. tostring(entity.name) .. '"'
				))
			end
		end
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'add.fuel_category()',
				'entity: "' .. tostring(entity.name) .. '" does not have a burner energy source'
			))
		end
	end
end

--- [check_if_an_entity_exists]
---@param next_upgrade string?
---@return boolean
local function check_if_an_entity_exists(next_upgrade)
	if not next_upgrade then
		return false
	end

	local prototypes = apm.lib.utils.entity.prototype_list()

	for _, prototype in pairs(prototypes) do
		local entity = data.raw[prototype][next_upgrade]

		if entity and entity.name == next_upgrade then
			return true
		end
	end

	return false
end

--- [entity.set.next_upgrade]
---@param entity any
---@param next_upgrade string?
function apm.lib.utils.entity.set.next_upgrade(entity, next_upgrade)
	if check_if_an_entity_exists(next_upgrade) then
		entity.next_upgrade = next_upgrade

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'next_upgrade()',
				'for entity: "' .. tostring(entity.name) .. '" set to entity: "' .. tostring(next_upgrade) .. '"'
			))
		end

		return
	end

	entity.next_upgrade = nil

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'next_upgrade()',
			'for entity: "' ..
			tostring(entity.name) .. '" but entity: "' .. tostring(next_upgrade) .. '" does not exist, set to "nil"'
		))
	end
end

--- [entity.set.fuel_category]
---@param entity any
---@param categories data.FuelCategoryID[]|string
function apm.lib.utils.entity.set.fuel_category(entity, categories)
	if entity.burner then
		entity.burner.fuel_categories = {}
	elseif entity.energy_source and entity.energy_source.type == 'burner' then
		entity.energy_source.fuel_categories = {}
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'set.fuel_category()',
				'entity: "' .. tostring(entity.name) .. '" its energy_source type does not have a fuel_category'
			))
		end

		return
	end

	if type(categories) == 'table' then
		for i = 1, #categories do
			apm.lib.utils.entity.add.fuel_category(entity, categories[i])
		end
	elseif type(categories) == 'string' then
		apm.lib.utils.entity.add.fuel_category(entity, categories)
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('set.fuel_category()', 'set fuel_categories for : "' .. tostring(entity.name) .. '"'))
		log(APM_MSG_WARNING(
			'set.fuel_category()',
			'Note: please be carfuel with this function, it can break compatibillity with other mods!'
		))
		log(APM_MSG_WARNING('set.fuel_category()', '---------------------------------'))
	end
end

--- [entity.has.crafting_category]
---@param entity any
---@param category data.RecipeCategoryID
---@return boolean
function apm.lib.utils.entity.has.crafting_category(entity, category)
	if not entity.crafting_categories then
		return false
	end

	---@type data.RecipeCategoryID[]
	local categories = entity.crafting_categories

	for _, c in pairs(categories) do
		if c == category then
			return true
		end
	end

	return false
end

--- [entity.add.crafting_category]
---@param entity any
---@param category data.RecipeCategoryID
function apm.lib.utils.entity.add.crafting_category(entity, category)
	if not apm.lib.utils.entity.has.crafting_category(entity, category) then
		table.insert(entity.crafting_categories, category)

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'add.crafting_category()',
				'added: "' .. tostring(category) .. '" to "' .. tostring(entity.name) .. '"'
			))
		end
	else
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'add.crafting_category()',
				'entity: "' .. tostring(entity.name) .. '" allready has crafting_categories: "' .. tostring(category) .. '"'
			))
		end
	end
end

--- [entity.has.flag]
---@param entity any
---@param flag string
---@return boolean
function apm.lib.utils.entity.has.flag(entity, flag)
	if type(entity.flags) == 'table' and entity.flags then
		---@type data.EntityPrototypeFlags
		local flags = entity.flags

		for i = 0, #flags do
			if flags[i] == flag then
				return true
			end
		end
	end

	return false
end

--- [entity.add.flag]
---@param entity any
---@param flag string
function apm.lib.utils.entity.add.flag(entity, flag)
	if type(entity.flags) == 'table' then
		if not apm.lib.utils.entity.has.flag(entity, flag) then
			table.insert(entity.flags, flag)

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add.flag()', 'added: "' .. tostring(flag) .. '" to "' .. tostring(entity.name) .. '"'
				))
			end
		else
			if APM_CAN_LOG_WARN then
				log(APM_MSG_WARNING(
					'add.flag()',
					'entity: "' .. tostring(entity.name) .. '" allready has flag: "' .. tostring(flag) .. '"'
				))
			end
		end
	else
		entity.flags = { flag }

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO('add.flag()', 'added: "' .. tostring(flag) .. '" to "' .. tostring(entity.name) .. '"'))
		end
	end
end
