require 'util'
require('lib.log')

if apm.lib.utils.assembler.get == nil then apm.lib.utils.assembler.get = {} end

--- Default circuit definition for assembling machine
---@return { [1]: data.CircuitConnectorDefinition, [2]: data.CircuitConnectorDefinition, [3]: data.CircuitConnectorDefinition, [4]: data.CircuitConnectorDefinition }
function apm.lib.utils.assembler.get.default_circuit_connector()
	if circuit_connector_definitions["assembling-machine"] then
		return circuit_connector_definitions["assembling-machine"]
	end

	return circuit_connector_definitions.create_vector
	(
		universal_connector_template,
		{
			{ variation = 18, main_offset = util.by_pixel(24, 25), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
			{ variation = 18, main_offset = util.by_pixel(24, 25), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
			{ variation = 18, main_offset = util.by_pixel(24, 25), shadow_offset = util.by_pixel(35, 31), show_shadow = true },
			{ variation = 18, main_offset = util.by_pixel(24, 25), shadow_offset = util.by_pixel(35, 31), show_shadow = true }
		}
	)
end


--- Default circuit wire max distance for assembling machine
---@return number
function apm.lib.utils.assembler.get.default_circuit_wire_max_distance()
	if assembling_machine_circuit_wire_max_distance then
		return assembling_machine_circuit_wire_max_distance
	end

  return 9
end