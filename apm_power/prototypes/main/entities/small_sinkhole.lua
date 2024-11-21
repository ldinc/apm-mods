require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local ppPath = "__apm_resource_pack_ldinc__/graphics/entities/small_sinkhole/"
local base = 'small-'
local ext = '.png'

local item_icon_a = apm.lib.utils.icon.get.from_item("pipe-to-ground")
local item_icon_b = { apm.lib.icons.dynamics.cooling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local empty = {
	filename = "__core__/graphics/empty.png",
	priority = "extra-high",
	width = 1,
	height = 1
}

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
pipe_covers.east = empty
pipe_covers.west = empty

local entity_name = 'apm_sinkhole_small'

local rate = settings.startup["apm_sinkhole_fluid_rate"].value / 100

--- [apm_sinkhole_small]
---@type data.FurnacePrototype
local sinkhole = {}
sinkhole.type = "furnace"
sinkhole.name = 'apm_sinkhole_small'
sinkhole.icons = icons
sinkhole.localised_description = { "entity-description.apm_sinkhole" }
--sinkhole.icon_size = 32
sinkhole.flags = { "placeable-neutral", "placeable-player", "player-creation" }
sinkhole.minable = { mining_time = 0.2, result = entity_name }
sinkhole.max_health = 400
sinkhole.corpse = "small-remnants"
sinkhole.dying_explosion = "explosion"

sinkhole.impact_category = "metal"
sinkhole.working_sound = {
	{
		filename                  = "__apm_power_ldinc__/sounds/entities/water-drain.ogg",
		volume                    = 0.3,
		audible_distance_modifier = 0.2,
		probability               = 0.1,
	},
}

sinkhole.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
sinkhole.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
sinkhole.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sinkhole.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

sinkhole.source_inventory_size = 0
sinkhole.result_inventory_size = 0
sinkhole.next_upgrade = nil

sinkhole.crafting_categories = { "apm_sinkhole" }
sinkhole.crafting_speed = rate
sinkhole.fast_replaceable_group = "apm_power_sinkhole"
sinkhole.resistances = { { type = "fire", percent = 95 } }

sinkhole.collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } }
sinkhole.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

sinkhole.energy_usage = apm.power.constants.energy_usage.electric

sinkhole.energy_source = apm.lib.utils.builders.energy_source.new_void({ pollution = 5 })

local gen = function(direction)
	local animation = {
		filename = ppPath .. 'hr-' .. base .. direction .. ext,
		priority = "high",
		width = 128,
		height = 163,
		frame_count = 1,
		line_length = 1,
		shift = { 0.0, -0.40625 },
		scale = 0.5,
	}

	return animation
end


sinkhole.graphics_set = {
	animation = {
		north = gen('n'),
		east = gen('e'),
		south = gen('s'),
		west = gen('w'),
	},
}

sinkhole.graphics_set.animation.south.shift = util.by_pixel(3, -11)

sinkhole.fluid_boxes = {
	apm.lib.utils.builders.fluid_box.new(
		"input",
		1000,
		nil,
		defines.direction.north,
		{ 0, 0 },
		{ north = -1 }
	),
}
sinkhole.fluid_boxes[1].pipe_picture = nil

data:extend({ sinkhole })
