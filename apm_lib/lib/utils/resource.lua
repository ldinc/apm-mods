require 'util'
require('lib.log')

local self = 'lib.utils.resource'

if not apm.lib.utils.resource then apm.lib.utils.resource = {} end
if not apm.lib.utils.resource.get then apm.lib.utils.resource.get = {} end

--- [resource.exist]
---@param resource_name string
---@return boolean
function apm.lib.utils.resource.exist(resource_name)
	if data.raw.resource[resource_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'resource with name: "' .. tostring(resource_name) .. '" doesnt exist.'))
	end

	return false
end

--- [resource.get.by_name]
---@param resource_name string
---@return data.ResourceEntityPrototype
---@return boolean
function apm.lib.utils.resource.get.by_name(resource_name)
	local resource = data.raw.resource[resource_name]

	if resource then
		return resource, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'resource with name: "' .. tostring(resource_name) .. '" doesnt exist.'))
	end

	return {}, false
end

--- [resource.on_starting_zone]
---@param resource_name string
---@param value boolean?
function apm.lib.utils.resource.on_starting_zone(resource_name, value)
	local res, ok = apm.lib.utils.resource.get.by_name(resource_name)

	if not ok then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'on_starting_zone()', 'resource with name: "' .. tostring(resource_name) .. '" not found!'
			))
		end

		return
	end

	if res.autoplace then
		res.autoplace.default_enabled = value
	end

	local msg = '" added as starting resource point'

	if not value then
		msg = '" excluded as starting resource point'
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('on_starting_zone()', 'resource with name: "' .. tostring(resource_name) .. msg))
	end
end
