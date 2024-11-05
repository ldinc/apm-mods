	require('util')
	require('__apm_lib_ldinc__.lib.log')
	require('__apm_lib_ldinc__.lib.utils')

	local default_circuit_wire_max_distance = 9

	local inline_storage_tank = require('graphics.inline_storage_tank')

	local sprites = inline_storage_tank

	local empty = {
		filename = "__core__/graphics/empty.png",
		priority = "extra-high",
		width = 1,
		height = 1
	}

	local pipe_picture =
	{
		north = empty,
		east = empty,
		south = sprites.pipe_picture.south,
		west = empty
	}

	local tank = {}
	tank.type = "storage-tank"
	tank.name = "apm_inline_storage_tank"
	tank.icons = { sprites.icon }
	tank.localised_description = { "entity-description.apm_inline_storage_tank" }
	--sinkhole.icon_size = 32
	tank.flags = { "placeable-neutral", "placeable-player", "player-creation" }
	tank.minable = { mining_time = 0.2, result = "apm_inline_storage_tank" }
	tank.max_health = 400
	tank.corpse = "small-remnants"
	tank.dying_explosion = "medium-explosion"
	tank.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
	tank.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
	tank.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
	tank.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
	tank.vehicle_impact_sound = { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 }
	tank.source_inventory_size = 0
	tank.result_inventory_size = 0
	tank.next_upgrade = nil

	tank.fast_replaceable_group = "pipe"
	tank.resistances = { { type = "fire", percent = 95 } }

	tank.collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } }
	tank.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

	local pic = {
		layers = {
			{
				filename = sprites.base.lr.path,
				priority = "high",
				width = sprites.base.lr.w,
				height = sprites.base.lr.h,
				scale = sprites.base.lr.scale,
				shift = sprites.base.lr.shift,
				hr_version = {
					filename = sprites.base.hr.path,
					priority = "high",
					width = sprites.base.hr.w,
					height = sprites.base.hr.h,
					scale = sprites.base.hr.scale,
					shift = sprites.base.hr.shift,
				},
			},
			{
				filename = sprites.shadow.lr.path,
				priority = "high",
				width = sprites.shadow.lr.w,
				height = sprites.shadow.lr.h,
				scale = sprites.shadow.lr.scale,
				shift = sprites.shadow.lr.shift,
				draw_as_shadow = true,
				hr_version = {
					filename = sprites.shadow.hr.path,
					priority = "high",
					width = sprites.shadow.hr.w,
					height = sprites.shadow.hr.h,
					scale = sprites.shadow.hr.scale,
					shift = sprites.shadow.hr.shift,
					draw_as_shadow = true,
				},
			},
		},
	}

	tank.pictures = {
		fluid_background  = empty,
		window_background = empty,
		flow_sprite       = empty,
		gas_flow          = empty,

		picture           = {
			north = pic,
			east = pic,
			south = pic,
			west = pic,
		}
	}


	local base_area = 30

	tank.two_direction_only = false

	tank.fluid_box =
	{
		volume = 1000,
		pipe_covers =apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_picture = pipe_picture,
		pipe_connections =
		{
			{ direction = defines.direction.north, position = {0, -0.001} },
			{ direction = defines.direction.east, position = {0.001, 0} },
			{ direction = defines.direction.south, position = {0, 0.001} },
			{ direction = defines.direction.west, position = {-0.001, 0} }
		},
		hide_connection_info = true
	}
	-- tank.fluid_box = {volume = 1000}
	-- tank.fluid_box.pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures()
	-- tank.fluid_box.pipe_picture = pipe_picture
	-- tank.fluid_box.base_area = base_area
	-- tank.fluid_box.base_level = 0
	-- tank.fluid_box.filter = ""
	-- tank.fluid_box.pipe_covers = pipecoverspictures()
	tank.hide_connection_info = true

	-- tank.fluid_box.pipe_connections = {
	-- 	{
	-- 		type = "input-output",
	-- 		position = { 0, 1 }
	-- 	},
	-- 	{
	-- 		type = "input-output",
	-- 		position = { 0, -1 },
	-- 	},
	-- 	{
	-- 		type = "input-output",
	-- 		position = { 1, 0 }
	-- 	},
	-- 	{
	-- 		type = "input-output",
	-- 		position = { -1, 0 },
	-- 	}
	-- }
	-- tank.fluid_box.secondary_draw_orders = { north = -1, south = 1, west = -1, east = 1 }

	tank.window_bounding_box = { util.by_pixel(-3, -5), util.by_pixel(3, 11) }

	tank.flow_length_in_ticks = 360


	circuit_connector_definitions["apm_inline_storage_tank"] = circuit_connector_definitions.create_vector
		(
			universal_connector_template,
			{
				{ variation = 27, main_offset = util.by_pixel(10, -18),  shadow_offset = util.by_pixel(6, -16),  show_shadow = false },
				{ variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false },
				{ variation = 27, main_offset = util.by_pixel(10, -18),  shadow_offset = util.by_pixel(6, -16),  show_shadow = false },
				{ variation = 25, main_offset = util.by_pixel(-10, -18), shadow_offset = util.by_pixel(-6, -16), show_shadow = false }
			}
		)

	tank.circuit_wire_connection_points = circuit_connector_definitions[tank.name].points
	tank.circuit_connector_sprites = circuit_connector_definitions[tank.name].sprites
	tank.circuit_wire_max_distance = default_circuit_wire_max_distance

	data:extend({ tank })
