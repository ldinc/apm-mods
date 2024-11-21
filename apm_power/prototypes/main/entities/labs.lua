require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/labs.lua'

APM_LOG_HEADER(self)

local base_animation_progress = 0.5333334

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ -0.65, -2.15 },
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
		{ -0.65, -2.15 },
		nil,
		0.08,
		60,
		1
	)
}

--- [apm_lab_0]
---@type data.LabPrototype
local lab = {}
lab.type = "lab"
lab.name = "apm_lab_0"
lab.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_l
}
lab.localised_description = { "entity-description.apm_lab_0" }
lab.flags = { "placeable-player", "player-creation" }
lab.minable = { mining_time = 0.2, result = "apm_lab_0" }
lab.max_health = 250
lab.corpse = "big-remnants"
lab.dying_explosion = "medium-explosion"
lab.resistances = { { type = "fire", percent = 90 } }
lab.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
lab.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
lab.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
lab.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
lab.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

lab.working_sound = { filename = "__base__/sound/lab.ogg", volume = 0.8 }
lab.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
lab.working_sound.apparent_volume = 1.5
lab.energy_usage = apm.power.constants.energy_usage.lab_0
lab.module_slots = apm.power.constants.modules.specification_0.module_slots
lab.allowed_effects = apm.power.constants.modules.allowed_effects_0
lab.researching_speed = 1
lab.fast_replaceable_group = "lab"
lab.next_upgrade = "apm_lab_1"
lab.inputs = {
	"apm_industrial_science_pack",
	"apm_steam_science_pack",
}

lab.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.lab_0,
	smoke_burner
)

lab.on_animation = {
	layers = {
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_0.png",
			priority = "high",
			width = 320,
			height = 256,
			frame_count = 64,
			line_length = 8,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
			run_mode = 'forward-then-backward',
			animation_speed = base_animation_progress / lab.researching_speed,
		},
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_shadow.png",
			priority = "high",
			draw_as_shadow = true,
			width = 320,
			height = 256,
			frame_count = 64,
			line_length = 8,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
			run_mode = 'forward-then-backward',
			animation_speed = base_animation_progress / lab.researching_speed,
		}
	},
}

lab.off_animation = {
	layers = {
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_0.png",
			priority = "high",
			width = 320,
			height = 256,
			frame_count = 1,
			line_length = 8,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
			run_mode = 'forward-then-backward',
			animation_speed = base_animation_progress / lab.researching_speed,
		},
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_shadow.png",
			priority = "high",
			draw_as_shadow = true,
			width = 320,
			height = 256,
			fframe_count = 1,
			line_length = 8,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
			run_mode = 'forward-then-backward',
			animation_speed = base_animation_progress / lab.researching_speed,
		}
	},
}

data:extend({ lab })

--- [apm_lab_0]
---@type data.LabPrototype
local lab = table.deepcopy(lab)
lab.name = "apm_lab_1"
lab.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_l
}
lab.localised_description = { "entity-description.apm_lab_1" }
lab.minable = { mining_time = 0.2, result = "apm_lab_1" }
lab.light = nil
lab.energy_usage = apm.power.constants.energy_usage.lab_2
lab.module_slots = apm.power.constants.modules.specification_1.module_slots
lab.allowed_effects = apm.power.constants.modules.allowed_effects_1
lab.fast_replaceable_group = "lab"
lab.next_upgrade = "lab"
lab.inputs = {
	"apm_industrial_science_pack",
	"apm_steam_science_pack",
	"automation-science-pack",
	"logistic-science-pack",
	"chemical-science-pack",
	"military-science-pack",
	"production-science-pack",
	"utility-science-pack",
}

lab.energy_source = apm.lib.utils.builders.energy_source.new_steam(
	apm.power.constants.emissions.lab_1,
	smoke_steam,
	apm.lib.utils.builders.fluid_box.new_steam_input_4way()
)

lab.on_animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/lab/hr_lab_1.png"

lab.off_animation = table.deepcopy(lab.on_animation)
lab.off_animation.layers[1].frame_count = 1
lab.off_animation.layers[2].frame_count = 1

data:extend({ lab })
