require('lib.utils.data_util')

local blank_image = {
    filename = "__apm_bob_rework_resource_pack_ldinc__/graphics/blank.png",
    width = 1,
    height = 1,
    frame_count = 1,
    line_length = 1,
    shift = { 0, 0 },
    repeat_count = 32,
}

local name = 'wide-beacon'
local data_util = apm.bob_rework.lib.datautil

data:extend({
    {
        type = "beacon",
        name = name,
        icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/se/wide-beacon.png",
        icon_mipmaps = 1,
        icon_size = 64,
        flags = { "placeable-player", "player-creation" },
        minable = {
            mining_time = 0.25,
            result = name,
        },
        fast_replaceable_group = "beacon",
        se_allow_in_space = true,
        allowed_effects = { "consumption", "speed", "pollution" },
        animation = {
            layers = {
                data_util.auto_sr_hr({
                    animation_speed = 0.5,
                    filename = "__apm_bob_rework_resource_pack_ldinc__/graphics/entities/se/wide-beacon/hr/wide-beacon-2.png",
                    frame_count = 32,
                    width = 256,
                    height = 320,
                    line_length = 8,
                    shift = { 0, -0.5 },
                }),
                data_util.auto_sr_hr({
                    draw_as_shadow = true,
                    animation_speed = 0.5,
                    filename = "__apm_bob_rework_resource_pack_ldinc__/graphics/entities/se/wide-beacon/hr/wide-beacon-shadow.png",
                    frame_count = 32,
                    width = 330,
                    height = 174,
                    line_length = 4,
                    shift = { 0.5 + 4 / 32, 0.5 + 4 / 32 },
                }),
            }
        },
        animation_shadow = blank_image,
        base_picture = blank_image,
        collision_box = { { -1.7, -1.7 }, { 1.7, 1.7 } },
        allow_in_space = true,
        drawing_box = { { -2, -2.7 }, { 2, 2 } },
        selection_box = { { -2, -2 }, { 2, 2 } },
        corpse = "medium-remnants",
        damaged_trigger_effect = {
            entity_name = "spark-explosion",
            offset_deviation = { { -0.5, -0.5 }, { 0.5, 0.5 } },
            offsets = { { 0, 1 } },
            type = "create-entity"
        },
        dying_explosion = "beacon-explosion",
        energy_source = {
            type = "electric",
            usage_priority = "secondary-input"
        },
        energy_usage = "5MW",
        max_health = 800,
        module_specification = {
            module_info_icon_shift = { 0, 0.5 },
            module_info_max_icons_per_row = 5,
            module_info_max_icon_rows = 5,
            module_info_multi_row_initial_height_modifier = -0.3,
            module_slots = 3
        },
        distribution_effectivity = 0.5,
        supply_area_distance = 8, -- extends from edge of collision box, actual is 16
        radius_visualisation_picture = {
            filename = "__base__/graphics/entity/beacon/beacon-radius-visualization.png",
            height = 8,
            priority = "extra-high-no-scale",
            width = 8
        },
        vehicle_impact_sound = {
            {
                filename = "__base__/sound/car-metal-impact.ogg",
                volume = 0.5
            },
            {
                filename = "__base__/sound/car-metal-impact-2.ogg",
                volume = 0.5
            },
            {
                filename = "__base__/sound/car-metal-impact-3.ogg",
                volume = 0.5
            },
            {
                filename = "__base__/sound/car-metal-impact-4.ogg",
                volume = 0.5
            },
            {
                filename = "__base__/sound/car-metal-impact-5.ogg",
                volume = 0.5
            },
            {
                filename = "__base__/sound/car-metal-impact-6.ogg",
                volume = 0.5
            }
        },
        water_reflection = {
            orientation_to_variation = false,
            pictures = {
                filename = "__base__/graphics/entity/beacon/beacon-reflection.png",
                height = 28,
                priority = "extra-high",
                scale = 5,
                shift = {
                    0,
                    1.71875
                },
                variation_count = 1,
                width = 24
            },
            rotate = false
        }
    }
})
