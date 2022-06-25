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

constants.freeplay_crash_site_parts = {
  {
    name = "kr-crash-site-generator",
    angle_deviation = 0.2,
    max_distance = 25,
    min_separation = 10,
    fire_count = 3,
    explosion_count = 1,
    force = "player",
  },
  {
    name = "kr-crash-site-lab-repaired",
    angle_deviation = 0.05,
    max_distance = 30,
    min_separation = 10,
    fire_count = 3,
    explosion_count = 1,
    force = "player",
  },
  {
    name = "kr-crash-site-assembling-machine-1-repaired",
    repeat_count = 2,
    angle_deviation = 0.3,
    max_distance = 20,
    min_separation = 5,
    fire_count = 1,
    force = "player",
  },
  {
    name = "kr-crash-site-assembling-machine-2-repaired",
    repeat_count = 2,
    angle_deviation = 0.3,
    max_distance = 20,
    min_separation = 5,
    fire_count = 1,
    force = "player",
  },
  {
    name = "kr-crash-site-chest-1",
    repeat_count = 3,
    angle_deviation = 0.1,
    max_distance = 20,
    min_separation = 3,
    fire_count = 1,
  },
  {
    name = "kr-crash-site-chest-2",
    repeat_count = 3,
    angle_deviation = 0.1,
    max_distance = 20,
    min_separation = 2,
    fire_count = 1,
  },
  -- {
  --   name = "kr-mineable-wreckage",
  --   repeat_count = 9,
  --   angle_deviation = 0.8,
  --   max_distance = 10,
  -- },
}

return constants
