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

---@type data.StorageTankPrototype
local tank = {}
tank.type = "storage-tank"
tank.name = "apm_inline_storage_tank"
tank.icons = { sprites.icon }
tank.localised_description = { "entity-description.apm_inline_storage_tank" }

tank.flags = { "placeable-neutral", "placeable-player", "player-creation" }
tank.minable = { mining_time = 0.2, result = "apm_inline_storage_tank" }
tank.max_health = 400
tank.corpse = "small-remnants"
tank.dying_explosion = "medium-explosion"
tank.repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" }
tank.mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" }
tank.open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 }
tank.close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 }
tank.next_upgrade = nil

tank.fast_replaceable_group = "pipe"
tank.resistances = { { type = "fire", percent = 95 } }

tank.collision_box = { { -0.45, -0.45 }, { 0.45, 0.45 } }
tank.selection_box = { { -0.5, -0.5 }, { 0.5, 0.5 } }

local pic = {
	layers = {
		{
			filename = sprites.base.path,
			priority = "high",
			width = sprites.base.w,
			height = sprites.base.h,
			scale = sprites.base.scale,
			shift = sprites.base.shift,
		},
		{
			filename = sprites.shadow.path,
			priority = "high",
			width = sprites.shadow.w,
			height = sprites.shadow.h,
			scale = sprites.shadow.scale,
			shift = sprites.shadow.shift,
			draw_as_shadow = true,
		},
	},
}

tank.pictures = {
	fluid_background  = empty,
	window_background = empty,
	flow_sprite       = empty,
	gas_flow          = empty,

	picture           =
	{
		north = pic,
		east = pic,
		south = pic,
		west = pic,
	},
}


local base_area = 30

tank.two_direction_only = false

tank.fluid_box =
{
	volume = 1000,
	pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
	pipe_picture = pipe_picture,
	pipe_connections =
	{
		{ direction = defines.direction.north, position = { 0, -0.001 } },
		{ direction = defines.direction.east,  position = { 0.001, 0 } },
		{ direction = defines.direction.south, position = { 0, 0.001 } },
		{ direction = defines.direction.west,  position = { -0.001, 0 } }
	},
	hide_connection_info = true,
}

if mods["space-age"] then
	tank.heating_energy = "100kW"

	tank.pictures.frozen_patch = {
		north = sprites.frozen_patch,
		south = sprites.frozen_patch,
		east = sprites.frozen_patch,
		west = sprites.frozen_patch,
	}

	tank.fluid_box.pipe_covers_frozen = apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
end

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
