require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/furnaces.lua'

APM_LOG_HEADER(self)

-- Smoke ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local smoke_puddling_furnace_position_a = { 0, -0.55 }
local smoke_puddling_furnace_position_b = { 0, -1.15 }
local smoke_puddling_furnace_position_c = { 0, -1.75 }

local smoke_puddling_furnace = {
	apm.lib.utils.builders.smoke.new(
		"light-smoke",
		{ 0.1, 0.1 },
		nil,
		4,
		smoke_puddling_furnace_position_a,
		0.08,
		60,
		1
	),

	apm.lib.utils.builders.smoke.new(
		"light-smoke",
		{ 0.1, 0.1 },
		nil,
		3.4,
		smoke_puddling_furnace_position_b,
		0.08,
		60,
		1
	),

	apm.lib.utils.builders.smoke.new(
		"light-smoke",
		{ 0.1, 0.1 },
		nil,
		2.8,
		smoke_puddling_furnace_position_c,
		0.08,
		60,
		1
	)
}

--- [apm_puddling_furnace_0]
---@type data.AssemblingMachinePrototype
local puddling_furnace = {}
puddling_furnace.type = "assembling-machine"
puddling_furnace.name = "apm_puddling_furnace_0"
puddling_furnace.icons = {
	apm.lib.icons.dynamics.machine.t0,
	apm.lib.icons.dynamics.lable_pf
}

puddling_furnace.flags = { "placeable-neutral", "placeable-player", "player-creation" }
puddling_furnace.minable = { mining_time = 0.2, result = "apm_puddling_furnace_0" }
puddling_furnace.crafting_categories = { "apm_puddling_furnace" }
puddling_furnace.crafting_speed = 1
puddling_furnace.fast_replaceable_group = "apm_steelworks"
puddling_furnace.next_upgrade = "apm_steelworks_0"
puddling_furnace.max_health = 250
puddling_furnace.corpse = "big-remnants"
puddling_furnace.dying_explosion = "medium-explosion"
puddling_furnace.resistances = { { type = "fire", percent = 90 } }
puddling_furnace.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
puddling_furnace.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

puddling_furnace.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
puddling_furnace.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

puddling_furnace.working_sound = {
	filename = "__base__/sound/electric-furnace.ogg" 
}

puddling_furnace.energy_usage = apm.power.constants.energy_usage.puddling_furnace_0
puddling_furnace.module_slots = apm.power.constants.modules.specification_0.module_slots
puddling_furnace.allowed_effects = apm.power.constants.modules.allowed_effects_0

puddling_furnace.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'apm_refined_chemical' },
	apm.power.constants.emissions.cp_0,
	smoke_puddling_furnace
)

puddling_furnace.graphics_set = {
	animation_progress = 0.26666667,
	animation          = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/puddling_furnace/hr_puddling_furnace_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/puddling_furnace/hr_puddling_furnace_shadow.png",
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
	idle_animation     = {
		layers = {
			{
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/puddling_furnace/hr_puddling_furnace_idle_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename =
				"__apm_resource_pack_ldinc__/graphics/entities/puddling_furnace/hr_puddling_furnace_shadow.png",
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
	}
}

puddling_furnace.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_input_s()

puddling_furnace.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ puddling_furnace })

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

--- [apm_steelworks_0]
---@type data.AssemblingMachinePrototype
local steelworks = {}
steelworks.type = "assembling-machine"
steelworks.name = "apm_steelworks_0"
steelworks.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_sw
}
--steelworks.icon_size = 32
steelworks.flags = { "placeable-neutral", "placeable-player", "player-creation" }
steelworks.minable = { mining_time = 0.2, result = "apm_steelworks_0" }
steelworks.crafting_categories = { "apm_steelworks" }
steelworks.crafting_speed = 2
steelworks.fast_replaceable_group = "apm_steelworks"
steelworks.next_upgrade = 'apm_steelworks_1'
steelworks.max_health = 250
steelworks.corpse = "big-remnants"
steelworks.dying_explosion = "medium-explosion"
steelworks.resistances = { { type = "fire", percent = 90 } }
steelworks.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
steelworks.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

steelworks.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
steelworks.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

steelworks.working_sound = { filename = "__base__/sound/furnace.ogg" }
steelworks.energy_usage = apm.power.constants.energy_usage.steelworks_0
steelworks.module_slots = apm.power.constants.modules.specification_2.module_slots
steelworks.allowed_effects = apm.power.constants.modules.allowed_effects_2

