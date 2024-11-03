require 'util'
require('lib.log')

local self = 'lib.utils.builders.fluid_boxes'

local _in = "input"
local _out = "output"

function apm.lib.utils.builders.fluid_boxes.new_4way(pipe_picture, volume)
	if not volume then
		volume = 1000
	end

	if not pipe_picture then
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures()
	end

	return {
		apm.lib.utils.builders.fluid_box.new(
			_in,
			volume,
			pipe_picture,
			defines.direction.south,
			{ 0, 1 },
			{ north = -1, south = 1 }
		),

		apm.lib.utils.builders.fluid_box.new(
			_out,
			volume,
			pipe_picture,
			defines.direction.north,
			{ 0, -1 },
			{ north = -1, south = 1 }
		),

		apm.lib.utils.builders.fluid_box.new(
			_in,
			volume,
			pipe_picture,
			defines.direction.east,
			{ 1, 0 },
			{ north = -1, south = 1 }
		),

		apm.lib.utils.builders.fluid_box.new(
			_out,
			volume,
			pipe_picture,
			defines.direction.west,
			{ -1, 0 },
			{ north = -1, south = 1 }
		),
	}
end

function apm.lib.utils.builders.fluid_boxes.new_2way(pipe_picture, volume)
	if not volume then
		volume = 1000
	end

	if not pipe_picture then
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures()
	end

	return {
		apm.lib.utils.builders.fluid_box.new(
			_in,
			volume,
			pipe_picture,
			defines.direction.east,
			{ 1, 0 },
			{ north = -1 }
		),

		apm.lib.utils.builders.fluid_box.new(
			_out,
			volume,
			pipe_picture,
			defines.direction.west,
			{ -1, 0 },
			{ north = -1 }
		),
	}
end

-- south oriented by default
function apm.lib.utils.builders.fluid_boxes.new_input_s(pipe_picture, volume)
	if not volume then
		volume = 1000
	end

	if not pipe_picture then
		pipe_picture = apm.lib.utils.pipecovers.assembler1pipepictures()
	end

	return {
		apm.lib.utils.builders.fluid_box.new(
			_in,
			volume,
			pipe_picture,
			defines.direction.south,
			{ 0, 1 },
			{ north = -1 }
		),
	}
end