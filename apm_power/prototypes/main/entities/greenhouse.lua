require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/greenhouse.lua'

APM_LOG_HEADER(self)

local base_animation_progress = 0.5333334

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		3.6,
		{ -0.70, -2.15 },
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
		1.8,
		{ -0.70, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

--- [apm_greenhouse_0]
---@type data.AssemblingMachinePrototype
local greenhouse = {}
greenhouse.type = "assembling-machine"
greenhouse.name = "apm_greenhouse_0"
greenhouse.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_gh
}
greenhouse.flags = { "placeable-neutral", "placeable-player", "player-creation" }
greenhouse.minable = { mining_time = 0.1, result = "apm_greenhouse_0" }
greenhouse.crafting_categories = { "apm_greenhouse" }
greenhouse.crafting_speed = 1
greenhouse.fast_replaceable_group = "apm_greenhouse"
greenhouse.next_upgrade = 'apm_greenhouse_1'
greenhouse.max_health = 150
greenhouse.corpse = "big-remnants"
greenhouse.dying_explosion = "medium-explosion"
greenhouse.resistances = { { type = "fire", percent = 90 } }
greenhouse.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
greenhouse.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
--greenhouse.light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}
greenhouse.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
greenhouse.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

greenhouse.working_sound = {
	filename = "__apm_resource_pack_ldinc__/sounds/ambient/greenhouse.ogg",
	volume = 0.8,
	apparent_volume = 1.5,
}

greenhouse.energy_usage = apm.power.constants.energy_usage.greenhouse_0
greenhouse.module_slots = apm.power.constants.modules.greenhouse.specification_0.module_slots
greenhouse.allowed_effects = apm.power.constants.modules.greenhouse.allowed_effects_0

greenhouse.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.gh_0,
	smoke_burner
)

greenhouse.graphics_set = {
	animation_progress = base_animation_progress / greenhouse.crafting_speed,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/greenhouse/hr_greenhouse_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 1,
				line_length = 1,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/greenhouse/hr_greenhouse_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 1,
				line_length = 1,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
		},
	},
}

greenhouse.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_input_s()

greenhouse.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ greenhouse })



--- [apm_greenhouse_1]
---@type data.AssemblingMachinePrototype
local greenhouse = table.deepcopy(greenhouse)
greenhouse.type = "assembling-machine"
greenhouse.name = "apm_greenhouse_1"
greenhouse.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_gh
}
greenhouse.localised_description = { "entity-description.apm_greenhouse" }
greenhouse.minable = { mining_time = 0.1, result = "apm_greenhouse_1" }
greenhouse.crafting_categories = { "apm_greenhouse" }
greenhouse.crafting_speed = 1.5
greenhouse.next_upgrade = nil
greenhouse.max_health = 250
greenhouse.energy_usage = apm.power.constants.energy_usage.greenhouse_1
greenhouse.module_slots = apm.power.constants.modules.greenhouse.specification_1.module_slots
greenhouse.allowed_effects = apm.power.constants.modules.greenhouse.allowed_effects_1

greenhouse.energy_source = apm.lib.utils.builders.energy_source.new_steam(
	apm.power.constants.emissions.gh_1,
	smoke_steam
)

animation_progress = base_animation_progress / greenhouse.crafting_speed

greenhouse.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/greenhouse/hr_greenhouse_1.png"

greenhouse.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_input_s(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

data:extend({ greenhouse })



--- [apm_greenhouse_2]
---@type data.AssemblingMachinePrototype
local greenhouse = table.deepcopy(greenhouse)
greenhouse.type = "assembling-machine"
greenhouse.name = "apm_greenhouse_2"
greenhouse.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_gh
}
greenhouse.minable = { mining_time = 0.1, result = "apm_greenhouse_2" }
greenhouse.crafting_categories = { "apm_greenhouse" }
greenhouse.crafting_speed = 2.25
greenhouse.next_upgrade = nil
greenhouse.max_health = 250
greenhouse.energy_usage = apm.power.constants.energy_usage.greenhouse_2
greenhouse.module_slots = apm.power.constants.modules.greenhouse.specification_2.module_slots
greenhouse.allowed_effects = apm.power.constants.modules.greenhouse.allowed_effects_2

greenhouse.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.gh_2,
	apm.power.constants.engery_drain.electric
)

animation_progress = base_animation_progress / greenhouse.crafting_speed

greenhouse.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/greenhouse/hr_greenhouse_2.png"

greenhouse.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_input_s(
	apm.lib.utils.pipecovers.assembler3pipepictures()
)

greenhouse.circuit_connector = apm.lib.utils.assembler.get.default_circuit_connector()
greenhouse.circuit_wire_max_distance = apm.lib.utils.assembler.get.default_circuit_wire_max_distance()

if mods["space-age"] then
	greenhouse.heating_energy = "650kW"

	greenhouse.graphics_set.reset_animation_when_frozen = true

	greenhouse.graphics_set.frozen_patch = {
		filename = "__apm_resource_pack_ldinc__/graphics/entities/greenhouse/hr_greenhouse_2-frozen.png",
		priority = "high",
		width = 320,
		height = 256,
		frame_count = 1,
		line_length = 1,
		shift = { 0.4375, -0.28125 },
		scale = 0.5,
	}

	greenhouse.fluid_boxes[1].pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()

	greenhouse.fluid_boxes[1].pipe_picture_frozen = apm.lib.utils.assembler.pipe_picture_frozen()
end

data:extend({ greenhouse })
