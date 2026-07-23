require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local ppPath = "__apm_resource_pack_ldinc__/graphics/entities/small_sinkhole/"
local base = "small-"
local ext = ".png"

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

local entity_name = "apm_sinkhole_small"

local rate = settings.startup["apm_sinkhole_fluid_rate"].value / 100

--- [apm_sinkhole_small]
---@type FurnacePrototype
local sinkhole = {
	type = "furnace",
	name = "apm_sinkhole_small",
	icons = icons,
	localised_description = { "entity-description.apm_sinkhole" },
	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = entity_name },
	max_health = 400,
	corpse = "small-remnants",
	dying_explosion = "explosion",

	impact_category = "metal",
	working_sound = {
		{
			filename                  = "__apm_power_ldinc__/sounds/entities/water-drain.ogg",
			volume                    = 0.3,
			audible_distance_modifier = 0.2,
			independent_probability   = 0.1,
		},
	},

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

	collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } },
	selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

	energy_usage = apm.power.constants.energy_usage.electric,

	energy_source = apm.lib.utils.builders.energy_source.new_void({ pollution = 5 }),
}

sinkhole.graphics_set = {
	animation =
	{
		north = {
			filename = ppPath .. "hr-" .. base .. "n" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(0, -15.75),
			scale = 0.5,
		},
		east = {
			filename = ppPath .. "hr-" .. base .. "e" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(0, -11.75),
			scale = 0.5,
		},
		south = {
			filename = ppPath .. "hr-" .. base .. "s" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(3, -10),
			scale = 0.5,
		},
		west = {
			filename = ppPath .. "hr-" .. base .. "w" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(-0.05, -12.25),
			scale = 0.5,
		},
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

if mods["space-age"] then
	sinkhole.heating_energy = "150kW"

	sinkhole.graphics_set.frozen_patch = {
		north = {
			filename = ppPath .. "hr-" .. base .. "n" .. "-frozen" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(0, -15.75),
			scale = 0.5,
		},
		east = {
			filename = ppPath .. "hr-" .. base .. "e" .. "-frozen" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(0, -11.75),
			scale = 0.5,
		},
		south = {
			filename = ppPath .. "hr-" .. base .. "s" .. "-frozen" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(3, -10),
			scale = 0.5,
		},
		west = {
			filename = ppPath .. "hr-" .. base .. "w" .. "-frozen" .. ext,
			priority = "high",
			width = 128,
			height = 163,
			frame_count = 1,
			line_length = 1,
			shift = util.by_pixel(-0.05, -12.25),
			scale = 0.5,
		},
	}

	sinkhole.fluid_boxes[1].pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
end

data:extend({ sinkhole })
