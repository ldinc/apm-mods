require("util")
require("lib.log")

local self = "apm_lib/prototypes/custom-inputs.lua"

APM_LOG_HEADER(self)

---@type data.CustomInputPrototype
local apm_equipment_manager = {
	type = "custom-input",
	name = "apm_input_equipment_manager",
	key_sequence = "ALT + W",
}

data:extend({ apm_equipment_manager })
