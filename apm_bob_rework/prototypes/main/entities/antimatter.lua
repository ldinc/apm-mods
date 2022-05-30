-- local util = require("scripts.util")

local hit_effects = require("__base__/prototypes/entity/hit-effects")
local sounds = require("__base__/prototypes/entity/sounds")

local soundPath = "__apm_bob_rework_ldinc__/sounds/krastorio/"
local iconPath = "__apm_bob_rework_ldinc__/graphics/icons/krastorio/entities/"
local entityPath = "__apm_bob_rework_ldinc__/graphics/entities/krastorio/"

local kr_explosions_sprites_path = entityPath .. "explosions/"


data:extend({
    {
        type = "corpse",
        name = "kr-antimatter-reactor-remnant",
        localised_name = { "remnant-name", { "entity-name.kr-antimatter-reactor" } },
        icon = iconPath .. "antimatter-reactor.png",
        icon_size = 128,
        flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
        selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
        tile_width = 9,
        tile_height = 9,
        selectable_in_game = false,
        subgroup = "remnants",
        order = "z[remnants]-a[generic]-b[medium]",
        time_before_removed = 60 * 60 * 20, -- 20 minutes
        final_render_layer = "remnants",
        remove_on_tile_placement = false,
        animation = make_rotated_animation_variations_from_sheet(1, {
            filename = entityPath .. "antimatter-reactor/antimatter-reactor-remnant.png",
            line_length = 1,
            width = 300,
            height = 300,
            frame_count = 1,
            direction_count = 1,
            scale = 1.1,
            hr_version = {
                filename = entityPath .. "antimatter-reactor/hr-antimatter-reactor-remnant.png",
                line_length = 1,
                width = 600,
                height = 600,
                frame_count = 1,
                direction_count = 1,
                scale = 0.55,
            },
        }),
    },
})


data:extend({
    {
        type = "explosion",
        name = "matter-explosion-s",
        flags = { "not-on-map" },
        animations = {
            width = 316,
            height = 360,
            frame_count = 100,
            priority = "very-low",
            flags = { "linear-magnification" },
            shift = util.by_pixel(1, -123), --shift = util.by_pixel(1, -63), shifted by 60 due to scaling and centering
            draw_as_glow = true,
            animation_speed = 0.5 * 0.75,
            scale = 2,
            dice_y = 5,
            stripes = {
                {
                    filename = kr_explosions_sprites_path .. "matter-explosion-1.png",
                    width_in_frames = 5,
                    height_in_frames = 5,
                },
                {
                    filename = kr_explosions_sprites_path .. "matter-explosion-2.png",
                    width_in_frames = 5,
                    height_in_frames = 5,
                },
                {
                    filename = kr_explosions_sprites_path .. "matter-explosion-3.png",
                    width_in_frames = 5,
                    height_in_frames = 5,
                },
                {
                    filename = kr_explosions_sprites_path .. "matter-explosion-4.png",
                    width_in_frames = 5,
                    height_in_frames = 5,
                },
            },
            hr_version = {
                width = 628,
                height = 720,
                frame_count = 100,
                priority = "very-low",
                flags = { "linear-magnification" },
                shift = util.by_pixel(0.5, -122.5), --shift = util.by_pixel(0.5, -62.5), shifted by 60 due to scaling and centering
                draw_as_glow = true,
                animation_speed = 0.5 * 0.75,
                scale = 1,
                dice_y = 5,
                stripes = {
                    {
                        filename = kr_explosions_sprites_path .. "hr-matter-explosion-1.png",
                        width_in_frames = 5,
                        height_in_frames = 5,
                    },
                    {
                        filename = kr_explosions_sprites_path .. "hr-matter-explosion-2.png",
                        width_in_frames = 5,
                        height_in_frames = 5,
                    },
                    {
                        filename = kr_explosions_sprites_path .. "hr-matter-explosion-3.png",
                        width_in_frames = 5,
                        height_in_frames = 5,
                    },
                    {
                        filename = kr_explosions_sprites_path .. "hr-matter-explosion-4.png",
                        width_in_frames = 5,
                        height_in_frames = 5,
                    },
                },
            },
        },
        sound = {
            aggregation = {
                max_count = 1,
                remove = true,
            },
            variations = {
                {
                    filename = "__base__/sound/fight/large-explosion-1.ogg",
                    volume = 1.0,
                },
                {
                    filename = "__base__/sound/fight/large-explosion-2.ogg",
                    volume = 1.0,
                },
            },
        },
        created_effect = {
            type = "direct",
            action_delivery = {
                type = "instant",
                target_effects = {
                    {
                        type = "create-particle",
                        repeat_count = 5,
                        particle_name = "explosion-remnants-particle",
                        initial_height = 0.5,
                        speed_from_center = 0.08,
                        speed_from_center_deviation = 0.15,
                        initial_vertical_speed = 0.08,
                        initial_vertical_speed_deviation = 0.15,
                        offset_deviation = { { -0.2, -0.2 }, { 0.2, 0.2 } },
                    },
                },
            },
        },
    }
})

