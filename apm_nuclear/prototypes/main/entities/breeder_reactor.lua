require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/entities/breeder_reactor.lua"

APM_LOG_HEADER(self)

local breeder_reactor = table.deepcopy(data.raw.reactor["nuclear-reactor"])

breeder_reactor.type = "reactor"
breeder_reactor.name = "apm_nuclear_breeder"
breeder_reactor.icons = {
	apm.nuclear.icons.breeder_reactor
}
--breeder_reactor.icon_size = apm.nuclear.icons.breeder_reactor.icon_size
breeder_reactor.flags = { "placeable-neutral", "placeable-player", "player-creation" }
breeder_reactor.minable = { mining_time = 0.5, result = "apm_nuclear_breeder" }

breeder_reactor.working_sound = {
	main_sounds = {
		sound = {
			filename = "__apm_resource_pack_ldinc__/sounds/entities/breeder_working.ogg",
			volume = 0.8,
			apparent_volume = 1.5,
		},
	}
}

breeder_reactor.consumption = "80MW"
breeder_reactor.neighbour_bonus = 0.5
breeder_reactor.energy_source = {
	type = "burner",
	fuel_categories = {"apm_nuclear_breeder"},
	effectivity = 1,
	fuel_inventory_size = 1,
	burnt_inventory_size = 1,
}

breeder_reactor.collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } }
breeder_reactor.selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } }

breeder_reactor.lower_layer_picture = {
	filename = "__apm_resource_pack_ldinc__/graphics/entities/breeder_reactor/hr_breeder_reactor_pipes.png",
	width = 320,
	height = 316,
	scale = 0.5,
	shift = util.by_pixel(-1, -5),
}

breeder_reactor.heat_lower_layer_picture = {
	filename = "__apm_resource_pack_ldinc__/graphics/entities/breeder_reactor/hr_breeder_reactor_pipes_hot.png",
	width = 320,
	height = 316,
	scale = 0.5,
	shift = util.by_pixel(-0.5, -4.5),
}

breeder_reactor.picture = {
	layers = {
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/breeder_reactor/hr_breeder_reactor.png",
			width = 480,
			height = 340,
			scale = 0.5,
			shift = { 1.375, 0 },
		},
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/breeder_reactor/hr_breeder_reactor_shadow.png",
			width = 480,
			height = 340,
			scale = 0.5,
			shift = { 1.375, 0 },
			draw_as_shadow = true,
		},
	},
}

breeder_reactor.working_light_picture = {
	filename = "__apm_resource_pack_ldinc__/graphics/entities/breeder_reactor/hr_breeder_reactor_glow.png",
	width = 480,
	height = 340,
	scale = 0.5,
	shift = { 1.375, 0 },
	blend_mode = "additive",
}

--breeder_reactor.light = {intensity = 0.6, size = 9.9, shift = {0.0, 0.0}, color = {r = 1.0, g = 0.5, b = 0.0}}

breeder_reactor.use_fuel_glow_color = true                                               -- should use glow color from fuel item prototype as light color and tint for working_light_picture
breeder_reactor.default_fuel_glow_color = { r = 1.000, g = 0.500, b = 0.000, a = 0.500 } --color used as working_light_picture tint for fuels that don"t have glow color defined

breeder_reactor.heat_buffer = {
	max_temperature = 1000,
	specific_heat = "10MJ",
	max_transfer = "10GW",
	minimum_glow_temperature = 350,
	glow_alpha_modifier = 0.6,
	connections = {
		{
			position = { -2, -2 },
			direction = defines.direction.north,
		},
		{
			position = { 0, -2 },
			direction = defines.direction.north,
		},
		{
			position = { 2, -2 },
			direction = defines.direction.north,
		},

		{
			position = { 2, -2 },
			direction = defines.direction.east,
		},
		{
			position = { 2, 0 },
			direction = defines.direction.east,
		},
		{
			position = { 2, 2 },
			direction = defines.direction.east,
		},

		{
			position = { 2, 2 },
			direction = defines.direction.south,
		},
		{
			position = { 0, 2 },
			direction = defines.direction.south,
		},
		{
			position = { -2, 2 },
			direction = defines.direction.south,
		},

		{
			position = { -2, 2 },
			direction = defines.direction.west,
		},
		{
			position = { -2, 0 },
			direction = defines.direction.west,
		},
		{
			position = { -2, -2 },
			direction = defines.direction.west,
		},
	},

}

data:extend({ breeder_reactor })
