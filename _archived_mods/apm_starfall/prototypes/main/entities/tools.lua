require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/entities/tools.lua'

APM_LOG_HEADER(self)

data:extend(
{
    {
        type = "container",
        name = "apm_starfall_dummy_target",
        icons = {
            apm.lib.icons.dummy
        },
        icon_size = 32,
        flags = {"placeable-neutral", "player-creation", "not-on-map", "placeable-off-grid"},
        group = 'apm_starfall',
        subgroup = "apm_starfall_other",
        order = "aa_a",
        max_health = 1,
        inventory_size = 0,
        collision_box = {{0,0}, {0,0}},
        collision_mask = {},
        picture =
        {
            filename = apm.lib.icons.path.dummy,
            width = 32,
            height = 32,
            shift = {0, 0}
        }
    },
    {
        type = "smoke-with-trigger",
        name = "apm_starfall_target_explosion",
        flags = {"not-on-map"},
        show_when_smoke_off = true,
        animation =
        {
            layers =
            {
                {
                    width = 128,
                    height = 128,
                    flags = { "compressed" },
                    priority = "low",
                    frame_count = 2,
                    shift = {0, 0},
                    animation_speed = 0.1,
                    run_mode = 'forward-then-backward',
                    stripes =
                    {
                        {
                            filename = "__apm_resource_pack_ldinc__/graphics/entities/explosion/target_explosion.png",
                            width_in_frames = 2,
                            height_in_frames = 1,
                        },
                    }
                }
            }
        },
        wind_speed_factor = 0,
        slow_down_factor = 0,
        affected_by_wind = false,
        cyclic = true,
        duration = 60*10,
        fade_away_duration = 60*2,
        spread_duration = 60*2,
    }
})