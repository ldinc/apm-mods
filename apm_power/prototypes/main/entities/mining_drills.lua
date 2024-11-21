require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local hit_effects = require("__base__.prototypes.entity.hit-effects")
local sounds = require("__base__.prototypes.entity.sounds")

local self = 'apm_power/prototypes/main/mining_drills.lua'

APM_LOG_HEADER(self)

local burner_miner = table.deepcopy(data.raw['mining-drill']['burner-mining-drill'])
burner_miner.name = 'apm_burner_miner_drill_2'
burner_miner.module_slots = apm.power.constants.modules.specification_0.module_slots
burner_miner.allowed_effects = apm.power.constants.modules.allowed_effects_0
burner_miner.icon = nil
burner_miner.icons = {
	apm.power.icons.burner_mining_drill,
	apm.lib.icons.dynamics.t2
}
burner_miner.minable = { mining_time = 0.3, result = "apm_burner_miner_drill_2" }

local layer = table.deepcopy(burner_miner.graphics_set.animation.north.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/burner_mining_drill/hr-burner-mining-drill-N.png'
layer.tint = apm.power.color.burner_mining_drill_tier_2
table.insert(burner_miner.graphics_set.animation.north.layers, layer)

local layer = table.deepcopy(burner_miner.graphics_set.animation.east.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/burner_mining_drill/hr-burner-mining-drill-E.png'
layer.tint = apm.power.color.burner_mining_drill_tier_2
table.insert(burner_miner.graphics_set.animation.east.layers, layer)

local layer = table.deepcopy(burner_miner.graphics_set.animation.south.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/burner_mining_drill/hr-burner-mining-drill-S.png'
layer.tint = apm.power.color.burner_mining_drill_tier_2
table.insert(burner_miner.graphics_set.animation.south.layers, layer)

local layer = table.deepcopy(burner_miner.graphics_set.animation.west.layers[1])
layer.filename = '__apm_resource_pack_ldinc__/graphics/masks/burner_mining_drill/hr-burner-mining-drill-W.png'
layer.tint = apm.power.color.burner_mining_drill_tier_2
table.insert(burner_miner.graphics_set.animation.west.layers, layer)

data:extend({ burner_miner })

-- Steam mining drill

-- clone from original factorio
function electric_mining_drill_status_colors()
	return
	{
		-- If no_power, idle, no_minable_resources, disabled, insufficient_input or full_output is used, always_draw of corresponding layer must be set to true to draw it in those states.

		no_power = { 0, 0, 0, 0 },           -- If no_power is not specified or is nil, it defaults to clear color {0,0,0,0}

		idle = { 1, 0, 0, 1 },               -- If idle is not specified or is nil, it defaults to white.
		no_minable_resources = { 1, 0, 0, 1 }, -- If no_minable_resources, disabled, insufficient_input or full_output are not specified or are nil, they default to idle color.
		insufficient_input = { 1, 0, 0, 1 },
		full_output = { 1, 1, 0, 1 },
		disabled = { 1, 1, 0, 1 },

		working = { 0, 1, 0, 1 }, -- If working is not specified or is nil, it defaults to white.
		low_power = { 1, 1, 0, 1 }, -- If low_power is not specified or is nil, it defaults to working color.
	}
end

---@type data.MiningDrillPrototype
local steam_mining_drill = {
	resource_categories = { "basic-solid" },
	resource_searching_radius = 2.49,

	mining_speed = 0.55,

	vector_to_place_result = { 0, -1.85 },

	energy_usage = apm.power.constants.energy_usage.steam_miner,
	energy_source = apm.lib.utils.builders.energy_source.new_steam(
		apm.power.constants.emissions.steam_miner,
		{ apm.lib.utils.builders.smoke.light },
		apm.lib.utils.builders.fluid_box.new_steam_input_3way()
	),
}
steam_mining_drill.type = "mining-drill"
steam_mining_drill.name = "apm_steam_mining_drill"
steam_mining_drill.icon = nil
steam_mining_drill.icons = {
	apm.power.icons.electric_mining_drill
}

steam_mining_drill.damaged_trigger_effect = hit_effects.entity()
steam_mining_drill.working_sound = {
	sound = { filename = "__base__/sound/electric-mining-drill.ogg", volume = 1.0, advanced_volume_control = { attenuation = "exponential" } },
	max_sounds_per_type = 4,
	fade_in_ticks = 4,
	fade_out_ticks = 20
}
steam_mining_drill.open_sound = sounds.drill_open
steam_mining_drill.close_sound = sounds.drill_close

steam_mining_drill.flags = { "placeable-neutral", "player-creation" }
steam_mining_drill.minable = { mining_time = 0.3, result = "apm_steam_mining_drill" }
steam_mining_drill.max_health = 300

steam_mining_drill.corpse = "big-remnants"
steam_mining_drill.collision_box = { { -1.4, -1.4 }, { 1.4, 1.4 } }
steam_mining_drill.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

steam_mining_drill.graphics_set = {
	animation_progress = 1,
	status_colors = electric_mining_drill_status_colors(),

	circuit_connector_layer = "object",
	circuit_connector_secondary_draw_order = { north = 14, east = 30, south = 30, west = 30 },

	animation = {
		north = {
			layers = {
				{
					priority = "high",
					filename = "__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N.png",
					line_length = 8,
					width = 196,
					height = 226,
					animation_speed = 0.5,
					shift = util.by_pixel(0, -8),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward",
				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-N-patch.png",
					line_length = 8,
					width = 200,
					height = 222,
					frame_count = 64,
					animation_speed = 0.5,
					shift = util.by_pixel(-0.5, -6.5),
					scale = 0.5,
					direction_count = 1,
					run_mode = "forward-then-backward",

				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-N-drill-shadow.png",
					line_length = 8,
					width = 201,
					height = 223,
					animation_speed = 0.5,
					draw_as_shadow = true,
					shift = util.by_pixel(1.25, -7.25),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward"
				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-N-patch-shadow.png",
					line_length = 8,
					width = 220,
					height = 197,
					animation_speed = 0.5,
					draw_as_shadow = true,
					shift = util.by_pixel(5, -0.25),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward"
				}
			}
		},

		east = {
			layers = {
				{
					priority = "high",
					filename = "__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E.png",
					line_length = 8,
					width = 211,
					height = 197,
					animation_speed = 0.5,
					shift = util.by_pixel(3.75, -1.25),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward",
				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-E-patch.png",
					line_length = 8,
					width = 200,
					height = 219,
					frame_count = 64,
					animation_speed = 0.5,
					shift = util.by_pixel(0, -5.75),
					scale = 0.5,
					direction_count = 1,
					run_mode = "forward-then-backward",

				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-E-drill-shadow.png",
					line_length = 8,
					width = 221,
					height = 195,
					animation_speed = 0.5,
					draw_as_shadow = true,
					shift = util.by_pixel(6.25, -0.25),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward"
				},
				{
					priority = "high",
					filename =
					"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-E-patch-shadow.png",
					line_length = 8,
					width = 221,
					height = 195,
					animation_speed = 0.5,
					draw_as_shadow = true,
					shift = util.by_pixel(6.25, -0.25),
					-- repeat_count = 5,
					scale = 0.5,
					frame_count = 64,
					direction_count = 1,
					run_mode = "forward-then-backward"
				}
			},
		},
	},

	south = {
		layers = {
			{
				priority = "high",
				filename = "__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S.png",
				line_length = 8,
				width = 196,
				height = 219,
				animation_speed = 0.5,
				shift = util.by_pixel(0, -1.25),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward",
			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-S-patch.png",
				line_length = 8,
				width = 200,
				height = 226,
				frame_count = 64,
				animation_speed = 0.5,
				shift = util.by_pixel(-0.5, -7.5),
				scale = 0.5,
				direction_count = 1,
				run_mode = "forward-then-backward",

			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-S-drill-shadow.png",
				line_length = 8,
				width = 200,
				height = 195,
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(6.25, -0.25),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward"
			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-S-patch-shadow.png",
				line_length = 8,
				width = 221,
				height = 195,
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(6.25, -0.25),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward"
			}
		},
	},

	west = {
		layers = {
			{
				priority = "high",
				filename = "__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W.png",
				line_length = 8,
				width = 211,
				height = 197,
				animation_speed = 0.5,
				shift = util.by_pixel(-3.75, -0.75),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward",
			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-W-patch.png",
				line_length = 8,
				width = 200,
				height = 220,
				frame_count = 64,
				animation_speed = 0.5,
				shift = util.by_pixel(-0.5, -6),
				scale = 0.5,
				direction_count = 1,
				run_mode = "forward-then-backward",

			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/hr-electric-mining-drill-W-drill-shadow.png",
				line_length = 8,
				width = 201,
				height = 223,
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(1.25, -7.25),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward"
			},
			{
				priority = "high",
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/steam_mining_drill/hr-electric-mining-drill-W-patch-shadow.png",
				line_length = 8,
				width = 220,
				height = 197,
				animation_speed = 0.5,
				draw_as_shadow = true,
				shift = util.by_pixel(5, -0.25),
				-- repeat_count = 5,
				scale = 0.5,
				frame_count = 64,
				direction_count = 1,
				run_mode = "forward-then-backward"
			}
		},
	},
}

steam_mining_drill.module_slots = apm.power.constants.modules.specification_1.module_slots
steam_mining_drill.allowed_effects = apm.power.constants.modules.allowed_effects_1
steam_mining_drill.radius_visualisation_picture = {
	filename =
	"__apm_resource_pack_ldinc__/graphics/entities/electric-mining-drill/electric-mining-drill-radius-visualization.png",
	width = 10,
	height = 10
}
steam_mining_drill.monitor_visualization_tint = { r = 78, g = 173, b = 255 }
steam_mining_drill.fast_replaceable_group = "mining-drill"
steam_mining_drill.circuit_wire_connection_points = circuit_connector_definitions["electric-mining-drill"].points
steam_mining_drill.circuit_connector_sprites = circuit_connector_definitions["electric-mining-drill"].sprites
steam_mining_drill.circuit_wire_max_distance = default_circuit_wire_max_distance
data:extend({ steam_mining_drill })
