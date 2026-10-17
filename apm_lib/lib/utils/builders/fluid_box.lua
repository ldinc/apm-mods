require "util"
require("lib.log")

---@param volume number?
function apm.lib.utils.builders.fluid_box.new_steam_input(volume)
	if volume == nil then
		volume = 100
	end

	return
	{
		volume = volume,
		filter = "steam",
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
	}
end

---@param volume number?
function apm.lib.utils.builders.fluid_box.new_steam_input_3way(volume)
	if volume == nil then
		volume = 1000
	end

	return {
		volume = volume,
		production_type = "input",
		filter = "steam",

		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{
				flow_direction = "input-output",
				direction = defines.direction.east,
				position = { 1, 0 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.south,
				position = { 0, 1 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.west,
				position = { -1, 0 },
			},
		},
		secondary_draw_orders = { north = -1 },
	}
end

---@param volume number?
function apm.lib.utils.builders.fluid_box.new_steam_input_4way(volume)
	if volume == nil then
		volume = 1000
	end

	return {
		volume = volume,
		production_type = "input",
		filter = "steam",

		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{
				flow_direction = "input-output",
				direction = defines.direction.north,
				position = { 0, -1 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.east,
				position = { 1, 0 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.south,
				position = { 0, 1 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.west,
				position = { -1, 0 },
			},
		},
		secondary_draw_orders = { north = -1 },
	}
end

function apm.lib.utils.builders.fluid_box.new_input(volume)
	if volume == nil then
		volume = 1000
	end

	return {
		volume = volume,
		production_type = "input",
		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{ flow_direction = "input", direction = defines.direction.east, position = { 1, 0 } },
		},
		secondary_draw_orders = { north = -1 },
	}
end

function apm.lib.utils.builders.fluid_box.new_output(volume)
	if volume == nil then
		volume = 1000
	end

	return {
		volume = volume,
		production_type = "output",
		pipe_picture = apm.lib.utils.pipecovers.assembler2pipepictures(),
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		pipe_connections = {
			{ flow_direction = "output", direction = defines.direction.west, position = { -1, 0 } },
		},
		secondary_draw_orders = { north = -1 },
	}
end

function apm.lib.utils.builders.fluid_box.new(ptype, volume, pipe_picture, direction, position, secondary_draw_orders,
																							filter)
	if not ptype then
		ptype = "input"
	end

	if not volume then
		volume = 1000
	end

	if not pipe_picture then
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures()
	end

	if not direction then
		direction = defines.direction.north
	end

	if not position then
		position = { 0, -1 }
	end

	if not secondary_draw_orders then
		secondary_draw_orders = { north = -1 }
	end

	return {
		filter = filter,
		production_type = ptype,
		pipe_picture = pipe_picture,
		pipe_covers = apm.lib.utils.pipecovers.pipecoverspictures(),
		volume = volume,
		pipe_connections = {
			{
				flow_direction = ptype,
				direction = direction,
				position = position
			},
		},
		secondary_draw_orders = secondary_draw_orders
	}
end
