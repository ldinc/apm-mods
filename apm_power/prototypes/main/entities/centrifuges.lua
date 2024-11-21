require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/centrifuges.lua'

APM_LOG_HEADER(self)

local base_animation_progress = 1.0666667

local smoke_burner = {}
--local smoke_position = {-0.77, -1.95}
local smoke_position = { -0.65, -2.15 }
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

local smoke_steam = table.deepcopy(smoke_burner)
smoke_steam[1].name = "light-smoke"
smoke_steam[1].frequency = 8

--- [apm_centrifuge_0]
---@type data.AssemblingMachinePrototype
local centrifuge = {}
centrifuge.type = "assembling-machine"
centrifuge.name = "apm_centrifuge_0"
centrifuge.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_ce
}
centrifuge.flags = { "placeable-neutral", "placeable-player", "player-creation" }
centrifuge.minable = { mining_time = 0.2, result = "apm_centrifuge_0" }
centrifuge.crafting_categories = { "apm_centrifuge_0" }
centrifuge.crafting_speed = 1
centrifuge.fast_replaceable_group = "apm_centrifuge"
centrifuge.next_upgrade = 'apm_centrifuge_1'
centrifuge.max_health = 250
centrifuge.corpse = "big-remnants"
centrifuge.dying_explosion = "medium-explosion"
centrifuge.resistances = { { type = "fire", percent = 90 } }
centrifuge.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
centrifuge.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

centrifuge.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
centrifuge.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

centrifuge.working_sound = {
	main_sounds = {
		{ sound = { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 } },
		{ sound = { filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 } },
	}
}

centrifuge.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
centrifuge.working_sound.apparent_volume = 1.5
centrifuge.energy_usage = apm.power.constants.energy_usage.burner
centrifuge.module_slots = apm.power.constants.modules.specification_0.module_slots
centrifuge.allowed_effects = apm.power.constants.modules.allowed_effects_0

centrifuge.energy_source = apm.lib.utils.builders.energy_source.new_burner({ 'chemical', 'apm_refined_chemical' })

centrifuge.graphics_set = {
	animation_progress = base_animation_progress / centrifuge.crafting_speed,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/centrifuge/hr_centrifuge_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 32,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/centrifuge/hr_centrifuge_shadow.png",
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

centrifuge.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way()

centrifuge.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ centrifuge })

--- [apm_centrifuge_1]
---@type data.AssemblingMachinePrototype
local centrifuge = table.deepcopy(centrifuge)
centrifuge.name = "apm_centrifuge_1"
centrifuge.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_ce
}
centrifuge.icon_size = 32
centrifuge.flags = { "placeable-neutral", "placeable-player", "player-creation" }
centrifuge.minable = { mining_time = 0.2, result = "apm_centrifuge_1" }
centrifuge.crafting_categories = { "apm_centrifuge_0", "apm_centrifuge_1" }
centrifuge.crafting_speed = 1.5
centrifuge.fast_replaceable_group = "apm_centrifuge"
centrifuge.next_upgrade = 'apm_centrifuge_2'
centrifuge.energy_usage = apm.power.constants.energy_usage.steam
centrifuge.module_slots = apm.power.constants.modules.specification_1.module_slots
centrifuge.allowed_effects = apm.power.constants.modules.allowed_effects_1

centrifuge.energy_source = apm.lib.utils.builders.energy_source.new_steam(apm.power.constants.emissions.t1)

centrifuge.graphics_set.animation_progress = base_animation_progress / centrifuge.crafting_speed

centrifuge.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/centrifuge/hr_centrifuge_1.png"

centrifuge.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

data:extend({ centrifuge })

--- [apm_centrifuge_2]
---@type data.AssemblingMachinePrototype
local centrifuge = table.deepcopy(centrifuge)
centrifuge.name = "apm_centrifuge_2"
centrifuge.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_ce
}
centrifuge.icon_size = 32
centrifuge.flags = { "placeable-neutral", "placeable-player", "player-creation" }
centrifuge.minable = { mining_time = 0.2, result = "apm_centrifuge_2" }
centrifuge.crafting_categories = { "apm_centrifuge_0", "apm_centrifuge_1", "apm_centrifuge_2" }
centrifuge.crafting_speed = 2
centrifuge.fast_replaceable_group = "apm_centrifuge"
centrifuge.next_upgrade = nil
centrifuge.energy_usage = apm.power.constants.energy_usage.electric
centrifuge.module_slots = apm.power.constants.modules.specification_2.module_slots
centrifuge.allowed_effects = apm.power.constants.modules.allowed_effects_2

centrifuge.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.t2,
	apm.power.constants.engery_drain.electric
)

centrifuge.graphics_set.animation_progress = base_animation_progress / centrifuge.crafting_speed

centrifuge.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/centrifuge/hr_centrifuge_2.png"

centrifuge.graphics_set.animation.layers[2].filename =
"__apm_resource_pack_ldinc__/graphics/entities/centrifuge/hr_centrifuge_shadow_2.png"

centrifuge.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler3pipepictures()
)

data:extend({ centrifuge })
