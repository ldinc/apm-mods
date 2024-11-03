require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/assembling_machines.lua'

APM_LOG_HEADER(self)

-- Smoke definitions ----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
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

assembling_machine.energy_source = {
	type = "burner",
	fuel_categories = { 'chemical', 'apm_refined_chemical' },
	effectivity = 1,
	fuel_inventory_size = 1,
	burnt_inventory_size = 1,
	emissions_per_minute = apm.power.constants.emissions.t0,
	smoke = smoke_burner,
}

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

assembling_machine.fluid_boxes = {
	{
		volume = 1000,
		production_type = "input",
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{
				flow_direction = "input",
				direction = defines.direction.south,
				position = { 0, 1 },
			},
		},
		secondary_draw_orders = { north = -1 }
	}
}

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

assembling_machine.energy_source = {
	type = "fluid",
	fluid_box = {
		volume = 1000,
		production_type = "input",

		filter = "steam",
		minimum_temperature = 100.0,
		maximum_temperature = 1000.0,
		burns_fluid = false,
		scale_fluid_usage = true,
		emissions_per_minute = apm.power.constants.emissions.t1,
		smoke = smoke_steam,


		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{
				flow_direction = "input",
				direction = defines.direction.north,
				position = { 0, -1 },
			},
		},
		secondary_draw_orders = { north = -1 },
	},
}

-- patch animation
assembling_machine.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/assembling_machine/hr_assembling_machine_1.png"

assembling_machine.fluid_boxes = {
	{
		production_type = "output",
		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		volume = 1000,
		pipe_connections = { { flow_direction = "output", direction = defines.direction.east, position = { 1, 0 } } },
		secondary_draw_orders = { north = -1 },
	},
	{
		production_type = "input",
		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		volume = 1000,
		pipe_connections = { { flow_direction = "output", direction = defines.direction.west, position = { -1, 0 } } },
		secondary_draw_orders = { north = -1 },
	},
}

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
