local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local soundPath = "__apm_bob_rework_ldinc__/sounds/krastorio/"
local iconPath = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/entities/"
local entityPath = "__apm_bob_rework_ldinc__/graphics/entities/krastorio/"

data:extend({
  {
    type = "radar",
    name = "kr-sentinel",
    icon = iconPath .. "sentinel.png",
    icon_size = 64,
    icon_mipmaps = 4,
    flags = { "placeable-player", "player-creation" },
    minable = { mining_time = 0.1, result = "kr-sentinel" },
    damaged_trigger_effect = hit_effects.entity(),
    max_health = 75,
    corpse = "small-remnants",
    resistances = {
      {
        type = "fire",
        percent = 50,
      },
      {
        type = "impact",
        percent = 10,
      },
    },
    collision_box = { { -0.25, -0.25 }, { 0.25, 0.25 } },
    selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
    energy_per_sector = "1YJ",
    energy_per_nearby_scan = "1J",
    max_distance_of_sector_revealed = 0,
    max_distance_of_nearby_sector_revealed = 1,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
    },
    energy_usage = "40kW",
    pictures = {
      layers = {
        {
          filename = entityPath .. "sentinel/sentinel.png",
          priority = "low",
          width = 64,
          height = 64,
          apply_projection = false,
          direction_count = 120,
          line_length = 12,
          shift = { 0.21, -0.2 },
          scale = 0.6,
          hr_version = {
            filename = entityPath .. "sentinel/hr-sentinel.png",
            priority = "low",
            width = 128,
            height = 128,
            apply_projection = false,
            direction_count = 120,
            line_length = 12,
            shift = { 0.21, -0.2 },
            scale = 0.35,
          },
        },
      },
    },
    vehicle_impact_sound = sounds.generic_impact,
    working_sound = {
      sound = { filename = soundPath .. "sentinel.ogg" },
      apparent_volume = 1,
    },
    radius_minimap_visualisation_color = { r = 0.059, g = 0.092, b = 0.235, a = 0.275 },
    rotation_speed = 0.0015,
  },
})
