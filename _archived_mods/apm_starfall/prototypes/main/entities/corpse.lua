require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/entities/corpse.lua'

APM_LOG_HEADER(self)

data:extend(
{
    {
        type = "corpse",
        name = "apm_meteorite_crater",
        icon = "__base__/graphics/icons/small-scorchmark.png",
        icon_size = 32,
        flags = {"placeable-neutral", "not-on-map", "placeable-off-grid"},
        collision_box = {{-1.5, -1.5}, {1.5, 1.5}},
        collision_mask = {"doodad-layer", "not-colliding-with-itself"},
        selection_box = {{-1, -1}, {1, 1}},
        selectable_in_game = false,
        time_before_removed = 60 * 60 * 5, -- 10 minutes
        final_render_layer = "ground-patch-higher2",
        subgroup = "remnants",
        order="d[remnants]-b[scorchmark]-a[big]",
        animation =
        {
            width = 110,
            height = 90,
            frame_count = 1,
            direction_count = 1,
            filename = "__apm_resource_pack_ldinc__/graphics/corpse/apm_meteorite_crater.png",
            scale = 2,
            variation_count = 3
        },
        ground_patch =
        {
            sheet =
            {
                width = 110,
                height = 90,
                frame_count = 1,
                direction_count = 1,
                x = 110 * 2,
                filename = "__apm_resource_pack_ldinc__/graphics/corpse/apm_meteorite_crater.png",
                scale = 2,
                variation_count = 3
            }
        },
        ground_patch_higher =
        {
            sheet =
            {
                width = 110,
                height = 90,
                frame_count = 1,
                direction_count = 1,
                x = 110,
                filename = "__apm_resource_pack_ldinc__/graphics/corpse/apm_meteorite_crater.png",
                scale = 2,
                variation_count = 3
            }
        }
    }
})