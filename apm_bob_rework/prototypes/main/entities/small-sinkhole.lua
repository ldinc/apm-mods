require('util')
require('__apm_lib_ldinc__.lib.log')
local pipes = require('lib.entities.pipes')

local ppPath = "__apm_bob_rework_resource_pack_ldinc__/graphics/entities/small-sinkhole/"
local base = 'small-'
local ext = '.png'

local empty = {
    filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1
}

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
pipe_covers.east = empty
pipe_covers.west = empty

local sinkhole = {}
sinkhole.type = "furnace"
sinkhole.name = pipes.sinkhole.small
sinkhole.icons = {apm.lib.icons.static.sinkhole}
sinkhole.localised_description = { "entity-description.apm_sinkhole" }
--sinkhole.icon_size = 32
sinkhole.flags = { "placeable-neutral", "placeable-player", "player-creation" }
sinkhole.minable = { mining_time = 0.2, result = pipes.sinkhole.small }
sinkhole.max_health = 400
sinkhole.corpse = "small-remnants"
sinkhole.dying_explosion = "explosion"
sinkhole.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
sinkhole.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
sinkhole.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sinkhole.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
sinkhole.vehicle_impact_sound = { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 }
sinkhole.source_inventory_size = 0
sinkhole.result_inventory_size = 0
sinkhole.next_upgrade = nil
sinkhole.crafting_categories = { "apm_sinkhole" }
sinkhole.crafting_speed = 1
sinkhole.fast_replaceable_group = "apm_power_sinkhole"
sinkhole.resistances = { { type = "fire", percent = 95 } }

sinkhole.collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } }
sinkhole.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

sinkhole.energy_usage = apm.power.constants.energy_usage.electric
sinkhole.energy_source = {
    type = "void",
    emissions_per_minute = 5,
    fluid_box = {}
}

sinkhole.module_specification = apm.power.constants.modules.specification_2
sinkhole.allowed_effects = apm.power.constants.modules.allowed_effects_2


local gen = function (direction)
    local animation = {
        filename = ppPath..'hr-'..base..direction..ext,
        priority = "high",
        width = 128,
        height = 163,
        frame_count = 1,
        line_length = 1,
        shift = { 0.0, -0.40625 },
        scale = 0.5,
        hr_version = {
            filename = ppPath..'hr-'..base..direction..ext,
            priority = "high",
            width = 128,
            height = 163,
            frame_count = 1,
            line_length = 1,
            shift = { 0.0, -0.40625 },
            scale = 0.5,
        },
    }

    return animation
end


sinkhole.animation = {}
sinkhole.animation.north = gen('n')
sinkhole.animation.east = gen('e')
sinkhole.animation.south = gen('s')
sinkhole.animation.west = gen('w')

local base_area = settings.startup["apm_sinkhole_fluid_rate"].value / 10

sinkhole.fluid_boxes = {}
sinkhole.fluid_boxes[1] = {}
sinkhole.fluid_boxes[1].production_type = "input"
-- sinkhole.fluid_boxes[1].pipe_picture = pipe_picture
sinkhole.fluid_boxes[1].pipe_covers = pipe_covers
sinkhole.fluid_boxes[1].base_area = base_area
sinkhole.fluid_boxes[1].base_level = -1
sinkhole.fluid_boxes[1].filter = ""
sinkhole.fluid_boxes[1].pipe_connections = {
    -- {
    --     type = "input-output",
    --     position = { 0, 1 }
    -- },
    {
        type = "input-output",
        position = {0, -1},
    },
    -- {
    --     type = "input-output",
    --     position = { 1, 0 }
    -- },
    -- {
    --     type = "input-output",
    --     position = {-1, 0},
    -- }
}
sinkhole.fluid_boxes[1].secondary_draw_orders = { north = -1, south = 1, west = -1, east = 1 }

data:extend({ sinkhole })
