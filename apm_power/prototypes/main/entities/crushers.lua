require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/crushers.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ 0.32, -2.15 },
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
		{ 0.32, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

local base_animation_progress = 1.0666667

--- [apm_crusher_machine_0]
---@type data.AssemblingMachinePrototype
local crusher = {}
crusher.type = "assembling-machine"
crusher.name = "apm_crusher_machine_0"
crusher.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_c
}
crusher.flags = { "placeable-neutral", "placeable-player", "player-creation" }
crusher.minable = { mining_time = 0.1, result = "apm_crusher_machine_0" }
crusher.crafting_categories = { "apm_crusher" }
crusher.crafting_speed = 0.5
crusher.fast_replaceable_group = "apm_power_crusher_machine"
crusher.next_upgrade = "apm_crusher_machine_1"
crusher.max_health = 250
crusher.corpse = "big-remnants"
crusher.dying_explosion = "medium-explosion"
crusher.resistances = { { type = "fire", percent = 90 } }
crusher.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
crusher.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

crusher.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
crusher.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

crusher.working_sound = {
	filename = "__base__/sound/burner-mining-drill-1.ogg",
	volume = 1.0,
}

crusher.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
crusher.working_sound.apparent_volume = 1.5
crusher.energy_usage = apm.power.constants.energy_usage.burner

crusher.module_slots = apm.power.constants.modules.specification_0.module_slots
crusher.allowed_effects = apm.power.constants.modules.allowed_effects_0

crusher.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.t0,
	smoke_burner
)

-- crusher.match_animation_speed_to_activity = false

crusher.graphics_set = {
	animation_progress = base_animation_progress / crusher.crafting_speed,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/crusher/hr_crusher_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 32,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/crusher/hr_crusher_shadow.png",
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
	}
}


crusher.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way()

crusher.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ crusher })

--- [apm_crusher_machine_1]
---@type data.AssemblingMachinePrototype
local crusher = table.deepcopy(crusher)
crusher.name = "apm_crusher_machine_1"
crusher.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_c
}

crusher.minable = { mining_time = 0.2, result = "apm_crusher_machine_1" }

crusher.crafting_categories = { "apm_crusher", "apm_crusher_2" }
crusher.crafting_speed = 1
crusher.fast_replaceable_group = "apm_power_crusher_machine"
crusher.next_upgrade = 'apm_crusher_machine_2'
crusher.energy_usage = apm.power.constants.energy_usage.steam

crusher.module_slots = apm.power.constants.modules.specification_1.module_slots
crusher.allowed_effects = apm.power.constants.modules.allowed_effects_1

crusher.energy_source = apm.lib.utils.builders.energy_source.new_steam(
	apm.power.constants.emissions.t1,
	smoke_steam
)

crusher.graphics_set.animation_progress = base_animation_progress / crusher.crafting_speed

crusher.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/crusher/hr_crusher_1.png"

crusher.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

data:extend({ crusher })

--- [apm_crusher_machine_2]
---@type data.AssemblingMachinePrototype
local crusher = table.deepcopy(crusher)
crusher.name = "apm_crusher_machine_2"
crusher.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_c
}
crusher.minable = { mining_time = 0.2, result = "apm_crusher_machine_2" }
crusher.crafting_categories = { "apm_crusher", "apm_crusher_2", "apm_crusher_3" }
crusher.crafting_speed = 1.5
crusher.fast_replaceable_group = "apm_power_crusher_machine"
crusher.next_upgrade = nil
crusher.energy_usage = apm.power.constants.energy_usage.electric

crusher.module_slots = apm.power.constants.modules.specification_2.module_slots
crusher.allowed_effects = apm.power.constants.modules.allowed_effects_2

crusher.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.t2,
	apm.power.constants.engery_drain.electric
)

crusher.graphics_set.animation_progress = base_animation_progress / crusher.crafting_speed

crusher.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/crusher/hr_crusher_2.png"
crusher.graphics_set.animation.layers[2].filename =
"__apm_resource_pack_ldinc__/graphics/entities/crusher/hr_crusher_shadow_electric.png"

crusher.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler3pipepictures()
)

data:extend({ crusher })
