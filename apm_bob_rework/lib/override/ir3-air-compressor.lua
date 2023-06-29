if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local chemistry = require('lib.entities.buildings.chemistry')
local DIR = require('prototypes.main.ir3-dir.dir')

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
-- pipe_covers.east = empty
-- pipe_covers.west = empty


local change = function(target, type, base_suffix)
    local entity = data.raw[type][target]

    -- setup 1x1 dimension
    entity.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }
    entity.drawing_box = { { -0.5, -1.5 }, { 0.5, 0.5 } }
    entity.collision_box = { { -0.49, -0.49 }, { 0.49, 0.49 } }

    local base = 'air-compressor-base'
    if base_suffix then
        base = base..'-'..base_suffix
    end

    -- override animation
    entity.animation = {
        north = {
            layers = {
                DIR.get_layer(base, nil, nil, false, 4, DIR.anim_speed, 64, 192, 0, 0, 64, 192, { 0, 0 }),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, { 0,
                    -0.75 }, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 0, 160, 96,
                    { 0.75, 0.25 }),
            }
        },
        east = {
            layers = {
                DIR.get_layer(base, nil, nil, false, 4, DIR.anim_speed, 64, 192, 64, 0, 64, 192, { -1, 0 }),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, { 0,
                    -0.75 }, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 96, 160, 96,
                    { 0.75, 0.25 - 1.5 }),
            }
        },
        south = {
            layers = {
                DIR.get_layer(base, nil, nil, false, 4, DIR.anim_speed, 64, 192, 128, 0, 64, 192, { -2,
                    0 }),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, { 0,
                    -0.75 }, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 192, 160, 96,
                    { 0.75, 0.25 - 3 }),
            }
        },
        west = {
            layers = {
                DIR.get_layer(base, nil, nil, false, 4, DIR.anim_speed, 64, 192, 192, 0, 64, 192, { -3,
                    0 }),
                DIR.get_layer("air-compressor-working", 4, 1, false, nil, DIR.anim_speed, 64, 32, 0, 0, 64, 32, { 0,
                    -0.75 }, nil, nil, nil, nil, nil, "backward"),
                DIR.get_layer("air-compressor-shadow", nil, nil, true, 4, DIR.anim_speed, 160, 96, 0, 288, 160, 96,
                    { 0.75, 0.25 - 4.5 }),
            }
        },
    }

    -- override working animation
    entity.working_visualisations = { {
        animation = DIR.get_layer("air-compressor-status", 30, 6, "glow", nil, DIR.anim_speed, 64, 64, 0, 0, 64, 64,
            { 0, -0.5 }, "additive"),
        apply_tint = "status",
        always_draw = true,
    },
    }

    -- fix pipes connection
    entity.fluid_boxes = {
        {
            base_area = 10,
            base_level = 1,
            production_type = "output",
            pipe_covers = pipe_covers,
            pipe_connections = { { type = "output", position = { 0, -1 } } },
            secondary_draw_orders = { north = -1 }
        },
        off_when_no_fluid_recipe = false
    }
end

-- change skin and dimension for bob air compressor's to ir3
local ir3_air_compressor = function()
    local type = 'assembling-machine'
    change(chemistry.compressor.basic, type, 'yellow')
    change(chemistry.compressor.advance, type)

    local compressor2 = data.raw[type][chemistry.compressor.advance]
    compressor2.next_upgrade = nil
end

apm.bob_rework.lib.override.ir3_air_compressor = ir3_air_compressor
