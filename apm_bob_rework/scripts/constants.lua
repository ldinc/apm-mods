local math = require("__flib__.math")

local constants = {}

constants.tesla_coil = {
  charging_rate = 3000000, -- 3 MW
  cooldown = 10,
  input_flow_limit = 18000000, -- 8 MW
  loss_multiplier = 1.8,
  range = 20,
  required_energy = 10000000, -- 10 MW
  simultaneous_allowed = 4,
}

return constants