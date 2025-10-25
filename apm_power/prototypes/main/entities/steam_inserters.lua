require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local self = "apm_power/prototypes/main/steam_inserters.lua"

APM_LOG_HEADER(self)

local gpraphics_path = "__apm_resource_pack_ldinc__/graphics/entities/steam_inserter/"
local icon_path = "__apm_resource_pack_ldinc__/graphics/icons/"

local inserter = table.deepcopy(data.raw.inserter["burner-inserter"])
inserter.name = "apm_steam_inserter"
inserter.icon = icon_path .. "apm_steam_inserter.png"
inserter.minable = { mining_time = 0.1, result = "apm_steam_inserter" }
inserter.energy_per_movement = "6kJ"
inserter.energy_per_rotation = "60kJ"
inserter.hand_size = 1.0
inserter.extension_speed = 0.019 -- electric: 0.02
inserter.rotation_speed = 0.0149 -- electric: 0.0457
inserter.pickup_position = { 0, -1 }
inserter.insert_position = { 0, 1.1 }

local pipecovers = {
	north =
	{
		layers =
		{
			{
				filename = gpraphics_path .. "pipe-cover-north.png",
				-- filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(0, 4),
			},
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north-shadow.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(0, 0),
				draw_as_shadow = true,
			},
		},
	},

	east =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(-6, 0),
			},
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east-shadow.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(-6, 0),
				draw_as_shadow = true,
			},
		},
	},
	south =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(0, -2),
			},
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south-shadow.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(0, -2),
				draw_as_shadow = true
			},
		},
	},
	west =
	{
		layers =
		{
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(6, 0),
			},
			{
				filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west-shadow.png",
				width = 128,
				height = 128,
				scale = 0.5,
				shift = util.by_pixel(6, 0),
				draw_as_shadow = true
			},
		},
	},
}

inserter.energy_source = apm.lib.utils.builders.energy_source.new_steam(
	nil,
	nil,
	{
		filter = "steam",
		production_type = "input-output",
		pipe_covers = pipecovers,
		volume = 50,
		pipe_connections = {
			{
				flow_direction = "input-output",
				direction = defines.direction.north,
				position = { 0, -0.14 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.south,
				position = { 0, 0.14 },
			},
		},
		secondary_draw_orders = { north = -1 },
	},
	50,
	120,
	550
)



inserter.hand_base_picture.filename = gpraphics_path .. "hr-inserter-hand-base.png"

inserter.hand_closed_picture.filename = gpraphics_path .. "hr-inserter-hand-closed.png"

inserter.hand_open_picture.filename = gpraphics_path .. "hr-inserter-hand-open.png"

inserter.platform_picture = {
	north = {
		layers = {
			{
				filename = gpraphics_path .. "platform-vertical.png",
				scale = 0.5,
				height = 192,
				width = 256,
			},
			{
				filename = gpraphics_path .. "platform-vertical-shadow.png",
				scale = 0.5,
				height = 192,
				width = 256,
				draw_as_shadow = true,
			},
		},
	},
	west = {
		layers = {
			{
				filename = gpraphics_path .. "platform-horizontal.png",
				scale = 0.5,
				height = 192,
				width = 256,
			},
			{
				filename = gpraphics_path .. "platform-horizontal-shadow.png",
				scale = 0.5,
				height = 192,
				width = 256,
				draw_as_shadow = true,
			},
		},
	},

	east = {
		layers = {
			{
				filename = gpraphics_path .. "platform-horizontal.png",
				scale = 0.5,
				height = 192,
				width = 256,
			},
			{
				filename = gpraphics_path .. "platform-horizontal-shadow.png",
				scale = 0.5,
				height = 192,
				width = 256,
				draw_as_shadow = true,
			},
		},
	},
	south = {
		layers = {
			{
				filename = gpraphics_path .. "platform-vertical.png",
				scale = 0.5,
				height = 192,
				width = 256,
			},
			{
				filename = gpraphics_path .. "platform-vertical-shadow.png",
				scale = 0.5,
				height = 192,
				width = 256,
				draw_as_shadow = true,
			},
		},
	},
}

data:extend({ inserter })

--------------------------------------------------------------------------------

local inserter = table.deepcopy(data.raw.inserter["apm_steam_inserter"])
inserter.name = "apm_steam_inserter_long"
inserter.icon = icon_path .. "apm_steam_inserter_long.png"
inserter.minable = { mining_time = 0.1, result = "apm_steam_inserter_long" }
inserter.energy_per_movement = "6kJ"
inserter.energy_per_rotation = "60kJ"
inserter.hand_size = 1.0
inserter.extension_speed = 0.019 -- electric: 0.02
inserter.rotation_speed = 0.0149 -- electric: 0.0457
inserter.pickup_position = { 0, -2 }
inserter.insert_position = { 0, 2.2 }

local graphics_path = "__apm_resource_pack_ldinc__/graphics/entities/burner_long_inserter/"

inserter.hand_base_picture.filename = graphics_path .. "hr-inserter-hand-base.png"

inserter.hand_closed_picture.filename = graphics_path .. "hr-inserter-hand-closed.png"

inserter.hand_open_picture.filename = graphics_path .. "hr-inserter-hand-open.png"

data:extend({ inserter })

--- Patch pipes graphics

local patched_path = "__apm_resource_pack_ldinc__/graphics/entities/steam_inserter/pipe-patch/"
local pipe = data.raw["pipe"]["pipe"]

if pipe then
	pipe.pictures.cross.filename = patched_path .. "pipe-cross.png"
	pipe.pictures.straight_vertical.filename = patched_path .. "pipe-straight-vertical.png"
	pipe.pictures.straight_vertical_window.filename = patched_path .. "pipe-straight-vertical-window.png"
	pipe.pictures.t_down.filename = patched_path .. "pipe-t-down.png"
	pipe.pictures.t_left.filename = patched_path .. "pipe-t-left.png"
	pipe.pictures.t_right.filename = patched_path .. "pipe-t-right.png"
end

local pipe_to_ground = data.raw["pipe-to-ground"]["pipe-to-ground"]

if pipe_to_ground then
	pipe_to_ground.pictures.south.filename = patched_path .. "pipe-to-ground-down.png"
end
