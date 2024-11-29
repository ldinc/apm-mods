require 'util'
require('lib.log')

local self = 'lib.utils.turret'

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.turret.exist(turret_name)
	if data.raw['ammo-turret'][turret_name] ~= nil then 
		return true
	end
	APM_LOG_WARN(self, 'exist()', 'turret with name: "' .. tostring(turret_name) .. '" dosent exist.')
	return false
end