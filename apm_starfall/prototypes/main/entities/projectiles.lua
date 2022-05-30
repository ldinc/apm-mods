require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/entities/projectiles.lua'

APM_LOG_HEADER(self)

data:extend(
{
  {
    type = "projectile",
    name = "apm_meteorite_impact",
    flags = {"not-on-map"},
    acceleration = 0.005,
    action =
    {
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
            type = "create-entity",
            entity_name = "apm_meteorite_crater"
            },          
          }
        }
      },
      {
        type = "area",
        --perimeter = 4.5,
        radius = 10.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "damage",
              damage = {amount = 100, type = "explosion"}
            },
            --[[
            {
              type = "create-fire",
              initial_ground_flame_count = 5
            },
            ]]--
          }
        }
      },
      --[[
      {
        type = "area",
        --perimeter = 4.5,
        radius = 8.5,
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              initial_ground_flame_count = 10
            },
          }
        }
      }
      ]]--
    },
    light = {intensity = 1, size = 4},
    animation =
    {
      filename = "__base__/graphics/entity/grenade/grenade.png",
      frame_count = 1,
      width = 24,
      height = 24,
      priority = "high"
    },
    shadow =
    {
      filename = "__base__/graphics/entity/grenade/grenade-shadow.png",
      frame_count = 1,
      width = 24,
      height = 24,
      priority = "high"
    }
  },
})
