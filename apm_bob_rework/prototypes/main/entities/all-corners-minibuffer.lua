require('util')
require('__apm_lib_ldinc__.lib.log')
local graphics = require('lib.entities.graphics')

local sprites = graphics.enitity.minibuffer.allcorners

local empty = {
    filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1
}

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()

local tank = {}
tank.type = "storage-tank"
tank.name = "minibuffer-allcorners"
tank.icons = {sprites.icon}
tank.localised_description = { "entity-description.minibuffer-allcorners" }
--sinkhole.icon_size = 32
tank.flags = { "placeable-neutral", "placeable-player", "player-creation" }
tank.minable = { mining_time = 0.2, result = "minibuffer-allcorners" }
tank.max_health = 400
tank.corpse = "small-remnants"
tank.dying_explosion = "medium-explosion"
tank.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
tank.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
tank.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
tank.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
tank.vehicle_impact_sound = { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 }
tank.source_inventory_size = 0
tank.result_inventory_size = 0
tank.next_upgrade = nil

tank.fast_replaceable_group = "pipe"
tank.resistances = { { type = "fire", percent = 95 } }

tank.collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } }
tank.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

local pic = {
    layers = {
        {
            filename = sprites.base.lr,
            priority = "high",
            width = 144,
            height = 128,
            scale = 0.2,
            shift = {0.71875, -0.1875},
            hr_version = {
                filename = sprites.base.hr,
                priority = "high",
                width = 576,
                height = 512,
                scale = 0.2,
                shift = {0.71875, -0.1875},
            },
        },
        {
            filename = sprites.shadow.lr,
            priority = "high",
            width = 144,
            height = 128,
            scale = 0.2,
            shift = {0.71875, -0.1875},
            draw_as_shadow = true,
            hr_version = {
                filename = sprites.shadow.hr,
                priority = "high",
                width = 576,
                height = 512,
                scale = 0.2,
                shift = {0.71875, -0.1875},
                draw_as_shadow = true,
            },
        },
    },
}

tank.pictures = {
    fluid_background  = empty,
    window_background = empty,
    flow_sprite = empty,
    gas_flow = empty,

    picture = {
        north = pic,
        east = pic,
        south = pic,
        west = pic,
    }
}


local base_area = 30

tank.two_direction_only = false
tank.fluid_box = {}
-- tank.fluid_box.production_type = "input"
-- sinkhole.fluid_boxes[1].pipe_picture = pipe_picture
tank.fluid_box.pipe_covers = pipe_covers
tank.fluid_box.base_area = base_area
tank.fluid_box.base_level = 0
tank.fluid_box.filter = ""
tank.fluid_box.pipe_connections = {
    {
        type = "input-output",
        position = { 0, 1 }
    },
    {
        type = "input-output",
        position = {0, -1},
    },
    {
        type = "input-output",
        position = { 1, 0 }
    },
    {
        type = "input-output",
        position = {-1, 0},
    }
}
tank.fluid_box.secondary_draw_orders = { north = -1, south = 1, west = -1, east = 1 }

tank.window_bounding_box = {util.by_pixel(-3, -5), util.by_pixel(3, 11)}

tank.flow_length_in_ticks = 360

circuit_connector_definitions["minibuffer-allcorners"] = circuit_connector_definitions.create
(
  universal_connector_template,
  {
    { variation = 27, main_offset = util.by_pixel(10, -18), shadow_offset = util.by_pixel(6, -16), show_shadow = false },
    { variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false },
    { variation = 27, main_offset = util.by_pixel(10, -18), shadow_offset = util.by_pixel(6, -16), show_shadow = false },
    { variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false }
  }
)

tank.circuit_wire_connection_points = circuit_connector_definitions[tank.name].points
tank.circuit_connector_sprites = circuit_connector_definitions[tank.name].sprites
tank.circuit_wire_max_distance = default_circuit_wire_max_distance

data:extend({ tank })