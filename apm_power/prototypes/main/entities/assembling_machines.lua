require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local self = "apm_power/prototypes/main/assembling_machines.lua"

APM_LOG_HEADER(self)

local base_animation_progress = 1.0666667

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.AssemblingMachinePrototype
local assembling_machine = {

	type = "assembling-machine",
	name = "apm_assembling_machine_0",
	icons = {
		apm.lib.icons.dynamics.machine.t0,
		apm.lib.icons.dynamics.lable_a
	},

	flags = { "placeable-neutral", "placeable-player", "player-creation" },
	minable = { mining_time = 0.2, result = "apm_assembling_machine_0" },
	crafting_categories = { "crafting", "basic-crafting" },
	crafting_speed = 0.5,
	fast_replaceable_group = "assembling-machine",
	next_upgrade = "apm_assembling_machine_1",
	max_health = 250,
	corpse = "big-remnants",
	dying_explosion = "medium-explosion",
	resistances = { { type = "fire", percent = 90 } },
	collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } },
	selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } },
	-- assembling_machine.light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } }
	open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
	close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },

	working_sound = {
		main_sounds = {
			{ sound = { filename = "__base__/sound/assembling-machine-t1-1.ogg", volume = 0.8 } },
			{ sound = { filename = "__base__/sound/assembling-machine-t1-2.ogg", volume = 0.8 } },
		},
		idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
	},

	-- assembling_machine.working_sound.apparent_volume = 1.5
	energy_usage = apm.power.constants.energy_usage.burner,
	module_slots = apm.power.constants.modules.specification_0.module_slots,
	allowed_effects = apm.power.constants.modules.allowed_effects_0,

	energy_source = apm.lib.utils.builders.energy_source.new_burner({ "chemical", "apm_refined_chemical" }),

}


assembling_machine.graphics_set = {
	animation_progress = base_animation_progress / assembling_machine.crafting_speed,
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

assembling_machine.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ assembling_machine })

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.AssemblingMachinePrototype
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
assembling_machine.module_slots = apm.power.constants.modules.specification_1.module_slots
assembling_machine.allowed_effects = apm.power.constants.modules.allowed_effects_1
assembling_machine.fast_replaceable_group = "assembling-machine"
assembling_machine.next_upgrade = "assembling-machine-1"

assembling_machine.energy_source = apm.lib.utils.builders.energy_source.new_steam(apm.power.constants.emissions.t1)

assembling_machine.graphics_set.animation_progress = base_animation_progress / assembling_machine.crafting_speed

-- patch animation
assembling_machine.graphics_set.animation.layers[1].filename =
"__apm_resource_pack_ldinc__/graphics/entities/assembling_machine/hr_assembling_machine_1.png"

assembling_machine.fluid_boxes = apm.lib.utils.builders.fluid_boxes.new_2way(
	apm.lib.utils.pipecovers.assembler2pipepictures()
)

assembling_machine.fluid_boxes_off_when_no_fluid_recipe = true
data:extend({ assembling_machine })

-- Settings -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if settings.startup["apm_power_steam_assembler_craftin_with_fluids"].value then
	apm.lib.utils.assembler.mod.category.add("apm_assembling_machine_1", "crafting-with-fluid")
	apm.lib.utils.assembler.mod.category.add("apm_assembling_machine_0", "crafting-with-fluid")
end
