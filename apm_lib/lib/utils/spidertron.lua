require 'util'
require('lib.log')

if not apm.lib.utils.spidertron then apm.lib.utils.spidertron = {} end
if not apm.lib.utils.spidertron.get then apm.lib.utils.spidertron.get = {} end
if not apm.lib.utils.spidertron.add then apm.lib.utils.spidertron.add = {} end
if not apm.lib.utils.spidertron.set then apm.lib.utils.spidertron.set = {} end

---@param spidertron_name string
---@return boolean
function apm.lib.utils.spidertron.exist(spidertron_name)
	if data.raw["spider-vehicle"][spidertron_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'spidertron with name: "' .. tostring(spidertron_name) .. '" doesnt exist.'))
	end

	return false
end