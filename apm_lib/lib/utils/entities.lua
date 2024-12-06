require 'util'
require('lib.log')

local self = 'lib.utils.entities'

if apm.lib.utils.entities.has == nil then apm.lib.utils.entities.has = {} end
if apm.lib.utils.entities.add == nil then apm.lib.utils.entities.add = {} end
if apm.lib.utils.entities.set == nil then apm.lib.utils.entities.set = {} end

--- [entities.add.fuel_category_with_conditional]
---@param entity_type string
---@param conditional_category data.FuelCategoryID
---@param category data.FuelCategoryID
function apm.lib.utils.entities.add.fuel_category_with_conditional(entity_type, conditional_category, category)
	if not data.raw[entity_type] then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'set.fuel_category_with_conditional()',
				'entity type: "' .. tostring(entity_type) .. '" does not exist.'
			))
		end

		return
	end

	for _, entity in pairs(data.raw[entity_type]) do
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'set.fuel_category_with_conditional()',
				'for type: "' .. tostring(entity_type) .. '" entity: "' .. tostring(entity.name) .. '"'
			))
		end

		if apm.lib.utils.entity.has.fuel_category(entity, conditional_category) then
			apm.lib.utils.entity.add.fuel_category(entity, category)
		end
	end
end

--- [entities.set.fuel_categoriy_to_all_with_condition]
---@param entity_type string
---@param conditional_category data.FuelCategoryID
---@param categories data.FuelCategoryID
function apm.lib.utils.entities.set.fuel_categoriy_to_all_with_condition(entity_type, conditional_category, categories)
	if not data.raw[entity_type] then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'set.fuel_categoriy_to_all_with_condition()',
				'entity type: "' .. tostring(entity_type) .. '" does not exist.'
			))
		end

		return
	end

	for _, entity in pairs(data.raw[entity_type]) do
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'set.fuel_categoriy_to_all_with_condition()',
				'for type: "' .. tostring(entity_type) .. '" entity: "' .. tostring(entity.name) .. '"'
			))
		end

		if apm.lib.utils.entity.has.fuel_category(entity, conditional_category) then
			apm.lib.utils.entity.set.fuel_category(entity, categories)
		end
	end
end

--- [entities.set.fuel_categoriy_to_all]
---@param entity_type string
---@param categories data.FuelCategoryID[] | data.FuelCategoryID
function apm.lib.utils.entities.set.fuel_categoriy_to_all(entity_type, categories)
	if not data.raw[entity_type] then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'set.fuel_categoriy_to_all()',
				'entity type: "' .. tostring(entity_type) .. '" does not exist.'
			))
		end

		return
	end

	for _, entity in pairs(data.raw[entity_type]) do
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'set.fuel_categoriy_to_all()',
				'for type: "' .. tostring(entity_type) .. '" entity: "' .. tostring(entity.name) .. '"'
			))
		end

		apm.lib.utils.entity.set.fuel_category(entity, categories)
	end
end
