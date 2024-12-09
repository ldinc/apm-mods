if not apm.lib.utils.technology then apm.lib.utils.technology = {} end
if not apm.lib.utils.technology.get then apm.lib.utils.technology.get = {} end

--- [technology.exist]
---@param technology_name string
---@return boolean
function apm.lib.utils.technology.exist(technology_name)
	if data.raw.technology[technology_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('Warning: technology with name: "' .. tostring(technology_name) .. '" dosent exist.'))
	end

	return false
end

--- [technology.get.by_name]
---@param technology_name string
---@return data.TechnologyPrototype
---@return boolean
function apm.lib.utils.technology.get.by_name(technology_name)
	local technology = data.raw.technology[technology_name]

	if technology then
		return technology, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('Warning: technology with name: "' .. tostring(technology_name) .. '" dosent exist.'))
	end


	return {}, false
end
