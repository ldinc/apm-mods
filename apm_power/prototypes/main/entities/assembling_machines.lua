require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/assembling_machines.lua'

APM_LOG_HEADER(self)

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local assembling_machine = {}
assembling_machine.type = "assembling-machine"
assembling_machine.name = "apm_assembling_machine_0"
assembling_machine.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_a
}

assembling_machine.flags = { "placeable-neutral", "placeable-player", "player-creation" }
assembling_machine.minable = { mining_time = 0.2, result = "apm_assembling_machine_0" }
assembling_machine.crafting_categories = { "crafting", "basic-crafting" }
assembling_machine.crafting_speed = 0.5
assembling_machine.fast_replaceable_group = "assembling-machine"
assembling_machine.next_upgrade = "apm_assembling_machine_1"
assembling_machine.max_health = 250
assembling_machine.corpse = "big-remnants"
assembling_machine.dying_explosion = "medium-explosion"
assembling_machine.resistances = { { type = "fire", percent = 90 } }
assembling_machine.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
assembling_machine.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }
assembling_machine.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
assembling_machine.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
assembling_machine.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
assembling_machine.vehicle_impact_sound = { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 }
assembling_machine.working_sound = {}
assembling_machine.working_sound.sound = {
	{ filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 },
	{ filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 },
}
assembling_machine.working_sound.idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 }
assembling_machine.working_sound.apparent_volume = 1.5
assembling_machine.energy_usage = apm.power.constants.energy_usage.burner
assembling_machine.module_specification = apm.power.constants.modules.specification_0
assembling_machine.allowed_effects = apm.power.constants.modules.allowed_effects_0

assembling_machine.energy_source = apm.lib.utils.builders.energy_source.new_burner({ 'chemical', 'apm_refined_chemical' })

assembling_machine.graphics_set = {
	animation_progress = 1.0666667,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/assembling_machine/hr_assembling_machine_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 32,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/assembling_machine/hr_assembling_machine_shadow.png",
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

assembling_machine.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_input_s()
	-- {
	-- 	volume = 1000,
	-- 	production_type = "input",
	-- 	pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures(),
	-- 	pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
	-- 	pipe_connections = {
	-- 		{
	-- 			flow_direction = "input",
	-- 			direction = defines.direction.south,
	-- 			position = { 0, 1 },
	-- 		},
	-- 	},
	-- 	secondary_draw_orders = { north = -1 }
	-- }

assembling_machine.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ assembling_machine })

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local assembling_machine = table.deepcopy(assembling_machine)
assembling_machine.name = "apm_assembling_machine_1"
assembling_machine.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_a
}
assembling_machine.minable = { mining_time = 0.2, result = "apm_assembling_machine_1" }
assembling_machine.crafting_categories = { "crafting", "advanced-crafting", "basic-crafting" }
assembling_machine.crafting_speed = 0.75
assembling_machine.energy_usage = apm.power.constants.energy_usage.steam
assembling_machine.module_specification = apm.power.constants.modules.specification_1
assembling_machine.allowed_effects = apm.power.constants.modules.allowed_effects_1
assembling_machine.fast_replaceable_group = "assembling-machine"
assembling_machine.next_upgrade = "assembling-machine-1"
assembling_machine.light = nil

assembling_machine.energy_source = apm.lib.utils.builders.energy_source.new_steam(apm.power.constants.emissions.t1)

-- patch animation
assembling_machine.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/assembling_machine/hr_assembling_machine_1.png"

assembling_machine.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

	-- {
	-- 	production_type = "output",
	-- 	pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
	-- 	pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
	-- 	volume = 1000,
	-- 	pipe_connections = { { flow_direction = "output", direction = defines.direction.east, position = { 1, 0 } } },
	-- 	secondary_draw_orders = { north = -1 },
	-- },
	-- {
	-- 	production_type = "input",
	-- 	pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
	-- 	pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
	-- 	volume = 1000,
	-- 	pipe_connections = { { flow_direction = "output", direction = defines.direction.west, position = { -1, 0 } } },
	-- 	secondary_draw_orders = { north = -1 },
	-- },

assembling_machine.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ assembling_machine })

-- Settings -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if settings.startup["apm_power_steam_assembler_craftin_with_fluids"].value then
	apm.lib.utils.assembler.mod.category.add('apm_assembling_machine_1', 'crafting-with-fluid')
	apm.lib.utils.assembler.mod.category.add('apm_assembling_machine_0', 'crafting-with-fluid')
end
