require 'util'
require('lib.log')

local self = 'lib.utils.modules'

if apm.lib.utils.modules.create == nil then apm.lib.utils.modules.create = {} end
if apm.lib.utils.modules.get == nil then apm.lib.utils.modules.get = {} end

--- [modules.exist]
---@param module_name string
---@return boolean
function apm.lib.utils.modules.exist(module_name)
	if data.raw.module[module_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'module: "' .. tostring(module_name) .. '" dosent exist.'))
	end

	return false
end

--- [modules.get.by_name]
---@param module_name string
---@return data.ModulePrototype
---@return boolean
function apm.lib.utils.modules.get.by_name(module_name)
	local module = data.raw.module[module_name]

	if module then
		return module, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'module: "' .. tostring(module_name) .. '" dosent exist.'))
	end

	return {}, false
end

--- [modules.has_productivity]
---@param module_name string
---@return boolean
function apm.lib.utils.modules.has_productivity(module_name)
	local p_module, ok = apm.lib.utils.modules.get.by_name(module_name)

	if not ok then
		return false
	end

	return apm.lib.utils.modules.has_productivity_ref(p_module)
end

--- Check if moduele has productivity effect
---@param module data.ModulePrototype
---@return boolean
function apm.lib.utils.modules.has_productivity_ref(module)
	if not module then
		return false
	end

	if module.effect then
		if module.effect.productivity then
			return true
		end
	end

	return false
end

--- [modules.create.category]
---@param category_name string
function apm.lib.utils.modules.create.category(category_name)
	---@type data.ModuleCategory
	local module_category = {
		type = "module-category",
		name = category_name,
	}

	data:extend({ module_category })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('create.category()', 'created category with name: "' .. tostring(category_name) .. '"'))
	end
end
