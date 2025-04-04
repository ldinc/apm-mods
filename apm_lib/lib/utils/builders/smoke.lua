require 'util'
require('lib.log')

local self = 'lib.utils.builders.smoke'

local smoke_position = { -0.65, -2.15 }

apm.lib.utils.builders.smoke.light = {
	name = "light-smoke",
	deviation = { 0.1, 0.1 },
	frequency = 8,
	position = nil,
	north_position = smoke_position,
	south_position = smoke_position,
	east_position = smoke_position,
	west_position = smoke_position,
	starting_vertical_speed = 0.08,
	starting_frame_deviation = 60,
	slow_down_factor = 1,
}


apm.lib.utils.builders.smoke.dark = {
	name = "apm_dark_smoke",
	deviation = { 0.1, 0.1 },
	frequency = 10,
	position = nil,
	north_position = smoke_position,
	south_position = smoke_position,
	east_position = smoke_position,
	west_position = smoke_position,
	starting_vertical_speed = 0.08,
	starting_frame_deviation = 60,
	slow_down_factor = 1,
}

local smoke_position_a = { -0.58, -0.85 }
local smoke_position_b = { -0.58, -1.45 }
local smoke_position_c = { -0.58, -2.05 }

apm.lib.utils.builders.smoke.burner = {}
apm.lib.utils.builders.smoke.burner.t0 = {
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 5,
		north_position = smoke_position_a,
		south_position = smoke_position_a,
		east_position = smoke_position_a,
		west_position = smoke_position_a,
		starting_vertical_speed = 0.09,
		starting_frame_deviation = 60,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 7,
		north_position = smoke_position_b,
		south_position = smoke_position_b,
		east_position = smoke_position_b,
		west_position = smoke_position_b,
		starting_vertical_speed = 0.08,
		starting_frame_deviation = 64,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 6,
		north_position = smoke_position_c,
		south_position = smoke_position_c,
		east_position = smoke_position_c,
		west_position = smoke_position_c,
		starting_vertical_speed = 0.07,
		starting_frame_deviation = 68,
		slow_down_factor = 1,
	},
}
apm.lib.utils.builders.smoke.burner.t1 = {
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 7,
		north_position = smoke_position_a,
		south_position = smoke_position_a,
		east_position = smoke_position_a,
		west_position = smoke_position_a,
		starting_vertical_speed = 0.09,
		starting_frame_deviation = 60,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 9,
		north_position = smoke_position_b,
		south_position = smoke_position_b,
		east_position = smoke_position_b,
		west_position = smoke_position_b,
		starting_vertical_speed = 0.08,
		starting_frame_deviation = 64,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 8,
		north_position = smoke_position_c,
		south_position = smoke_position_c,
		east_position = smoke_position_c,
		west_position = smoke_position_c,
		starting_vertical_speed = 0.07,
		starting_frame_deviation = 68,
		slow_down_factor = 1,
	},
}
apm.lib.utils.builders.smoke.burner.t2 = {
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 4,
		north_position = smoke_position_a,
		south_position = smoke_position_a,
		east_position = smoke_position_a,
		west_position = smoke_position_a,
		starting_vertical_speed = 0.09,
		starting_frame_deviation = 60,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 5,
		north_position = smoke_position_b,
		south_position = smoke_position_b,
		east_position = smoke_position_b,
		west_position = smoke_position_b,
		starting_vertical_speed = 0.08,
		starting_frame_deviation = 64,
		slow_down_factor = 1,
	},
	{
		name = "apm_dark_smoke",
		deviation = { 0.1, 0.1 },
		frequency = 4,
		north_position = smoke_position_c,
		south_position = smoke_position_c,
		east_position = smoke_position_c,
		west_position = smoke_position_c,
		starting_vertical_speed = 0.07,
		starting_frame_deviation = 68,
		slow_down_factor = 1,
	},
}

function apm.lib.utils.builders.smoke.new(
		name,
		deviation,
		frequency,
		position,
		positions,
		starting_vertical_speed,
		starting_frame_deviation,
		slow_down_factor
)
	if not name then
		name = "apm_smoke"
	end

	if not deviation then
		deviation = { 0.1, 0.1 }
	end

	if not frequency then
		frequency = 10
	end

	if not positions then
		positions = {
			north = position,
			south = position,
			east = position,
			west = position,
		}
	end

	if not starting_vertical_speed then
		starting_vertical_speed = 0.08
	end

	if not starting_frame_deviation then
		starting_frame_deviation = 60
	end

	if not slow_down_factor then
		slow_down_factor = 1
	end

	return {
		name = name,
		deviation = deviation,
		frequency = frequency,
		position = nil,
		north_position = positions.north,
		south_position_position = positions.south,
		west_position_position = positions.west,
		east_position_position = positions.east,
		starting_vertical_speed = starting_vertical_speed,
		starting_frame_deviation = starting_frame_deviation,
		slow_down_factor = slow_down_factor,
	}
end
