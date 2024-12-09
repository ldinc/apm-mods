require 'util'
require('lib.log')

local self = 'lib.utils.storage_tank'

if apm.lib.utils.storage_tank.set == nil then apm.lib.utils.storage_tank.set = {} end

--- [storage_tank.exist]
---@param storage_tank_name string
---@return boolean
function apm.lib.utils.storage_tank.exist(storage_tank_name)
	if data.raw['storage-tank'][storage_tank_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'storage-tank with name: "' .. tostring(storage_tank_name) .. '" dosent exist.'))
	end

	return false
end

--- [storage_tank.set.hidden]
--- @param storage_tank_name string
function apm.lib.utils.storage_tank.set.hidden(storage_tank_name)
	if not apm.lib.utils.assembler.exist(storage_tank_name) then
		return
	end

	local storage_tank = data.raw['storage-tank'][storage_tank_name]

	storage_tank.hidden = true
	storage_tank.hidden_in_factoriopedia = true
end
