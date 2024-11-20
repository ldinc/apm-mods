require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/entities/hybrid_cooling_tower.lua"

APM_LOG_HEADER(self)

---@type data.FurnacePrototype
local hybrid_cooling_tower = {
	result_inventory_size = 0,
	source_inventory_size = 0,
}

hybrid_cooling_tower.type = "furnace"
hybrid_cooling_tower.name = "apm_hybrid_cooling_tower_0"
hybrid_cooling_tower.icons = {
	apm.nuclear.icons.hybrid_cooling_tower
}
--hybrid_cooling_tower.icon_size = 32
hybrid_cooling_tower.flags = { "placeable-neutral", "placeable-player", "player-creation" }
hybrid_cooling_tower.minable = { mining_time = 0.2, result = "apm_hybrid_cooling_tower_0" }
hybrid_cooling_tower.crafting_categories = { "apm_fluid_cooling_0" }
hybrid_cooling_tower.crafting_speed = 1

hybrid_cooling_tower.fast_replaceable_group = "apm_hybrid_cooling_tower"
hybrid_cooling_tower.next_upgrade = nil
hybrid_cooling_tower.max_health = 250
hybrid_cooling_tower.corpse = "big-remnants"
hybrid_cooling_tower.dying_explosion = "medium-explosion"
hybrid_cooling_tower.resistances = { { type = "fire", percent = 90 } }
hybrid_cooling_tower.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
hybrid_cooling_tower.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

-- hybrid_cooling_tower.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }

hybrid_cooling_tower.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
hybrid_cooling_tower.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

hybrid_cooling_tower.working_sound = {
	main_sounds = {
		sound = {
			filename = "__apm_resource_pack_ldinc__/sounds/entities/hybrid_cooling_tower.ogg",
			volume = 0.8,
		},
	},
	idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
	apparent_volume = 1.5,
}

hybrid_cooling_tower.module_slots = 0
hybrid_cooling_tower.allowed_effects = nil

hybrid_cooling_tower.energy_usage = "300kW"
hybrid_cooling_tower.energy_source = {
	type = "electric",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 0.25 },
}

hybrid_cooling_tower.graphics_set = {
	animation_progress = 0.53333335,
	animation = {
		layers = {
			{
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/hybrid_cooling_tower/hr_hybrid_cooling_tower_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 1,
				line_length = 1,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/hybrid_cooling_tower/hr_hybrid_cooling_tower_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 1,
				line_length = 1,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			}
		},
	},
	working_visualisations = {
		{
			apply_recipe_tint = "tertiary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(-38, -120),
			east_position = util.by_pixel_hr(-38, -120),
			south_position = util.by_pixel_hr(-38, -120),
			west_position = util.by_pixel_hr(-38, -120),
			render_layer = "wires",

			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
				frame_count = 47,
				line_length = 16,
				width = 90,
				height = 188,
				animation_speed = 0.5,
				shift = util.by_pixel(-2, -40),
				scale = 0.5,
			},
		},

		{
			apply_recipe_tint = "tertiary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(-1, -120),
			east_position = util.by_pixel_hr(-1, -120),
			south_position = util.by_pixel_hr(-1, -120),
			west_position = util.by_pixel_hr(-1, -120),
			render_layer = "wires",

			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
				frame_count = 47,
				line_length = 16,
				width = 90,
				height = 188,
				animation_speed = 0.5,
				shift = util.by_pixel(-2, -40),
				scale = 0.5,
			},
		},

		{
			apply_recipe_tint = "tertiary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(37, -120),
			east_position = util.by_pixel_hr(37, -120),
			south_position = util.by_pixel_hr(37, -120),
			west_position = util.by_pixel_hr(37, -120),
			render_layer = "wires",

			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
				frame_count = 47,
				line_length = 16,
				width = 90,
				height = 188,
				animation_speed = 0.5,
				shift = util.by_pixel(-2, -40),
				scale = 0.5,
			},
		},
	},
}

local box = apm.lib.utils.builders.fluid_box.new

hybrid_cooling_tower.fluid_boxes = {
	box(
		"input",
		10000,
		apm.lib.utils.pipecovers.assembler4pipepictures(),
		defines.direction.south,
		{0, 1},
		{ north = -1 }
	),
	box(
		"output",
		1000,
		apm.lib.utils.pipecovers.assembler4pipepictures(),
		defines.direction.north,
		{0, -1},
		{ north = -1 }
	),
}

data:extend({ hybrid_cooling_tower })
