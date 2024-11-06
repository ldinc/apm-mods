require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/presses.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ -0.58, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local smoke_steam = {
	apm.lib.utils.builders.smoke.new(
		"light-smoke",
		{ 0.1, 0.1 },
		8,
		{ -0.58, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local base_animation_progress = 1.0666667

local press = {}
press.type = "assembling-machine"
press.name = "apm_press_machine_0"
press.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_p
}

press.flags = { "placeable-neutral", "placeable-player", "player-creation" }
press.minable = { mining_time = 0.1, result = "apm_press_machine_0" }
press.crafting_categories = { "apm_press" }
press.crafting_speed = 0.5
press.fast_replaceable_group = "apm_power_press_machine"
press.next_upgrade = "apm_press_machine_1"
press.max_health = 250
press.corpse = "big-remnants"
press.dying_explosion = "medium-explosion"
press.resistances = { { type = "fire", percent = 90 } }
press.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
press.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
press.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
press.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
press.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
press.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
press.working_sound = {}
press.working_sound.sound = {}
-- press.working_sound.sound.filename = "__base__/sound/assembling-machine-t1-1.ogg"
press.working_sound.sound.filename = "__apm_resource_pack_ldinc__/sounds/entities/press.ogg"
press.working_sound.sound.volume = 0.8
press.working_sound.idle_sound = {}
press.working_sound.idle_sound.filename = "__base__/sound/idle1.ogg"
press.working_sound.idle_sound.volume = 0.6
press.working_sound.apparent_volume = 1.5
press.energy_usage = apm.power.constants.energy_usage.burner
press.module_specification = apm.power.constants.modules.specification_0
press.allowed_effects = apm.power.constants.modules.allowed_effects_0

press.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.t0,
	smoke_burner
)

press.graphics_set = {
	animation_progress = base_animation_progress / press.crafting_speed,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/press/hr_press_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 64,
				line_length = 8,
				{ 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/press/hr_press_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 64,
				line_length = 8,
				{ 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
}

press.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way()

press.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ press })

local press = table.deepcopy(press)
press.name = "apm_press_machine_1"
press.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_p
}
--press.icon_size = 32
press.minable = { mining_time = 0.2, result = "apm_press_machine_1" }
press.light = nil
press.crafting_categories = { "apm_press", 'apm_press_2' }
press.crafting_speed = 1
press.fast_replaceable_group = "apm_power_press_machine"
press.next_upgrade = "apm_press_machine_2"
press.energy_usage = apm.power.constants.energy_usage.steam
press.module_specification = apm.power.constants.modules.specification_1
press.allowed_effects = apm.power.constants.modules.allowed_effects_1

press.energy_source = apm.lib.utils.builders.energy_source.new_steam(
	apm.power.constants.emissions.t1,
	smoke_steam
)

press.graphics_set.animation_progress = base_animation_progress / press.crafting_speed

press.graphics_set.animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/press/hr_press_1.png"

press.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

data:extend({ press })

local press = table.deepcopy(press)
press.name = "apm_press_machine_2"
press.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_p
}

press.minable = { mining_time = 0.2, result = "apm_press_machine_2" }
press.light = nil
press.crafting_categories = { "apm_press", 'apm_press_2', 'apm_press_3' }
press.crafting_speed = 1.5
press.fast_replaceable_group = "apm_power_press_machine"
press.next_upgrade = nil
press.energy_usage = apm.power.constants.energy_usage.electric
press.module_specification = apm.power.constants.modules.specification_2
press.allowed_effects = apm.power.constants.modules.allowed_effects_2

press.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.t2,
	apm.power.constants.engery_drain.electric
)

press.graphics_set.animation_progress = base_animation_progress / press.crafting_speed

press.graphics_set.animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/press/hr_press_2.png"

press.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler3pipepictures()
)

data:extend({ press })
