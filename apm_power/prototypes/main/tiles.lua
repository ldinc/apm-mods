require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/tiles.lua'
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")

APM_LOG_HEADER(self)

-- Locals ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

water_tile_type_names = water_tile_type_names or {}
water_transition_group_id = water_transition_group_id or 1
local tile_graphics = require("__base__/prototypes/tile/tile-graphics")
local tile_spritesheet_layout = tile_graphics.tile_spritesheet_layout
out_of_map_tile_type_names = out_of_map_tile_type_names or {}
out_of_map_transition_group_id = out_of_map_transition_group_id or 2

local concrete_to_out_of_map_transition =
{
	to_tiles = out_of_map_tile_type_names,
	transition_group = out_of_map_transition_group_id,

	background_layer_offset = 1,
	background_layer_group = "zero",
	offset_background_layer_by_tile_layer = true,

	spritesheet = "__base__/graphics/terrain/out-of-map-transition/concrete-out-of-map-transition.png",
	layout = tile_spritesheet_layout.transition_4_4_8_1_1,
}

-- copied from base (concrete tile)
local sound_deconstruct_bricks = function(volume)
  return
  {
    switch_vibration_data =
    {
      gain = 0.32,
      filename = "__core__/sound/deconstruct-bricks.bnvib"
    },
    variations =
    {
      {
        filename = "__base__/sound/deconstruct-bricks.ogg",
        volume = volume
      }
    }
  }
end

local concrete_transitions =
{
	{
		to_tiles = water_tile_type_names,
		transition_group = water_transition_group_id,

		spritesheet = "__base__/graphics/terrain/water-transitions/concrete.png",
		layout = tile_spritesheet_layout.transition_8_8_8_4_4,
		background_enabled = false,
		effect_map_layout =
		{
			spritesheet = "__base__/graphics/terrain/effect-maps/water-stone-mask.png",
			inner_corner_count = 1,
			outer_corner_count = 1,
			side_count = 1,
			u_transition_count = 1,
			o_transition_count = 1
		}
	},
	concrete_to_out_of_map_transition
}

function sound_variations(filename_string, variations, volume_parameter, modifiers_parameter)
  local result = {}
  for i = 1,variations do
    result[i] = { filename = filename_string .. "-" .. i .. ".ogg", volume = volume_parameter or 0.5 }
    if modifiers_parameter then
      result[i].modifiers = modifiers_parameter
    end
  end
  return result
end

local concrete_sounds = sound_variations("__base__/sound/walking/concrete", 11, 0.5)
local concrete_driving_sound =
{
  sound =
  {
    filename = "__base__/sound/driving/vehicle-surface-concrete.ogg", volume = 0.8,
    advanced_volume_control = {fades = {fade_in = {curve_type = "cosine", from = {control = 0.5, volume_percentage = 0.0}, to = {1.5, 100.0 }}}}
  },
  fade_ticks = 6
}
local concrete_tile_build_sounds =
{
  small =
  {
    switch_vibration_data =
    {
      gain = 0.25,
      filename = "__core__/sound/build-concrete-small.bnvib"
    },
    variations = sound_variations("__core__/sound/build-concrete-small", 6, 0.4)
  },
  medium =
  {
    switch_vibration_data =
    {
      gain = 0.15,
      filename = "__core__/sound/build-concrete-medium.bnvib"
    },
    variations = sound_variations("__core__/sound/build-concrete-medium", 6, 0.5)
  },
  large =
  {
    switch_vibration_data =
    {
      gain = 0.15,
      filename = "__core__/sound/build-concrete-large.bnvib"
    },
    variations = sound_variations("__core__/sound/build-concrete-large", 6, 0.5)
  }
}

local tile_asphalt = {
	type = "tile",
	name = "apm_asphalt",
	needs_correction = false,
	order = "a[artifical]-a[apm]-b[apm_asphalt]",
	layer = 61,
	subgroup = "artificial-tiles",
	decorative_removal_probability = 0.95,
	minable = { mining_time = 0.1, result = "apm_asphalt" },
	mined_sound = sound_deconstruct_bricks(0.6),
	collision_mask = tile_collision_masks.ground,
	walking_speed_modifier = 1.4,
	variants = {
		main =
		{
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-dummy.png",
				count = 1,
				size = 1
			},
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-dummy.png",
				count = 1,
				size = 2,
				probability = 0.39
			},
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-dummy.png",
				count = 1,
				size = 4,
				probability = 1
			}
		},

		inner_corner =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-inner-corner.png",
			count = 16,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-inner-corner.png",
				count = 16,
				scale = 0.5
			}
		},

		inner_corner_mask =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-inner-corner-mask.png",
			count = 16,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-inner-corner-mask.png",
				count = 16,
				scale = 0.5
			}
		},

		outer_corner =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-outer-corner.png",
			count = 8,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-outer-corner.png",
				count = 8,
				scale = 0.5
			}
		},

		outer_corner_mask =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-outer-corner-mask.png",
			count = 8,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-outer-corner-mask.png",
				count = 8,
				scale = 0.5
			}
		},

		side =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-side.png",
			count = 16,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-side.png",
				count = 16,
				scale = 0.5
			}
		},

		side_mask =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-side-mask.png",
			count = 16,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-side-mask.png",
				count = 16,
				scale = 0.5
			}
		},

		u_transition =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-u.png",
			count = 8,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-u.png",
				count = 8,
				scale = 0.5
			}
		},

		u_transition_mask =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-u-mask.png",
			count = 8,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-u-mask.png",
				count = 8,
				scale = 0.5
			}
		},

		o_transition =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-o.png",
			count = 4,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-o.png",
				count = 4,
				scale = 0.5
			}
		},

		o_transition_mask =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt-o-mask.png",
			count = 4,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt-o-mask.png",
				count = 4,
				scale = 0.5
			}
		},

		material_background =
		{
			picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/asphalt.png",
			count = 8,
			hr_version =
			{
				picture = "__apm_resource_pack_ldinc__/graphics/tiles/asphalt/hr-asphalt.png",
				count = 8,
				scale = 0.5
			}
		}
	},
	transitions = concrete_transitions,
	transitions_between_transitions = concrete_transitions_between_transitions,
	walking_sound = concrete_sounds,
	driving_sound = concrete_driving_sound,
	build_sound = concrete_tile_build_sounds,
	map_color = { r = 100, g = 100, b = 100 },
	absorptions_per_second = { pollution = 0.0 },
	vehicle_friction_modifier = 0.95
}

data:extend({ tile_asphalt })
