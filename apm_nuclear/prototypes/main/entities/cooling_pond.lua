require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/entities/cooling_pond.lua"

APM_LOG_HEADER(self)

---@type data.AssemblingMachinePrototype
local cooling_pond = {}
cooling_pond.type = "assembling-machine"
cooling_pond.name = "apm_cooling_pond_0"
cooling_pond.icons = {
	apm.nuclear.icons.cooling_pond
}
--cooling_pond.icon_size = 32
cooling_pond.flags = { "placeable-neutral", "placeable-player", "player-creation" }
cooling_pond.minable = { mining_time = 0.2, result = "apm_cooling_pond_0" }
cooling_pond.crafting_categories = { "apm_nuclear_cooling_0" }
cooling_pond.crafting_speed = 1

cooling_pond.fast_replaceable_group = "apm_cooling_pond"
cooling_pond.next_upgrade = nil
cooling_pond.max_health = 250
cooling_pond.corpse = "big-remnants"
cooling_pond.dying_explosion = "medium-explosion"
cooling_pond.resistances = { { type = "fire", percent = 90 } }
cooling_pond.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
cooling_pond.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
-- cooling_pond.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
cooling_pond.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
cooling_pond.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

cooling_pond.working_sound = {
	main_sounds = {
		{
			sound = { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 },
		},
		{
			sound = { filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 },
		}
	},

	idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },

	apparent_volume = 1.5,
}


cooling_pond.module_slots = 2
cooling_pond.allowed_effects = { "consumption", "speed", "pollution" }

cooling_pond.energy_usage = "500kW"
cooling_pond.energy_source = {
	type = "electric",
	usage_priority = "secondary-input",
}

cooling_pond.energy_source.emissions_per_minute = { pollution = 0.25 }

cooling_pond.graphics_set = {
	animation_progress = 0.53333335,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/cooling_pond/hr_cooling_pond_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 8,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/cooling_pond/hr_cooling_pond_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 8,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
	idle_animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/cooling_pond/hr_cooling_pond_idle_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 8,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/cooling_pond/hr_cooling_pond_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 8,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
}

local box = apm.lib.utils.builders.fluid_box.new

cooling_pond.fluid_boxes = {
	box(
		"input",
		2000,
		apm.lib.utils.pipecovers.assembler3pipepictures(),
		defines.direction.south,
		{0, 1},
		{ north = -1 }
	),
	box(
		"output",
		2000,
		apm.lib.utils.pipecovers.assembler3pipepictures(),
		defines.direction.north,
		{0, -1},
		{ north = -1 }
	),
	box(
		"output",
		2000,
		apm.lib.utils.pipecovers.assembler3pipepictures(),
		defines.direction.east,
		{1.119, 0},
		{ north = -1 }
	)
}

cooling_pond.circuit_connector = apm.lib.utils.assembler.get.default_circuit_connector()
cooling_pond.circuit_wire_max_distance = apm.lib.utils.assembler.get.default_circuit_wire_max_distance()

data:extend({ cooling_pond })