steelworks.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.cp_2,
	apm.power.constants.engery_drain.steelworks_0
)

steelworks.graphics_set = {
	animation_progress = 0.53333334,
	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_shadow.png",
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
				filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_idle_0.png",
				priority = "high",
				width = 320,
				height = 256,
				frame_count = 16,
				line_length = 8,
				shift = { 0.4375, -0.28125 },
				scale = 0.5,
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_shadow.png",
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
	working_visualisations = {
		{
			apply_recipe_tint = "tertiary",
			fadeout = true,
			constant_speed = true,
			north_position = util.by_pixel_hr(-12, -142),
			east_position = util.by_pixel_hr(-12, -142),
			south_position = util.by_pixel_hr(-12, -142),
			west_position = util.by_pixel_hr(-30, -167),
			render_layer = "wires",
			animation = {
				filename = "__base__/graphics/entity/chemical-plant/chemical-plant-smoke-outer.png",
				frame_count = 47,
				line_length = 16,
				width = 90,
				height = 188,
				animation_speed = 0.5,
				shift = util.by_pixel(-2, -40),
				scale = 0.5,
			},
		},
	},
}

steelworks.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_4way(
	apm.lib.utils.pipecovers.assembler3pipepictures()
)

steelworks.fluid_boxes_off_when_no_fluid_recipe = true

steelworks.circuit_connector = apm.lib.utils.assembler.get.default_circuit_connector()
steelworks.circuit_wire_max_distance = apm.lib.utils.assembler.get.default_circuit_wire_max_distance()

if mods["space-age"] then
	steelworks.heating_energy = "900kW"

	for i = 1,4,1 do
		steelworks.fluid_boxes[i].pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
		steelworks.fluid_boxes[i].pipe_picture_frozen = apm.lib.utils.assembler.pipe_picture_frozen()
	end

	steelworks.graphics_set.reset_animation_when_frozen = true

	steelworks.graphics_set.frozen_patch = {
		filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_frozen.png",
		priority = "high",
		width = 320,
		height = 256,
		shift = util.by_pixel(-1, -8),
		scale = 0.5,
	}
end

data:extend({ steelworks })

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

--- [apm_steelworks_1]
---@type data.AssemblingMachinePrototype
steelworks = table.deepcopy(steelworks)
steelworks.name = "apm_steelworks_1"
steelworks.icons = {
	apm.lib.icons.dynamics.machine.t3,
	apm.lib.icons.dynamics.lable_sw
}
steelworks.minable = { mining_time = 0.2, result = "apm_steelworks_1" }
steelworks.next_upgrade = nil
steelworks.max_health = 350
steelworks.energy_usage = apm.power.constants.energy_usage.steelworks_1
steelworks.module_slots = apm.power.constants.modules.specification_3.module_slots
steelworks.allowed_effects = apm.power.constants.modules.allowed_effects_3

steelworks.energy_source = apm.lib.utils.builders.energy_source.new_electric(
	apm.power.constants.emissions.cp_3,
	apm.power.constants.engery_drain.steelworks_1
)

steelworks.crafting_speed = 3

steelworks.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_1.png"


steelworks.graphics_set.idle_animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_idle_1.png"

steelworks.graphics_set.animation_progress = 0.33333334

steelworks.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_4way(
	apm.lib.utils.pipecovers.assembler4pipepictures()
)

steelworks.circuit_connector = apm.lib.utils.assembler.get.default_circuit_connector()
steelworks.circuit_wire_max_distance = apm.lib.utils.assembler.get.default_circuit_wire_max_distance()

if mods["space-age"] then
	steelworks.heating_energy = "900kW"

	for i = 1,4,1 do
		steelworks.fluid_boxes[i].pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
		steelworks.fluid_boxes[i].pipe_picture_frozen = apm.lib.utils.assembler.pipe_picture_frozen()
	end

	steelworks.graphics_set.reset_animation_when_frozen = true

	steelworks.graphics_set.frozen_patch = {
		filename = "__apm_resource_pack_ldinc__/graphics/entities/steelworks/hr_steelworks_frozen.png",
		priority = "high",
		width = 320,
		height = 256,
		frame_count = 16,
		line_length = 8,
		shift = util.by_pixel(-1, -8),
		scale = 0.5,
	}
end

data:extend({ steelworks })
