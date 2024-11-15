require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/coking_plants.lua'

APM_LOG_HEADER(self)

local base_animation_progress = 0.26666667

local coking_plant = {}
coking_plant.type = "assembling-machine"
coking_plant.name = "apm_coking_plant_0"
coking_plant.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_cp
}
--coking_plant.icon_size = 32
coking_plant.flags = { "placeable-neutral", "placeable-player", "player-creation" }
coking_plant.minable = { mining_time = 0.2, result = "apm_coking_plant_0" }
coking_plant.crafting_categories = { "apm_coking" }
coking_plant.crafting_speed = 1
coking_plant.fast_replaceable_group = "apm_coking_plant"
coking_plant.next_upgrade = "apm_coking_plant_1"
coking_plant.max_health = 250
coking_plant.corpse = "big-remnants"
coking_plant.dying_explosion = "medium-explosion"
coking_plant.resistances = { { type = "fire", percent = 90 } }
coking_plant.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
coking_plant.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
coking_plant.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
coking_plant.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
coking_plant.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
coking_plant.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
coking_plant.working_sound = {}
coking_plant.working_sound.sound = { { filename = "__base__/sound/furnace.ogg" } }
coking_plant.energy_usage = apm.power.constants.energy_usage.coking_plant_0
coking_plant.module_specification = apm.power.constants.modules.specification_0
coking_plant.allowed_effects = apm.power.constants.modules.allowed_effects_0

coking_plant.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.cp_0,
	apm.lib.utils.builders.smoke.burner.t0
)

coking_plant.graphics_set = {
	animation_progress = base_animation_progress / coking_plant.crafting_speed,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
	idle_animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_idle_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			}
		},
	},
}

coking_plant.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_4way()

coking_plant.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ coking_plant })

------

local coking_plant = table.deepcopy(coking_plant)
coking_plant.name = "apm_coking_plant_1"
coking_plant.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_cp
}
coking_plant.minable = { mining_time = 0.2, result = "apm_coking_plant_1" }
coking_plant.crafting_speed = 1.5
coking_plant.crafting_categories = { "apm_coking", "apm_coking_2" }
coking_plant.next_upgrade = 'apm_coking_plant_2'
coking_plant.energy_usage = apm.power.constants.energy_usage.coking_plant_1
coking_plant.module_specification = apm.power.constants.modules.specification_1
coking_plant.allowed_effects = apm.power.constants.modules.allowed_effects_1

coking_plant.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'apm_refined_chemical' },
	apm.power.constants.emissions.cp_1,
	apm.lib.utils.builders.smoke.burner.t1
)

coking_plant.graphics_set.animation_progress = base_animation_progress / coking_plant.crafting_speed

coking_plant.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_1.png"
coking_plant.graphics_set.idle_animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_idle_1.png"

coking_plant.graphics_set.animation_progress = 0.17777778

coking_plant.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_4way(apm.lib.utils.pipecovers.assembler2pipepictures())

data:extend({ coking_plant })

local coking_plant = table.deepcopy(coking_plant)
coking_plant.name = "apm_coking_plant_2"
coking_plant.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_cp
}
coking_plant.minable = { mining_time = 0.2, result = "apm_coking_plant_2" }
coking_plant.crafting_speed = 2
coking_plant.crafting_categories = { "apm_coking", "apm_coking_2", "apm_coking_3" }
coking_plant.next_upgrade = nil
coking_plant.energy_usage = apm.power.constants.energy_usage.coking_plant_2
coking_plant.module_specification = apm.power.constants.modules.specification_2
coking_plant.allowed_effects = apm.power.constants.modules.allowed_effects_2

coking_plant.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'apm_refined_chemical' },
	apm.power.constants.emissions.cp_2,
	apm.lib.utils.builders.smoke.burner.t12
)

coking_plant.graphics_set.animation_progress = base_animation_progress / coking_plant.crafting_speed

coking_plant.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_2.png"
coking_plant.graphics_set.idle_animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/coking_plant/hr_coking_plant_idle_2.png"

coking_plant.graphics_set.animation_progress = 0.133333335

coking_plant.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_4way(apm.lib.utils.pipecovers.assembler3pipepictures())

data:extend({ coking_plant })
