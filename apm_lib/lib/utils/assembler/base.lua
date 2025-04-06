require 'util'
require('lib.log')

if apm.lib.utils.assembler.get == nil then apm.lib.utils.assembler.get = {} end

---@param assembler_name string
---@return data.AssemblingMachinePrototype
---@return boolean
function apm.lib.utils.assembler.get.by_name(assembler_name)
	local assembler = data.raw["assembling-machine"][assembler_name]

	if assembler then
		return assembler, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING(
			'assembler "' .. assembler_name .. '" not found'
		))
	end

	return {}, false
end

---@param assembler_name string
---@return boolean
function apm.lib.utils.assembler.exist(assembler_name)
	if data.raw['assembling-machine'][assembler_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'assembler with name: "' .. tostring(assembler_name) .. '" doesnt exist.'))
	end

	return false
end