data:extend({
    {
        type = "burner-generator",
        name = "kr-antimatter-reactor",
        icon = iconPath .. "antimatter-reactor.png",
        icon_size = 128,
        icon_mipmaps = 4,
        flags = { "placeable-neutral", "placeable-player", "player-creation", "not-rotatable" },
        minable = { mining_time = 2, result = "kr-antimatter-reactor" },
        max_health = 5000,
        damaged_trigger_effect = hit_effects.entity(),
        corpse = "kr-antimatter-reactor-remnant",
        dying_explosion = "matter-explosion-s",
        effectivity = 5,
        resistances = {
            { type = "physical", percent = 60 },
            { type = "fire", percent = 90 },
            { type = "impact", percent = 90 },
        },
        collision_box = { { -4.75, -4.75 }, { 4.75, 4.75 } },
        selection_box = { { -4.95, -4.95 }, { 4.95, 4.95 } },
        fluid_box = {
            production_type = "input",
            base_area = 1,
            base_level = -1,
            pipe_connections = { { type = "input", position = { 5, 0 } } },
        },
        energy_source = {
            type = "electric",
            render_no_power_icon = false,
            usage_priority = "secondary-output",
        },
        burner = {
            type = "burner",
            fuel_category = "chemical",  --- change
            fuel_inventory_size = 1,
            burnt_inventory_size = 1,
            effectivity = 1,
            emissions_per_minute = 200,
            light_flicker = {
                minimum_intensity = 0.01,
                maximum_intensity = 0.50,
                derivation_change_frequency = 0.02,
                derivation_change_deviation = 0.02,
                minimum_light_size = 1,
                color = { r = 0.459, g = 0.031, b = 0.447 },
            },
        },
        vehicle_impact_sound = sounds.generic_impact,
        animation = {
            layers = {
                {
                    filename = entityPath .. "antimatter-reactor/antimatter-reactor-light.png",
                    priority = "high",
                    width = 330,
                    height = 353,
                    shift = { 0, -0.5 },
                    frame_count = 1,
                    repeat_count = 30,
                    animation_speed = 0.9,
                    scale = 0.96,
                    draw_as_light = true,
                    blend_mode = "additive",
                    hr_version = {
                        filename = entityPath .. "antimatter-reactor/hr-antimatter-reactor-light.png",
                        priority = "high",
                        width = 660,
                        height = 706,
                        shift = { 0, -0.5 },
                        frame_count = 1,
                        repeat_count = 30,
                        animation_speed = 0.9,
                        scale = 0.48,
                        draw_as_light = true,
                        blend_mode = "additive",
                    },
                },
                {
                    filename = entityPath .. "antimatter-reactor/antimatter-reactor-glow.png",
                    priority = "high",
                    width = 330,
                    height = 353,
                    shift = { 0, -0.5 },
                    frame_count = 1,
                    repeat_count = 30,
                    animation_speed = 0.9,
                    scale = 0.96,
                    blend_mode = "additive-soft",
                    draw_as_glow = true,
                    fadeout = true,
                    hr_version = {
                        filename = entityPath .. "antimatter-reactor/hr-antimatter-reactor-glow.png",
                        priority = "high",
                        width = 660,
                        height = 706,
                        shift = { 0, -0.5 },
                        frame_count = 1,
                        repeat_count = 30,
                        animation_speed = 0.9,
                        scale = 0.48,
                        blend_mode = "additive-soft",
                        draw_as_glow = true,
                        fadeout = true,
                    },
                },
                {
                    filename = entityPath .. "antimatter-reactor/antimatter-reactor.png",
                    priority = "high",
                    width = 330,
                    height = 353,
                    shift = { 0, -0.5 },
                    frame_count = 30,
                    line_length = 6,
                    animation_speed = 0.9,
                    scale = 0.96,
                    hr_version = {
                        filename = entityPath .. "antimatter-reactor/hr-antimatter-reactor.png",
                        priority = "high",
                        width = 660,
                        height = 706,
                        shift = { 0, -0.5 },
                        frame_count = 30,
                        line_length = 6,
                        animation_speed = 0.9,
                        scale = 0.48,
                    },
                },
                {
                    filename = entityPath .. "antimatter-reactor/antimatter-reactor-sh.png",
                    width = 362,
                    height = 315,
                    shift = { 0.57, 0.27 },
                    frame_count = 1,
                    repeat_count = 30,
                    animation_speed = 0.9,
                    scale = 0.96,
                    draw_as_shadow = true,
                    hr_version = {
                        filename = entityPath .. "antimatter-reactor/hr-antimatter-reactor-sh.png",
                        width = 724,
                        height = 630,
                        shift = { 0.57, 0.27 },
                        frame_count = 1,
                        repeat_count = 30,
                        animation_speed = 0.9,
                        scale = 0.48,
                        draw_as_shadow = true,
                    },
                },
            },
        },
        working_sound = {
            sound = {
                {
                    filename = soundPath .. "antimatter-reactor.ogg",
                    volume = 1.25,
                },
            },
        },
        open_sound = { filename = soundPath .. "open.ogg", volume = 1 },
        close_sound = { filename = soundPath .. "close.ogg", volume = 1 },
        audible_distance_modifier = 10,
        min_perceived_performance = 0.25,
        performance_to_sound_speedup = 0.5,
        max_power_output = "3000MW",
    },
})