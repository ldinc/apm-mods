require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/tiles.lua'
local tile_pollution = require("__base__/prototypes/tile/tile-pollution-values")

APM_LOG_HEADER(self)

-- Locals ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local concrete_sounds =
{
	{
		filename = "__base__/sound/walking/concrete-01.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-02.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-03.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-04.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-05.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-06.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-07.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-08.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-09.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-10.ogg",
		volume = 0.5
	},
	{
		filename = "__base__/sound/walking/concrete-11.ogg",
		volume = 0.5
	}
}

local ttfxmaps = {}
ttfxmaps.water_stone =
{
	filename_norm = "__base__/graphics/terrain/effect-maps/water-stone-mask.png",
	filename_high = "__base__/graphics/terrain/effect-maps/hr-water-stone-mask.png",
	count = 1,
	o_transition_tall = false,
}

local function water_transition_template_with_effect(to_tiles, normal_res_transition, high_res_transition, options)
	return make_generic_transition_template(to_tiles, water_transition_group_id, nil, normal_res_transition,
		high_res_transition, options, true, false, true)
end

--local concrete_out_of_map_transition =
--  out_of_map_transition_template
--  (
--    { "out-of-map" },
--    "__base__/graphics/terrain/out-of-map-transition/concrete-out-of-map-transition.png",
--    "__base__/graphics/terrain/out-of-map-transition/hr-concrete-out-of-map-transition.png",
--    {
--      o_transition_tall = false,
--      side_count = 8,
--      inner_corner_count = 4,
--      outer_corner_count = 4,
--      u_transition_count = 1,
--      o_transition_count = 1,
--      base = init_transition_between_transition_common_options()
--    }
--  )

local concrete_transitions =
{
	water_transition_template_with_effect
	(
		water_tile_type_names,
		"__base__/graphics/terrain/water-transitions/concrete.png",
		"__base__/graphics/terrain/water-transitions/hr-concrete.png",
		{
			effect_map = ttfxmaps.water_stone,
			o_transition_tall = false,
			u_transition_count = 4,
			o_transition_count = 4,
			side_count = 8,
			outer_corner_count = 8,
			inner_corner_count = 8,
			--base = { layer = 40 }
		}
	),
	concrete_out_of_map_transition
	--water_transition_template
	--(
	--    water_tile_type_names,
	--    "__base__/graphics/terrain/water-transitions/concrete.png",
	--    "__base__/graphics/terrain/water-transitions/hr-concrete.png",
	--    {
	--      o_transition_tall = false,
	--      u_transition_count = 4,
	--      o_transition_count = 4,
	--      side_count = 8,
	--      outer_corner_count = 8,
	--      inner_corner_count = 8,
	--      --base = { layer = 40 }
	--    }
	--),
	--concrete_out_of_map_transition
}

local concrete_transitions_between_transitions =
{
	generic_transition_between_transitions_template
	(
		default_transition_group_id,
		water_transition_group_id,
		"__base__/graphics/terrain/water-transitions/concrete-transitions.png",
		"__base__/graphics/terrain/water-transitions/hr-concrete-transitions.png",
		{
			inner_corner_tall = true,
			inner_corner_count = 3,
			outer_corner_count = 3,
			side_count = 3,
			u_transition_count = 1,
			o_transition_count = 0
		}
	),
	make_generic_transition_template
	(
		nil,
		default_transition_group_id,
		out_of_map_transition_group_id,
		"__base__/graphics/terrain/out-of-map-transition/concrete-out-of-map-transition-b.png",
		"__base__/graphics/terrain/out-of-map-transition/hr-concrete-out-of-map-transition-b.png",
		{
			inner_corner_tall = true,
			inner_corner_count = 3,
			outer_corner_count = 3,
			side_count = 3,
			u_transition_count = 1,
			o_transition_count = 0,
			base = init_transition_between_transition_common_options()
		},
		true,
		true,
		true
	),
	generic_transition_between_transitions_template
	(
		water_transition_group_id,
		out_of_map_transition_group_id,
		"__base__/graphics/terrain/out-of-map-transition/concrete-shore-out-of-map-transition.png",
		"__base__/graphics/terrain/out-of-map-transition/hr-concrete-shore-out-of-map-transition.png",
		{
			o_transition_tall = false,
			inner_corner_count = 3,
			outer_corner_count = 3,
			side_count = 3,
			u_transition_count = 1,
			o_transition_count = 0,
			base = init_transition_between_transition_common_options({ water_patch =
			patch_for_inner_corner_of_transition_between_transition, })
		}
	),
}

data:extend(
	{
		{
			type = "tile",
			name = "apm_asphalt",
			needs_correction = false,
			minable = { mining_time = 0.1, result = "apm_asphalt" },
			mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
			collision_mask = { "ground-tile" },
			walking_speed_modifier = 1.35,
			layer = 61,
			--transition_overlay_layer_offset = 2, -- need to render border overlay on top of hazard-concrete
			decorative_removal_probability = 0.95,
			variants =
			{
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
			map_color = { r = 100, g = 100, b = 100 },
			absorptions_per_second = { pollution = 0.0   },
			vehicle_friction_modifier = 0.95
		},
	})
