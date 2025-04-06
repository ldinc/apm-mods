require 'util'
require('lib.log')

local self = 'lib.utils.fluid'

--- [fluid.exist]
---@param fluid_name string
---@return data.FluidPrototype
---@return boolean
function apm.lib.utils.fluid.get_by_name(fluid_name)
	local fluid =  data.raw.fluid[fluid_name]
	
	if fluid then
		return fluid, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'fluid with name: "' .. tostring(fluid_name) .. '" doesnt exist.'))
	end

	return {}, false
end

--- [fluid.remove]
---@param fluid_name string
function apm.lib.utils.fluid.remove(fluid_name)
	local fluid, ok = apm.lib.utils.fluid.get_by_name(fluid_name)

	if not ok then
		return
	end

	--fluid.flags = {'hidden', 'hide-from-bonus-gui', 'hide-from-fuel-tooltip'}
	fluid.hidden = true
	fluid.hidden_in_factoriopedia = true

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('remove()', 'fluid with name: "' .. tostring(fluid_name) .. '" set flag "hidden".'))
	end
end

--- [fluid.delete_hard]
---@param fluid_name any
function apm.lib.utils.fluid.delete_hard(fluid_name)
	local _, ok = apm.lib.utils.fluid.get_by_name(fluid_name)

	if not ok then
		return
	end

	data.raw.fluid[fluid_name] = nil

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('delete_hard()', 'fluid with name: "' .. tostring(fluid_name) .. '" deleted hard (set to nil)'))
	end
end
