require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/entities.lua'

APM_LOG_HEADER(self)

---@type data.SmokePrototype
local smoke_burner = {}
local smoke_position = { 0.30, -2.15 }
smoke_burner[1] = {}
smoke_burner[1].name = "apm_dark_smoke"
smoke_burner[1].deviation = { 0.1, 0.1 }
smoke_burner[1].frequency = 10
smoke_burner[1].position = nil
smoke_burner[1].north_position = smoke_position
smoke_burner[1].south_position = smoke_position
smoke_burner[1].east_position = smoke_position
smoke_burner[1].west_position = smoke_position
smoke_burner[1].starting_vertical_speed = 0.08
smoke_burner[1].starting_frame_deviation = 60
smoke_burner[1].slow_down_factor = 1


--- [apm_recycling_machine_0]
---@type data.AssemblingMachinePrototype
local recycler = {}
recycler.type = "assembling-machine"
recycler.name = "apm_recycling_machine_0"

recycler.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_r
}

recycler.flags = { "placeable-neutral", "placeable-player", "player-creation" }
recycler.minable = { mining_time = 0.2, result = "apm_recycling_machine_0" }
recycler.crafting_categories = { "apm_recycling_1" }
recycler.crafting_speed = 0.5
recycler.max_health = 250
recycler.corpse = "big-remnants"
recycler.dying_explosion = "medium-explosion"
recycler.fast_replaceable_group = "apm_recycling_machines"
recycler.next_upgrade = "apm_recycling_machine_2"
recycler.resistances = { { type = "fire", percent = 90 } }
recycler.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
recycler.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

recycler.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
recycler.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

recycler.working_sound = { filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.8 }

recycler.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ "chemical" },
	nil,
	smoke_burner
)

recycler.energy_usage = "350kW"
recycler.module_slots = 0
recycler.allowed_effects = { "consumption", "pollution", "speed" }

recycler.graphics_set = {
	animation_progress = 1.0666667,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 64,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_burner_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				frame_count = 64,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			}
		},
	},
}

recycler.fluid_boxes = {
	apm.lib.utils.builders.fluid_box.new(
		"input",
		500,
		apm.lib.utils.pipecovers.assembler1pipepictures(),
		defines.direction.north,
		{ 0, -1 },
		{ north = -1 }
	),
	apm.lib.utils.builders.fluid_box.new(
		"input",
		500,
		apm.lib.utils.pipecovers.assembler1pipepictures(),
		defines.direction.west,
		{ -1, 0 },
		{ north = -1 }
	),
	apm.lib.utils.builders.fluid_box.new(
		"output",
		500,
		apm.lib.utils.pipecovers.assembler1pipepictures(),
		defines.direction.south,
		{ 0, 1 },
		{ north = -1 }
	),
	apm.lib.utils.builders.fluid_box.new(
		"output",
		500,
		apm.lib.utils.pipecovers.assembler1pipepictures(),
		defines.direction.east,
		{ 1, 0 },
		{ north = -1 }
	),
}

data:extend({ recycler })

--- [apm_recycling_machine_1]
---@type data.AssemblingMachinePrototype
recycler = table.deepcopy(recycler)
recycler.name = "apm_recycling_machine_1"
--recycler.icon = "__apm_resource_pack_ldinc__/graphics/icons/apm_recycling_machine_1.png"
recycler.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_r
}
recycler.minable = { mining_time = 0.2, result = "apm_recycling_machine_1" }
recycler.crafting_speed = 1
recycler.crafting_categories = { "apm_recycling_1", "apm_recycling_2" }
recycler.next_upgrade = "apm_recycling_machine_1"
recycler.max_health = 350
recycler.energy_usage = "500kW"
recycler.module_slots = 1
recycler.energy_source = {
	type = "electric",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 2.5 },
}

recycler.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_1.png"
recycler.graphics_set.animation.layers[2].filename =
"__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_shadow.png"

recycler.fluid_boxes[1].pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()
recycler.fluid_boxes[2].pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()
recycler.fluid_boxes[3].pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()
recycler.fluid_boxes[4].pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures()

data:extend({ recycler })

recycler = table.deepcopy(recycler)
recycler.name = "apm_recycling_machine_2"

recycler.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_r
}
recycler.minable = { mining_time = 0.2, result = "apm_recycling_machine_2" }
recycler.crafting_speed = 1.5
recycler.crafting_categories = { "apm_recycling_1", "apm_recycling_2", "apm_recycling_3" }
recycler.next_upgrade = "apm_recycling_machine_3"
recycler.max_health = 350
recycler.energy_usage = "650kW"
recycler.module_slots = 2

recycler.energy_source = {
	type = "electric",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 1.75 },
}

recycler.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_2.png"
recycler.graphics_set.animation.layers[2].filename =
"__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_shadow.png"

recycler.fluid_boxes[1].pipe_picture = apm.lib.utils.pipecovers.assembler3pipepictures()
recycler.fluid_boxes[2].pipe_picture = apm.lib.utils.pipecovers.assembler3pipepictures()
recycler.fluid_boxes[3].pipe_picture = apm.lib.utils.pipecovers.assembler3pipepictures()
recycler.fluid_boxes[4].pipe_picture = apm.lib.utils.pipecovers.assembler3pipepictures()

data:extend({ recycler })


--- [apm_recycling_machine_2]
---@type data.AssemblingMachinePrototype
recycler = table.deepcopy(recycler)
recycler.name = "apm_recycling_machine_3"
--recycler.icon = "__apm_resource_pack_ldinc__/graphics/icons/apm_recycling_machine_3.png"
recycler.icons = {
	apm.lib.icons.dynamics.machine.t3,
	apm.lib.icons.dynamics.lable_r
}
recycler.minable = { mining_time = 0.2, result = "apm_recycling_machine_3" }
recycler.crafting_speed = 2
recycler.crafting_categories = { "apm_recycling_1", "apm_recycling_2", "apm_recycling_3", "apm_recycling_4" }
recycler.next_upgrade = nil
recycler.max_health = 500
recycler.energy_usage = "800kW"
recycler.module_slots = 3
recycler.energy_source = {
	type = "electric",
	usage_priority = "secondary-input",
	emissions_per_minute = { pollution = 1 },
}

recycler.graphics_set.animation.layers[1].filename = "__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_3.png"
recycler.graphics_set.animation.layers[2].filename = "__apm_resource_pack_ldinc__/graphics/entities/recycler/hr_recycler_shadow.png"

recycler.fluid_boxes[1].pipe_picture = apm.lib.utils.pipecovers.assembler4pipepictures()
recycler.fluid_boxes[2].pipe_picture = apm.lib.utils.pipecovers.assembler4pipepictures()
recycler.fluid_boxes[3].pipe_picture = apm.lib.utils.pipecovers.assembler4pipepictures()
recycler.fluid_boxes[4].pipe_picture = apm.lib.utils.pipecovers.assembler4pipepictures()

data:extend({ recycler })
