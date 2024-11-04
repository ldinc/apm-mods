require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/sieve.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ -0.70, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local smoke_steam = {
	apm.lib.utils.builders.smoke.new(
		"apm_light_smoke",
		{ 0.1, 0.1 },
		8,
		{ -0.70, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local sieve = {}
sieve.type = "assembling-machine"
sieve.name = "apm_sieve_0"
sieve.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_si
}
sieve.localised_description = { "entity-description.apm_sieve_0" }

sieve.flags = { "placeable-neutral", "placeable-player", "player-creation" }
sieve.minable = { mining_time = 0.2, result = "apm_sieve_0" }
sieve.crafting_categories = { "apm_sifting_0" }
sieve.crafting_speed = 1
sieve.fast_replaceable_group = "apm_sieve"
sieve.next_upgrade = nil
sieve.max_health = 250
sieve.corpse = "big-remnants"
sieve.dying_explosion = "medium-explosion"
sieve.resistances = { { type = "fire", percent = 90 } }
sieve.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
sieve.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
sieve.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
sieve.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sieve.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
sieve.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
sieve.working_sound = {}
sieve.working_sound.sound = { { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 },
	{ filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 } }
sieve.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
sieve.working_sound.apparent_volume = 1.5
sieve.energy_usage = apm.power.constants.energy_usage.steam
sieve.module_specification = apm.power.constants.modules.specification_2
sieve.allowed_effects = apm.power.constants.modules.allowed_effects_2

sieve.energy_source = apm.lib.utils.builders.energy_source.new_steam(apm.power.constants.emissions.t2, smoke_steam)

sieve.graphics_set = {
	animation_progress = 1.0666667,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/sieve/hr_sieve_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 32,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/sieve/hr_sieve_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 32,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
}

--[[
sieve.fluid_boxes = {}
sieve.fluid_boxes[1] = {}
sieve.fluid_boxes[1].production_type = "output"
sieve.fluid_boxes[1].pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()
sieve.fluid_boxes[1].pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
sieve.fluid_boxes[1].base_area = 1
sieve.fluid_boxes[1].base_level = 1
sieve.fluid_boxes[1].pipe_connections = {{ type="output", position = {0, 2} }}
sieve.fluid_boxes[1].secondary_draw_orders = { north = -1 }
]] --
data:extend({ sieve })
