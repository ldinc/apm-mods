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

    local base = 'barrelling-machine-base'
    if base_suffix then
        base = base..'-'..base_suffix
    end

    -- override animation
    entity.animation = {
        north = {
            layers = {
                DIR.get_layer(base, nil, nil, false, nil, DIR.anim_speed, 64, 128, 0, 0, 64, 128, { 0, 0 }),
                DIR.get_layer("barrelling-machine-shadow", nil, nil, true, nil, nil, 192, 128, 0, 0, 192, 128, {1,0}),
            }
        },
        east = {
            layers = {
                DIR.get_layer(base, nil, nil, false, nil, nil, 64, 128, 64, 0, 64, 128, {-1,0}),
				DIR.get_layer("barrelling-machine-shadow", nil, nil, true, nil, nil, 192, 128, 0, 128, 192, 128, {1,-2}),
            }
        },
        south = {
            layers = {
                DIR.get_layer(base, nil, nil, false, nil, nil, 64, 128, 128, 0, 64, 128, {-2,0}),
				DIR.get_layer("barrelling-machine-shadow", nil, nil, true, nil, nil, 192, 128, 0, 256, 192, 128, {1,-4}),
            }
        },
        west = {
            layers = {
                DIR.get_layer(base, nil, nil, false, nil, nil, 64, 128, 192, 0, 64, 128, {-3,0}),
				DIR.get_layer("barrelling-machine-shadow", nil, nil, true, nil, nil, 192, 128, 0, 384, 192, 128, {1,-6}),
            }
        },
    }

    -- override working animation
    entity.working_visualisations = {
        {
			animation = DIR.get_layer("barrelling-machine-barrel", nil, nil, false, nil, nil, 64, 128, 0, 0, 64, 128, {0,0}),
			apply_recipe_tint = "primary",
			fadeout = true,
		},
		{
			animation = DIR.get_layer("barrelling-machine-barrel-shadow", nil, nil, true, nil, nil, 192, 128, 0, 0, 192, 128, {1,0}),
			apply_recipe_tint = "primary",
			fadeout = true,
		},
		-- canister body
		{
			animation = DIR.get_layer("barrelling-machine-canister", nil, nil, false, nil, nil, 64, 128, 0, 0, 64, 128, {0,0}),
			apply_recipe_tint = "secondary",
			fadeout = true,
		},
		{
			animation = DIR.get_layer("barrelling-machine-canister-shadow", nil, nil, true, nil, nil, 192, 128, 0, 0, 192, 128, {1,0}),
			apply_recipe_tint = "secondary",
			fadeout = true,
		},
		-- status
		{
			animation = DIR.get_layer("barrelling-machine-status", 30, 6, "glow", nil, DIR.anim_speed, 64, 64, 0, 0, 64, 64, {0,0}, "additive", nil, nil, nil, nil, direction),
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
local ir3_barreling = function()
    local type = 'assembling-machine'
    change(chemistry.pump.basic, type)
    change(chemistry.pump.advance, type)

    local compressor2 = data.raw[type][chemistry.pump.advance]
    compressor2.next_upgrade = nil
end

apm.bob_rework.lib.override.ir3_barreling = ir3_barreling
