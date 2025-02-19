require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/sieve.lua'

APM_LOG_HEADER(self)

-- local smoke_burner = {
-- 	apm.lib.utils.builders.smoke.new(
-- 		"apm_dark_smoke",
-- 		{ 0.1, 0.1 },
-- 		10,
-- 		{ -0.70, -2.15 },
-- 		nil,
-- 		0.08,
-- 		60,
-- 		1
-- 	)
-- }

local smoke_steam = {
	apm.lib.utils.builders.smoke.new(
		"light-smoke",
		{ 0.1, 0.1 },
		8,
		{ -0.70, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local base_animation_progress = 1.0666667

--- [apm_sieve_0]
---@type data.AssemblingMachinePrototype
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

sieve.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
sieve.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

sieve.working_sound = {
	main_sounds = {
		{ sound = { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 } },
		{ sound = { filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 } },
	},
}

sieve.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
sieve.working_sound.apparent_volume = 1.5
sieve.energy_usage = apm.power.constants.energy_usage.steam
sieve.module_slots = apm.power.constants.modules.specification_2.module_slots
sieve.allowed_effects = apm.power.constants.modules.allowed_effects_2

sieve.energy_source = apm.lib.utils.builders.energy_source.new_steam(apm.power.constants.emissions.t2, smoke_steam)

sieve.graphics_set = {
	animation_progress = base_animation_progress / sieve.crafting_speed,
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

data:extend({ sieve })
