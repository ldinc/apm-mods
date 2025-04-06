require 'util'
require('lib.log')

local self = 'lib.utils.autoplace_controls'

if not apm.lib.utils.autoplace_controls.add then apm.lib.utils.autoplace_controls.add = {} end
if not apm.lib.utils.autoplace_controls.table then apm.lib.utils.autoplace_controls.table = {} end

--- [autoplace_controls.add.ore]
---@param ore_name string
---@param frequency data.MapGenSize
---@param size data.MapGenSize
---@param richness data.MapGenSize
function apm.lib.utils.autoplace_controls.add.ore(ore_name, frequency, size, richness)
	if not data.raw.resource[ore_name] then
		APM_LOG_WARN(self, 'add.ore()', 'resource with name: "' .. tostring(ore_name) .. '" doesnt exist.')
		return
	end

	---@type data.FrequencySizeRichness
	local value = {
		frequency = frequency,
		size = size,
		richness = richness,
	}

	apm.lib.utils.autoplace_controls.table[ore_name] = value

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('add.ore()', 'resource with name: "' .. tostring(ore_name) .. '" added.'))
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.autoplace_controls.get()
	return apm.lib.utils.autoplace_controls.table
end
