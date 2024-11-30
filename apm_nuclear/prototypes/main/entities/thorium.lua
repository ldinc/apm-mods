require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/entities/thorium.lua"

APM_LOG_HEADER(self)

-- local resource_autoplace = require("resource-autoplace");

local resource_autoplace = require("__core__.lualib.resource-autoplace")

---@type data.AutoplaceControl
local autoplace_control = {
	type = "autoplace-control",
	name = "thorium-ore",
	localised_name = {"", "[entity=thorium-ore] ", {"entity-name.thorium-ore"}},
	richness = true,
	order = "b",
	category = "resource",
}

data:extend({ autoplace_control })

---@type data.ResourceEntityPrototype
-- local resource = {
-- 	type = "resource",
-- 	name = "thorium-ore",
-- 	icons = {
-- 		apm.nuclear.icons.thorium_ore
-- 	},

-- 	flags = { "placeable-neutral" },
-- 	order = "a-b-f",
-- 	tree_removal_probability = 0.7,
-- 	tree_removal_max_distance = 32 * 32,
-- 	minable =
-- 	{
-- 		mining_particle = "stone-particle",
-- 		mining_time = 2,
-- 		result = (not data.is_demo) and "thorium-ore" or nil,
-- 		fluid_amount = 10,
-- 		required_fluid = "sulfuric-acid"
-- 	},

-- 	collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } },
-- 	selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },

-- 	autoplace = resource_autoplace.resource_autoplace_settings
-- 			{
-- 				name = "thorium-ore",
-- 				order = "z",
-- 				base_density = 0.9,
-- 				base_spots_per_km2 = 1.25,
-- 				has_starting_area_placement = false,
-- 				random_spot_size_minimum = 2,
-- 				random_spot_size_maximum = 4,
-- 				regular_rq_factor_multiplier = 1
-- 			},

-- 	stage_counts = { 10000, 6330, 3670, 1930, 870, 270, 100, 50 },

-- 	stages = {
-- 		sheet = {
-- 			filename = "__apm_resource_pack_ldinc__/graphics/entities/thorium_ore/hr_thorium_ore.png",
-- 			priority = "extra-high",
-- 			width = 128,
-- 			height = 128,
-- 			frame_count = 8,
-- 			variation_count = 8,
-- 			scale = 0.5,
-- 		},
-- 	},

-- 	stages_effect = {
-- 		sheet = {
-- 			filename = "__apm_resource_pack_ldinc__/graphics/entities/thorium_ore/hr_thorium_ore_glow.png",
-- 			priority = "extra-high",
-- 			width = 128,
-- 			height = 128,
-- 			frame_count = 8,
-- 			variation_count = 8,
-- 			scale = 0.5,
-- 			blend_mode = "additive",
-- 			flags = { "light" },
-- 		},
-- 	},

-- 	effect_animation_period = 5,
-- 	effect_animation_period_deviation = 1,
-- 	effect_darkness_multiplier = 3.6,
-- 	min_effect_alpha = 0.2,
-- 	max_effect_alpha = 0.3,
-- 	map_color = { 0.310, 0.176, 0.110 },
-- }

-- data:extend({ resource })

local name = "thorium-ore"

require("__base__/prototypes/factoriopedia-util")

local factoriopedia = { init = make_resource(name) }
local walking_sound = sound_variations("__base__/sound/walking/resources/ore", 10, 0.7)
local driving_sound = {
	sound = {
		filename = "__base__/sound/driving/vehicle-surface-stone.ogg",
		volume = 0.8,
		advanced_volume_control = {
			fades = {
				fade_in = {
					curve_type = "cosine",
					from = { control = 0.5, volume_percentage = .0 },
					to = { 1.5, 100.0 },
				},
			},
		}
	},
	fade_ticks = 6
}

---@type data.ResourceEntityPrototype
local resource = {
	type = "resource",
	name = name,
	icon = apm.nuclear.icons.thorium_ore.icon,
	flags = { "placeable-neutral" },
	factoriopedia_simulation = factoriopedia,
	order = "a-b-e",
	tree_removal_probability = 0.7,
	tree_removal_max_distance = 32 * 32,
	walking_sound = walking_sound,
	driving_sound = driving_sound,
	minable =
	{
		mining_particle = "stone-particle",
		mining_time = 2,
		result = name,
		fluid_amount = 10,
		required_fluid = "sulfuric-acid"
	},
	collision_box = { { -0.1, -0.1 }, { 0.1, 0.1 } },
	selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } },
	autoplace = resource_autoplace.resource_autoplace_settings
			{
				name = name,
				order = "t",
				base_density = 0.9,
				base_spots_per_km2 = 1.25,
				has_starting_area_placement = false,
				random_spot_size_minimum = 2,
				random_spot_size_maximum = 4,
				regular_rq_factor_multiplier = 1
			},
	stage_counts = { 10000, 6330, 3670, 1930, 870, 270, 100, 50 },
	stages =
	{
		sheet = {
			filename = "__apm_resource_pack_ldinc__/graphics/entities/thorium_ore/hr_thorium_ore.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			frame_count = 8,
			variation_count = 8,
			scale = 0.5,
		},
	},
	stages_effect =
	{
		sheet = {
			filename = "__apm_resource_pack_ldinc__/graphics/entities/thorium_ore/hr_thorium_ore_glow.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			frame_count = 8,
			variation_count = 8,
			scale = 0.5,
			blend_mode = "additive",
			flags = { "light" },
		},
	},
	effect_animation_period = 5,
	effect_animation_period_deviation = 1,
	effect_darkness_multiplier = 3.6,
	min_effect_alpha = 0.2,
	max_effect_alpha = 0.3,
	mining_visualisation_tint = { r = 0.441, g = 0.277, b = 0.023, a = 1.000 },
	map_color = { 0.310, 0.176, 0.110 }
}

data:extend({ resource })