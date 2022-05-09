require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/sinkhole.lua'

APM_LOG_HEADER(self)

local ppPath = "__apm_resource_pack_ldinc__/graphics/entities/sinkhole/"

local empty = {
    filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1
}

local pipe_picture =
{
    north = {
        filename = ppPath.."pipecovers/pipe-N.png",
        priority = "extra-high",
        width = 35,
        height = 18,
        shift = util.by_pixel(2.5, 14),
        hr_version = {
            filename = ppPath.."pipecovers/hr-pipe-N.png",
            priority = "extra-high",
            width = 71,
            height = 38,
            shift = util.by_pixel(2.25, 13.5),
            scale = 0.5
        }
    },
    east = empty,
    south = {
        filename = ppPath.."pipecovers/pipe-S.png",
        priority = "extra-high",
        width = 44,
        height = 31,
        shift = util.by_pixel(0, -31.5),
        hr_version = {
            filename = ppPath.."pipecovers/hr-pipe-S.png",
            priority = "extra-high",
            width = 88,
            height = 61,
            shift = util.by_pixel(0, -31.25),
            scale = 0.5
        }
    },
    west = empty
}

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
pipe_covers.east = empty
pipe_covers.west = empty

local sinkhole = {}
sinkhole.type = "furnace"
sinkhole.name = "apm_sinkhole"
sinkhole.icons = {apm.lib.icons.static.sinkhole}
sinkhole.localised_description = { "entity-description.apm_sinkhole" }
--sinkhole.icon_size = 32
sinkhole.flags = { "placeable-neutral", "placeable-player", "player-creation" }
sinkhole.minable = { mining_time = 0.2, result = "apm_sinkhole" }
sinkhole.max_health = 400
sinkhole.corpse = "medium-remnants"
sinkhole.dying_explosion = "medium-explosion"
sinkhole.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
sinkhole.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
sinkhole.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sinkhole.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
sinkhole.vehicle_impact_sound = { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 }
sinkhole.source_inventory_size = 0
sinkhole.result_inventory_size = 0
sinkhole.next_upgrade = nil
sinkhole.crafting_categories = { "apm_sinkhole" }
sinkhole.crafting_speed = 4
sinkhole.fast_replaceable_group = "apm_power_sinkhole"
sinkhole.resistances = { { type = "fire", percent = 95 } }

sinkhole.collision_box = { { -1.45, -1.45 }, { 1.45, 1.45 } }
sinkhole.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

sinkhole.energy_usage = apm.power.constants.energy_usage.electric
sinkhole.energy_source = {
    type = "void",
    emissions_per_minute = 5,
    fluid_box = {}
}

-- sinkhole.light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}
-- sinkhole.working_sound = {}
-- sinkhole.working_sound.sound = {{filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8},
--                                           {filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8}}
-- sinkhole.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
-- sinkhole.working_sound.apparent_volume = 1.5
sinkhole.module_specification = apm.power.constants.modules.specification_2
sinkhole.allowed_effects = apm.power.constants.modules.allowed_effects_2



sinkhole.animation = {}
sinkhole.animation.layers = {}
sinkhole.animation.layers[1] = {}
sinkhole.animation.layers[1].filename = ppPath.."sinkhole.png"
sinkhole.animation.layers[1].priority = "high"
sinkhole.animation.layers[1].width = 384
sinkhole.animation.layers[1].height = 192
sinkhole.animation.layers[1].frame_count = 1
sinkhole.animation.layers[1].line_length = 1
sinkhole.animation.layers[1].hr_version = {}
sinkhole.animation.layers[1].hr_version.shift = { 0, 0 }
sinkhole.animation.layers[1].hr_version.filename = ppPath.."hr-sinkhole.png"
sinkhole.animation.layers[1].hr_version.priority = "high"
sinkhole.animation.layers[1].hr_version.width = 384
sinkhole.animation.layers[1].hr_version.height = 192
sinkhole.animation.layers[1].hr_version.frame_count = 1
sinkhole.animation.layers[1].hr_version.line_length = 1
sinkhole.animation.layers[1].hr_version.shift = { 0, 0 }
sinkhole.animation.layers[1].hr_version.scale = 0.5

sinkhole.animation.layers[2] = {}
sinkhole.animation.layers[2].filename = ppPath.."sinkhole-shadow.png"
sinkhole.animation.layers[2].priority = "high"
sinkhole.animation.layers[2].draw_as_shadow = true
sinkhole.animation.layers[2].width = 384
sinkhole.animation.layers[2].height = 192
sinkhole.animation.layers[2].frame_count = 1
sinkhole.animation.layers[2].line_length = 1
sinkhole.animation.layers[2].shift = { 0, 0 }
sinkhole.animation.layers[2].hr_version = {}
sinkhole.animation.layers[2].hr_version.filename = ppPath.."hr-sinkhole-shadow.png"
sinkhole.animation.layers[2].hr_version.priority = "high"
sinkhole.animation.layers[2].hr_version.draw_as_shadow = true
sinkhole.animation.layers[2].hr_version.width = 384
sinkhole.animation.layers[2].hr_version.height = 192
sinkhole.animation.layers[2].hr_version.frame_count = 1
sinkhole.animation.layers[2].hr_version.line_length = 1
sinkhole.animation.layers[2].hr_version.shift = { 0, 0 }
sinkhole.animation.layers[2].hr_version.scale = 0.5

local base_area = settings.startup["apm_sinkhole_fluid_rate"].value / 10

sinkhole.fluid_boxes = {}
sinkhole.fluid_boxes[1] = {}
sinkhole.fluid_boxes[1].production_type = "input"
sinkhole.fluid_boxes[1].pipe_picture = pipe_picture
sinkhole.fluid_boxes[1].pipe_covers = pipe_covers
sinkhole.fluid_boxes[1].base_area = base_area
sinkhole.fluid_boxes[1].base_level = -1
sinkhole.fluid_boxes[1].filter = ""
sinkhole.fluid_boxes[1].pipe_connections = {
    {
        type = "input",
        position = { 0, 2 }
    }
}
sinkhole.fluid_boxes[1].secondary_draw_orders = { north = -1 }

data:extend({ sinkhole })
