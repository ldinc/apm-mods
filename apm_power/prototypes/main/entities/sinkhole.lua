require("util")
require("__apm_lib_ldinc__.lib.log")

local hit_effects = require("__base__.prototypes.entity.hit-effects")

local self = "apm_power/prototypes/main/sinkhole.lua"

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
		filename = ppPath .. "pipecovers/hr-pipe-N.png",
		priority = "extra-high",
		width = 71,
		height = 38,
		shift = util.by_pixel(2.25, 13.5),
		scale = 0.5
	},
	east = empty,
	south = {
		filename = ppPath .. "pipecovers/hr-pipe-S.png",
		priority = "extra-high",
		width = 88,
		height = 61,
		shift = util.by_pixel(0, -31.25),
		scale = 0.5
	},
	west = empty
}

local pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
pipe_covers.east = empty
pipe_covers.west = empty

local rate = settings.startup["apm_sinkhole_fluid_rate"].value / 10

--- [apm_sinkhole]
---@type data.FurnacePrototype
local sinkhole = {
	type = "furnace",
	name = "apm_sinkhole",
	icons = { apm.lib.icons.static.sinkhole },
	localised_description = { "entity-description.apm_sinkhole" },
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "apm_sinkhole" },
	max_health = 400,
	corpse = "medium-remnants",
	dying_explosion = "medium-explosion",

	impact_category = "metal",

	repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
	mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },

	source_inventory_size = 0,
	result_inventory_size = 0,
	next_upgrade = nil,
	crafting_categories = { "apm_sinkhole" },
	crafting_speed = rate,
	fast_replaceable_group = "apm_power_sinkhole",
	resistances = { { type = "fire", percent = 95 } },

	collision_box = { { -1.45, -1.45 }, { 1.45, 1.45 } },
	selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },

	energy_usage = apm.power.constants.energy_usage.electric,

	energy_source = {
		type = "void",
		emissions_per_minute = { pollution = 5 },
	},
}

-- sinkhole.light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}

sinkhole.working_sound = {
	filename                  = "__apm_power_ldinc__/sounds/entities/water-drain.ogg",
	volume                    = 0.6,
	audible_distance_modifier = 0.2,
	probability               = 0.1,
}

sinkhole.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }



sinkhole.resistances = {
	{
		type = "fire",
		percent = 90
	},
	{
		type = "explosion",
		percent = 40
	},
	{
		type = "impact",
		percent = 30
	}
}

sinkhole.damaged_trigger_effect = hit_effects.rock()

sinkhole.graphics_set = {
	animation = {
		layers = {
			{
				filename = ppPath .. "hr-sinkhole.png",
				priority = "extra-high",
				width = 384,
				height = 192,
				frame_count = 1,
				line_length = 1,
				scale = 0.5,
			},
			{
				filename = ppPath .. "hr-sinkhole-shadow.png",
				priority = "extra-high",
				draw_as_shadow = true,
				width = 384,
				height = 192,
				frame_count = 1,
				line_length = 1,
				scale = 0.5,
			}
		},
	},
}

---@type data.FluidBox
box = {
	production_type = "input",
	pipe_picture = pipe_picture,
	pipe_covers = pipe_covers,
	filter = "",
	volume = 2000,
	pipe_connections = {
		{
			flow_direction = "input",
			---@diagnostic disable-next-line: assign-type-mismatch
			direction = defines.direction.south,
			position = { 0, 1.0 }
		},
		{
			flow_direction = "input",
			---@diagnostic disable-next-line: assign-type-mismatch
			direction = defines.direction.north,
			position = { 0, -1.0 }
		},
		{
			flow_direction = "input",
			---@diagnostic disable-next-line: assign-type-mismatch
			direction = defines.direction.west,
			position = { -1.0, 0 }
		},
		{
			flow_direction = "input",
			---@diagnostic disable-next-line: assign-type-mismatch
			direction = defines.direction.east,
			position = { 1.0, 0 }
		}
	},
	secondary_draw_orders = { north = -1 },
}

sinkhole.fluid_boxes = {
	box,
}

if mods["space-age"] then
	sinkhole.heating_energy = "250kW"

	sinkhole.graphics_set.frozen_patch = {
		filename = ppPath .. "hr-sinkhole-frozen.png",
		priority = "extra-high",
		width = 384,
		height = 192,
		frame_count = 1,
		line_length = 1,
		scale = 0.5,
	}

	sinkhole.fluid_boxes[1].pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
	sinkhole.fluid_boxes[1].pipe_covers_frozen.west = empty
	sinkhole.fluid_boxes[1].pipe_covers_frozen.east = empty

	sinkhole.fluid_boxes[1].pipe_picture_frozen = {
		west = empty,
		east = empty,

		north = {
			filename = ppPath .. "pipecovers/hr-pipe-N-frozen.png",
			priority = "extra-high",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5
		},
		south = {
			filename = ppPath .. "pipecovers/hr-pipe-S-frozen.png",
			priority = "extra-high",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5
		},
	}
end

data:extend({ sinkhole })
