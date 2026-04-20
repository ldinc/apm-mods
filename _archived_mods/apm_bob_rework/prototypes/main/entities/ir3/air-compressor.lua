require('prototypes/main/ir3-dir/dir.lua')

local name = 'ir3-air-compressor'

local airc = {
    name = name,
    type = "assembling-machine",
    show_recipe_icon = false,
    icon = DIR.get_icon_path(name),
    icon_size = DIR.icon_size,
    icon_mipmaps = DIR.icon_mipmaps,
    crafting_categories = {"venting"},
    placeable_by = {item = name, count = 1},
    minable = {
        mining_time = DIR.standard_pickup_time,
        result = name
    },
    fast_replaceable_group = "pipe",
    crafting_speed = DIR.get_standard_speed(1),
    energy_usage = DIR.get_scaled_energy_usage(0.5,0).active,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minute = DIR.standard_cleaning_emissions,
		drain = "0W",
    },
    max_health = 200,
    dying_explosion = "explosion",
    corpse = "small-remnants",
    flags = {"placeable-player", "placeable-neutral", "player-creation", "not-upgradable"},
    selection_box = { {-0.5,-0.5}, {0.5,0.5} },
    collision_box = { {-0.49,-0.49}, {0.49,0.49} },
    tile_width = 1,
    tile_height = 1,
    working_sound = {
        sound = {
            filename = DIR.sound_path.."/air-vent.ogg",
            volume = 1,
        },
        fade_in_ticks = 10,
        fade_out_ticks = 30,
    },
    mined_sound = {
        filename = DIR.core_sound_path.."/deconstruct-medium.ogg"
    },
    vehicle_impact_sound = DIR.vanilla_sounds.generic_impact,
    fluid_boxes = {
        {
            base_area = 10,
            base_level = 1,
            production_type = "output",
            pipe_covers = DIR.pipe_covers.iron,
            pipe_connections = {{ type="output", position = {0, -1} }},
            secondary_draw_orders = { north = -1 }
        },
        off_when_no_fluid_recipe = false
    },
    match_animation_speed_to_activity = false,
    animation = {
        north = {
            layers = {
                DIR.get_layer("air-compressor-base", nil, nil, false, 4, DIR.anim_speed, 64, 192, 0, 0, 64, 192, {0,0}),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, {0,-0.75}, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 0, 160, 96, {0.75,0.25}),
            }
        },
        east = {
            layers = {
                DIR.get_layer("air-compressor-base", nil, nil, false, 4, DIR.anim_speed, 64, 192, 64, 0, 64, 192, {-1,0}),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, {0,-0.75}, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 96, 160, 96, {0.75,0.25-1.5}),
            }
        },
        south = {
            layers = {
                DIR.get_layer("air-compressor-base", nil, nil, false, 4, DIR.anim_speed, 64, 192, 128, 0, 64, 192, {-2,0}),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, {0,-0.75}, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 192, 160, 96, {0.75,0.25-3}),
            }
        },
        west = {
            layers = {
                DIR.get_layer("air-compressor-base", nil, nil, false, 4, DIR.anim_speed, 64, 192, 192, 0, 64, 192, {-3,0}),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, {0,-0.75}, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 288, 160, 96, {0.75,0.25-4.5}),
            }
        },
    },
    status_colors = standard_status_colours(),
    working_visualisations = {
        {
            animation = DIR.get_layer("machines/fluids/air-compressor-status", 30, 6, "glow", nil, DIR.anim_speed, 64, 64, 0, 0, 64, 64, {0,-0.5}, "additive"),
            apply_tint = "status",
            always_draw = true,
        },
    },
    allowed_effects =  {"speed", "productivity", "consumption", "pollution"},
    module_specification = {
        module_slots = 1,
        module_info_icon_shift = {0, 0.5},
        module_info_multi_row_initial_height_modifier = -0.3
    }
}

data:extend({airc})