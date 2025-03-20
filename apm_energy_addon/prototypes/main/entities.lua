require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/entities.lua'

APM_LOG_HEADER(self)

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.AssemblingMachinePrototype
local charging_station = {}
charging_station.type = "assembling-machine"
charging_station.name = "apm_battery_charging_station"

charging_station.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_lightning,
	apm.lib.icons.dynamics.recycling
}

charging_station.flags = { "placeable-neutral", "placeable-player", "player-creation" }

charging_station.minable = { mining_time = 0.2, result = "apm_battery_charging_station" }

charging_station.crafting_categories = { "apm_electric_charging" }
charging_station.crafting_speed = 1

charging_station.fast_replaceable_group = "apm_battery_charging_station"
charging_station.next_upgrade = nil

charging_station.max_health = 500

charging_station.corpse = "big-remnants"
charging_station.dying_explosion = "medium-explosion"
charging_station.resistances = { { type = "fire", percent = 90 } }

charging_station.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
charging_station.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

charging_station.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
charging_station.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

charging_station.module_slots = 0
charging_station.allowed_effects = nil

charging_station.working_sound = {
	main_sounds = {
		{
			sound = { filename = "__base__/sound/furnace.ogg" },
		}
	},
}

charging_station.energy_usage = apm.energy_addon.constants.energy_usage_charging_station

charging_station.energy_source = apm.lib.utils.builders.energy_source.new_electric({})

charging_station.graphics_set = {
	animation_progress = 0.16666667,

	animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_0.png",
				priority = "high",
				width = 320,
				height = 256,
				line_length = 5,
				frame_count = 5,
				scale = 0.5,
				shift = { 0.4375, -0.28125 },
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				line_length = 5,
				frame_count = 5,
				scale = 0.5,
				shift = { 0.4375, -0.28125 },
			},
		},
	},

	idle_animation = {
		layers = {
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_idle_0.png",
				priority = "high",
				width = 320,
				height = 256,
				line_length = 5,
				frame_count = 5,
				scale = 0.5,
				shift = { 0.4375, -0.28125 },
			},
			{
				filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_shadow.png",
				priority = "high",
				draw_as_shadow = true,
				width = 320,
				height = 256,
				line_length = 5,
				frame_count = 5,
				scale = 0.5,
				shift = { 0.4375, -0.28125 },
			},
		},
	},

	working_visualisations = {
		{
			light = { intensity = 0.6, size = 9.9, shift = { 0.0, 0.0 }, color = { r = 1.0, g = 0.5, b = 0.0 } },
		},
	},
}

charging_station.circuit_connector = apm.lib.utils.assembler.get.default_circuit_connector()
charging_station.circuit_wire_max_distance = apm.lib.utils.assembler.get.default_circuit_wire_max_distance()

--- TODO: adding glow & lightning ...

data:extend({ charging_station })

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.BurnerGeneratorPrototype
local discharging_station = {
	type = "burner-generator",
	name = "apm_battery_discharging_station",

	burner = {
		type                 = "burner",
		fuel_inventory_size  = 2,
		burnt_inventory_size = 2,
		effectivity          = 0.95,
		fuel_categories      = { "apm_electrical" }
	},

	energy_source = {
		type = "electric",
		usage_priority = "secondary-output",
	},

	max_power_output = "10000kW",
}

discharging_station.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_lightning
}

discharging_station.flags = { "placeable-neutral", "placeable-player", "player-creation" }

discharging_station.minable = { mining_time = 0.2, result = "apm_battery_discharging_station" }
discharging_station.fast_replaceable_group = "burner-generator"
discharging_station.next_upgrade = nil

discharging_station.max_health = 500
discharging_station.corpse = "big-remnants"
discharging_station.dying_explosion = "medium-explosion"
discharging_station.resistances = { { type = "fire", percent = 90 } }

discharging_station.collision_box = { { -1.2, -1.2 }, { 1.2, 1.2 } }
discharging_station.selection_box = { { -1.5, -1.5 }, { 1.5, 1.5 } }

discharging_station.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
discharging_station.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }

discharging_station.working_sound = {
	main_sounds = {
		sound = { filename = "__base__/sound/furnace.ogg" },
	},
}

discharging_station.animation = {
	animation_speed = 0.16666667,

	layers = {
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_0.png",
			priority = "high",
			width = 320,
			height = 256,
			frame_count = 5,
			line_length = 5,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
		},
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_shadow.png",
			priority = "high",
			draw_as_shadow = true,
			width = 320,
			height = 256,
			frame_count = 5,
			line_length = 5,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
		},
	},
}

-- TODO: append glow/ligth layer...


discharging_station.idle_animation = {
	animation_speed = 0.16666667,

	layers = {
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_idle_0.png",
			priority = "high",
			width = 320,
			height = 256,
			frame_count = 5,
			line_length = 5,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
		},
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/charging_station/hr_charging_station_shadow.png",
			priority = "high",
			draw_as_shadow = true,
			width = 320,
			height = 256,
			frame_count = 5,
			line_length = 5,
			shift = { 0.4375, -0.28125 },
			scale = 0.5,
		},
	},
}

data:extend({ discharging_station })
