require("lib.utils")
require("lib.const")
require("lib.features")

local simulations = require("__base__.prototypes.factoriopedia-simulations")
local sounds = require("__base__.prototypes.entity.sounds")
local hit_effects = require("__base__.prototypes.entity.hit-effects")

local tint = rampant_heavy_wall.lib.const.gate.tint
local name = rampant_heavy_wall.lib.const.gate.name
local max_health = rampant_heavy_wall.lib.features.wall_hp()

local gate = {
	type = "gate",
	name = name,
	icon = "__base__/graphics/icons/gate.png",
	flags = {"placeable-neutral","placeable-player", "player-creation"},
	fast_replaceable_group = "wall",
	minable = {mining_time = 0.1, result =name},
	max_health = max_health,
	corpse = "gate-remnants",
	dying_explosion = "gate-explosion",
	factoriopedia_simulation = simulations.factoriopedia_gate,
	collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
	selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
	damaged_trigger_effect = hit_effects.entity(),
	opening_speed = 0.0666666,
	activation_distance = 3,
	timeout_to_close = 5,
	fadeout_interval = 15,
	resistances =
	{
		{
			type = "physical",
			decrease = 3,
			percent = 70
		},
		{
			type = "impact",
			decrease = 45,
			percent = 70
		},
		{
			type = "explosion",
			decrease = 10,
			percent = 70
		},
		{
			type = "fire",
			percent = 100
		},
		{
			type = "acid",
			percent = 80
		},
		{
			type = "laser",
			percent = 80
		}
	},
	vertical_animation =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-vertical.png",
				line_length = 8,
				width = 78,
				height = 120,
				frame_count = 16,
				shift = util.by_pixel(-1, -13),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-vertical-shadow.png",
				line_length = 8,
				width = 82,
				height = 104,
				frame_count = 16,
				shift = util.by_pixel(9, 9),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	horizontal_animation =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-horizontal.png",
				line_length = 8,
				width = 66,
				height = 90,
				frame_count = 16,
				shift = util.by_pixel(0, -3),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-horizontal-shadow.png",
				line_length = 8,
				width = 122,
				height = 60,
				frame_count = 16,
				shift = util.by_pixel(12, 10),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	horizontal_rail_animation_left =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-rail-horizontal-left.png",
				line_length = 8,
				width = 66,
				height = 74,
				frame_count = 16,
				shift = util.by_pixel(0, -7),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-left.png",
				line_length = 8,
				width = 122,
				height = 60,
				frame_count = 16,
				shift = util.by_pixel(12, 10),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	horizontal_rail_animation_right =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-rail-horizontal-right.png",
				line_length = 8,
				width = 66,
				height = 74,
				frame_count = 16,
				shift = util.by_pixel(0, -7),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-rail-horizontal-shadow-right.png",
				line_length = 8,
				width = 122,
				height = 58,
				frame_count = 16,
				shift = util.by_pixel(12, 11),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	vertical_rail_animation_left =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-rail-vertical-left.png",
				line_length = 8,
				width = 42,
				height = 118,
				frame_count = 16,
				shift = util.by_pixel(0, -13),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-left.png",
				line_length = 8,
				width = 82,
				height = 104,
				frame_count = 16,
				shift = util.by_pixel(9, 9),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	vertical_rail_animation_right =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-rail-vertical-right.png",
				line_length = 8,
				width = 42,
				height = 118,
				frame_count = 16,
				shift = util.by_pixel(0, -13),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-rail-vertical-shadow-right.png",
				line_length = 8,
				width = 82,
				height = 104,
				frame_count = 16,
				shift = util.by_pixel(9, 9),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	vertical_rail_base =
	{
		filename = "__base__/graphics/entity/gate/gate-rail-base-vertical.png",
		line_length = 8,
		width = 138,
		height = 130,
		frame_count = 16,
		shift = util.by_pixel(-1, 0),
		scale = 0.5,
		tint = tint,
	},
	horizontal_rail_base =
	{
		filename = "__base__/graphics/entity/gate/gate-rail-base-horizontal.png",
		line_length = 8,
		width = 130,
		height = 104,
		frame_count = 16,
		shift = util.by_pixel(0, 3),
		scale = 0.5,
		tint = tint,
	},
	wall_patch =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/gate/gate-wall-patch.png",
				line_length = 8,
				width = 70,
				height = 94,
				frame_count = 16,
				shift = util.by_pixel(-1, 13),
				scale = 0.5,
				tint = tint,
			},
			{
				filename = "__base__/graphics/entity/gate/gate-wall-patch-shadow.png",
				line_length = 8,
				width = 82,
				height = 72,
				frame_count = 16,
				shift = util.by_pixel(9, 33),
				draw_as_shadow = true,
				scale = 0.5
			}
		}
	},
	impact_category = "stone",
	opening_sound = sounds.gate_open,
	closing_sound = sounds.gate_close
}

data:extend({gate})