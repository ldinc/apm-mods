local graphics = require "lib.entities.graphics"
local base = graphics.enitity.pumpjack.burner.base

require('util')

local smoke_burner = {}
--local smoke_position = {-0.77, -1.95}
local smoke_position = { -0.70, -2.15 }
smoke_burner[1] = {}
smoke_burner[1].name = "apm_dark_smoke"
smoke_burner[1].deviation = { 0.1, 0.1 }
smoke_burner[1].frequency = 10
smoke_burner[1].position = nil
smoke_burner[1].north_position = smoke_position
smoke_burner[1].south_position = smoke_position
smoke_burner[1].east_position = smoke_position
smoke_burner[1].west_position = smoke_position
smoke_burner[1].starting_vertical_speed = 0.08
smoke_burner[1].starting_frame_deviation = 60
smoke_burner[1].slow_down_factor = 1

data:extend(
    {
        {
            type = "mining-drill",
            name = "burner-pumpjack",
            icon = graphics.enitity.pumpjack.burner.icon,
            icon_size = 64, icon_mipmaps = 4,
            flags = { "placeable-neutral", "player-creation" },
            minable = { mining_time = 0.5, result = "burner-pumpjack" },
            resource_categories = { "basic-fluid" },
            max_health = 200,
            corpse = "burner-pumpjack-remnants",
            dying_explosion = "pumpjack-explosion",
            collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
            selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
            drawing_box = { { -1.6, -2.5 }, { 1.5, 1.6 } },
            energy_source =
            {
                type = "burner",
                fuel_categories = { 'chemical', 'apm_refined_chemical' },
                effectivity = 1,
                fuel_inventory_size = 1,
                burnt_inventory_size = 1,
                emissions_per_minute = apm.power.constants.emissions.t0,
                smoke = smoke_burner,
            },
            output_fluid_box =
            {
                base_area = 10,
                base_level = 1,
                pipe_covers = pipecoverspictures(),
                pipe_connections =
                {
                    {
                        positions = { { 1, -2 }, { 2, -1 }, { -1, 2 }, { -2, 1 } },
                        type = "output"
                    }
                }
            },
            energy_usage = apm.power.constants.energy_usage.burner,
            mining_speed = 0.5,
            resource_searching_radius = 0.49,
            vector_to_place_result = { 0, 0 },
            module_specification =
            {
                module_slots = 0
            },
            radius_visualisation_picture =
            {
                filename = base .. "pumpjack-radius-visualization.png",
                width = 12,
                height = 12
            },
            monitor_visualization_tint = { r = 78, g = 173, b = 255 },
            base_render_layer = "lower-object-above-shadow",
            base_picture =
            {
                sheets =
                {
                    {
                        filename = base .. "pumpjack-base.png",
                        priority = "extra-high",
                        width = 131,
                        height = 137,
                        shift = util.by_pixel(-2.5, -4.5),
                        hr_version =
                        {
                            filename = base .. "hr-pumpjack-base.png",
                            priority = "extra-high",
                            width = 261,
                            height = 273,
                            shift = util.by_pixel(-2.25, -4.75),
                            scale = 0.5
                        }
                    },
                    {
                        filename = base .. "pumpjack-base-shadow.png",
                        priority = "extra-high",
                        width = 110,
                        height = 111,
                        draw_as_shadow = true,
                        shift = util.by_pixel(6, 0.5),
                        hr_version =
                        {
                            filename = base .. "hr-pumpjack-base-shadow.png",
                            width = 220,
                            height = 220,
                            scale = 0.5,
                            draw_as_shadow = true,
                            shift = util.by_pixel(6, 0.5)
                        }
                    }
                }
            },
            animations =
            {
                north =
                {
                    layers =
                    {
                        {
                            priority = "high",
                            filename = base .. "pumpjack-horsehead.png",
                            line_length = 8,
                            width = 104,
                            height = 102,
                            frame_count = 40,
                            shift = util.by_pixel(-4, -24),
                            animation_speed = 0.5,
                            hr_version =
                            {
                                priority = "high",
                                filename = base .. "hr-pumpjack-horsehead.png",
                                animation_speed = 0.5,
                                scale = 0.5,
                                line_length = 8,
                                width = 206,
                                height = 202,
                                frame_count = 40,
                                shift = util.by_pixel(-4, -24)
                            }
                        },
                        {
                            priority = "high",
                            filename = base .. "pumpjack-horsehead-shadow.png",
                            animation_speed = 0.5,
                            draw_as_shadow = true,
                            line_length = 8,
                            width = 155,
                            height = 41,
                            frame_count = 40,
                            shift = util.by_pixel(17.5, 14.5),
                            hr_version =
                            {
                                priority = "high",
                                filename = base .. "hr-pumpjack-horsehead-shadow.png",
                                animation_speed = 0.5,
                                draw_as_shadow = true,
                                line_length = 8,
                                width = 309,
                                height = 82,
                                frame_count = 40,
                                scale = 0.5,
                                shift = util.by_pixel(17.75, 14.5)
                            }
                        }
                    }
                }
            },
            open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
            close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
            vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
            working_sound = {
                sound = {
                    {filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
                    {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8},
                },
                idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
            },
            fast_replaceable_group = "pumpjack",
        }
    })

local make_rotated_animation_variations_from_sheet = function(variation_count, sheet) --makes remnants work with more than 1 variation
    local result = {}

    local function set_y_offset(variation, i)
        local frame_count = variation.frame_count or 1
        local line_length = variation.line_length or frame_count
        if (line_length < 1) then
            line_length = frame_count
        end

        local height_in_frames = math.floor((frame_count * variation.direction_count + line_length - 1) / line_length)
        -- if (height_in_frames ~= 1) then
        --   log("maybe broken sheet: h=" .. height_in_frames .. ", vc=" .. variation_count .. ", " .. variation.filename)
        -- end
        variation.y = variation.height * (i - 1) * height_in_frames
    end

    for i = 1, variation_count do
        local variation = util.table.deepcopy(sheet)

        if variation.layers then
            for _, layer in pairs(variation.layers) do
                set_y_offset(layer, i)
                if (layer.hr_version) then
                    set_y_offset(layer.hr_version, i)
                end
            end
        else
            set_y_offset(variation, i)
            if (variation.hr_version) then
                set_y_offset(variation.hr_version, i)
            end
        end

        table.insert(result, variation)
    end
    return result
end

data:extend(
    {{
    type = "corpse",
    name = "burner-pumpjack-remnants",
    icon = graphics.enitity.pumpjack.burner.icon,
    icon_size = 64, icon_mipmaps = 4,
    flags = { "placeable-neutral", "building-direction-8-way", "not-on-map" },
    subgroup = "extraction-machine-remnants",
    order = "a-d-a",
    selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = make_rotated_animation_variations_from_sheet(2,
        {
            filename = base.."remnants/pumpjack-remnants.png",
            line_length = 1,
            width = 138,
            height = 142,
            frame_count = 1,
            direction_count = 1,
            shift = util.by_pixel(0, 3),
            hr_version =
            {
                filename = base.."remnants/hr-pumpjack-remnants.png",
                line_length = 1,
                width = 274,
                height = 284,
                frame_count = 1,
                direction_count = 1,
                shift = util.by_pixel(0, 3.5),
                scale = 0.5
            }
        })
}})
