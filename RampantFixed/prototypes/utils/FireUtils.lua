local fireUtils = {}

-- constants
-- imported

local colorUtils = require("ColorUtils")
local imageUtils = require("ImageUtils")

-- imported functions

local create_burnt_patch_pictures = imageUtils.create_burnt_patch_pictures
local create_fire_pictures = imageUtils.create_fire_pictures
local create_small_tree_flame_animations = imageUtils.create_small_tree_flame_animations

local makeColor = colorUtils.makeColor

-- module code

function fireUtils.makeSpreadEffect(attributes)
    local name = attributes.name .. "-spread-rampant"
    local smokeName = "the-glow-smoke-rampant"
    data:extend({
            {
                type = "fire",
                name = name,
                flags = {"placeable-off-grid", "not-on-map"},

 --               damage_per_tick = { amount = attributes.fireDamagePerTick or 45/60, type = attributes.fireDamagePerTickType or "fire"  },
                damage_per_tick = { amount = 0, type = attributes.fireDamagePerTickType or "fire"  },

                spawn_entity = name,
                maximum_spread_count = 100,

                spread_delay = 300,
                spread_delay_deviation = 180,
                flame_alpha = 0.35,
                flame_alpha_deviation = 0.05,

                tree_dying_factor = 0.8,
                emissions_per_second = 0.005,

                fade_in_duration = 120,
                fade_out_duration = 100,
                smoke_fade_in_duration = 100,
                smoke_fade_out_duration = 130,
                delay_between_initial_flames = 20,

				on_damage_tick_effect =
					{
						type = "area",
						radius = attributes.radius or 2.5,
						force = "not-same",
						ignore_collision_condition = true,
						-- filter_enabled = true,
						action_delivery =
							{
								type = "instant",
								target_effects =
									{
										{
											type = "damage",
											damage = { amount = attributes.fireDamagePerTick*6 or 45/10, type = attributes.fireDamagePerTickType or "fire" }		-- hit once per 6 ticks
										}
									}
							}
					},

                small_tree_fire_pictures = create_small_tree_flame_animations({ blend_mode = "additive", animation_speed = 0.5, scale = 0.7 * 0.75, tint2 = attributes.tint2 }),

                pictures = create_fire_pictures({ blend_mode = "additive", animation_speed = 1, scale = 0.5 * 1.25, tint2 = attributes.tint2}),

                smoke_source_pictures =
                    {
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
                            line_length = 8,
                            width = 101,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            scale = 0.6,
                            shift = {-0.109375 * 0.6, -1.1875 * 0.6},
                            animation_speed = 0.5,
                            tint = makeColor(0,1,0, 0.75),
                        },
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
                            line_length = 8,
                            width = 99,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            scale = 0.6,
                            shift = {-0.203125 * 0.6, -1.21875 * 0.6},
                            animation_speed = 0.5,
                            tint = makeColor(0,1,0, 0.75),
                        },
                    },

                trivial_smoke =
                    {
                        {
                            name = smokeName,
                            deviation = {0.5, 0.5},
                            frequency = 0.25 / 2,
                            position = {0.0, -0.8},
                            starting_vertical_speed = 0.008,
                            starting_vertical_speed_deviation = 0.05,
                            starting_frame_deviation = 60,
                            height = -0.5,
                        }
                    },

                light = {intensity = 1, size = 20},

                working_sound =
                    {
                        sound = { filename = "__base__/sound/furnace.ogg" },
                        max_sounds_per_type = 3
                    },
    }})
    return name
end

function fireUtils.makeSpreadOnceEffect(attributes)
    local name = attributes.name .. "-spreadOnce-rampant"
    local smokeName = "the-glow-smoke-rampant"
    data:extend({
            {
                type = "fire",
                name = name,
                flags = {"placeable-off-grid", "not-on-map"},

--                damage_per_tick = { amount = attributes.fireDamagePerTick or 45/60, type = attributes.fireDamagePerTickType or "fire"  },
                damage_per_tick = { amount = 0, type = attributes.fireDamagePerTickType or "fire"  },

                spawn_entity = nil,
                maximum_spread_count = 0,

                spread_delay = 0,
                spread_delay_deviation = 0,
                flame_alpha = 0.35,
                flame_alpha_deviation = 0.05,

                tree_dying_factor = 0.7,
                emissions_per_second = 0.005,

                fade_in_duration = 120,
                fade_out_duration = 100,
                smoke_fade_in_duration = 100,
                smoke_fade_out_duration = 130,
                delay_between_initial_flames = 20,

				on_damage_tick_effect =
					{
						type = "area",
						radius = attributes.radius or 2.5,
						force = "not-same",
						ignore_collision_condition = true,
						-- filter_enabled = true,
						action_delivery =
							{
								type = "instant",
								target_effects =
									{
										{
											type = "damage",
											damage = { amount = attributes.fireDamagePerTick*6 or 45/10, type = attributes.fireDamagePerTickType or "fire" }		-- hit once per 6 ticks
										}
									}
							}
					},

                small_tree_fire_pictures = create_small_tree_flame_animations({ blend_mode = "additive", animation_speed = 0.5, scale = 0.7 * 0.75, tint2 = attributes.tint2 }),

                pictures = create_fire_pictures({ blend_mode = "additive", animation_speed = 1, scale = 0.5 * 1.25, tint2 = attributes.tint2}),

                smoke_source_pictures =
                    {
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
                            line_length = 8,
                            width = 101,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            scale = 0.6,
                            shift = {-0.109375 * 0.6, -1.1875 * 0.6},
                            animation_speed = 0.5,
                            tint = makeColor(0,1,0, 0.75),
                        },
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
                            line_length = 8,
                            width = 99,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            scale = 0.6,
                            shift = {-0.203125 * 0.6, -1.21875 * 0.6},
                            animation_speed = 0.5,
                            tint = makeColor(0,1,0, 0.75),
                        },
                    },

                trivial_smoke =
                    {
                        {
                            name = smokeName,
                            deviation = {0.5, 0.5},
                            frequency = 0.25 / 2,
                            position = {0.0, -0.8},
                            starting_vertical_speed = 0.008,
                            starting_vertical_speed_deviation = 0.05,
                            starting_frame_deviation = 60,
                            height = -0.5,
                        }
                    },

                light = {intensity = 1, size = 20},

                working_sound =
                    {
                        sound = { filename = "__base__/sound/furnace.ogg" },
                        max_sounds_per_type = 3
                    },
    }})
    return name
end

function fireUtils.makeFire(attributes)
    local name = attributes.name .. "-fire-rampant"
    local spawnEntityName = attributes.spawnEntityName
    local smokeAddingFuelName = "the-adding-fuel-rampant"
    local smokeName = "the-glow-smoke-rampant"
    data:extend({{
                type = "fire",
                name = name,
                flags = {"placeable-off-grid", "not-on-map"},
				localised_name = {"", {"rampant.fire-pool"}},
                color = attributes.tint2,
--                damage_per_tick = { amount = attributes.fireDamagePerTick or 45/60, type = attributes.fireDamagePerTickType or "fire"  },
				damage_per_tick = {amount = 0, type = "fire"},

                maximum_damage_multiplier = attributes.damageMaxMultipler or 6,
                damage_multiplier_increase_per_added_fuel = attributes.mutliplerIncrease or 1,
                damage_multiplier_decrease_per_tick = attributes.mutliplerDecrease or 0.005,

                spawn_entity = spawnEntityName,

                spread_delay = 20,
                spread_delay_deviation = 10,
                maximum_spread_count = 10,

                flame_alpha = 0.35,
                flame_alpha_deviation = 0.05,

                emissions_per_second = 0.005,

                add_fuel_cooldown = 10,
                fade_in_duration = 30,
                fade_out_duration = 30,

                initial_lifetime = 120,
                lifetime_increase_by = 2,
                lifetime_increase_cooldown = 1,
                maximum_lifetime = 600,
                delay_between_initial_flames = 10,
                --initial_flame_count = 1,
                burnt_patch_lifetime = 1800,

				on_damage_tick_effect =
					{
						type = "area",
						radius = attributes.radius or 2.5,
						force = "not-same",
						ignore_collision_condition = true,
						-- filter_enabled = true,
						action_delivery =
							{
								type = "instant",
								target_effects =
									{
										{
											type = "damage",
											damage = {amount = 6 * ((attributes.fireDamagePerTick ) or 45/60), type = attributes.fireDamagePerTickType or "fire" }		-- hit once per 6 ticks
										}
									}
							}
					},


                on_fuel_added_action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        {
                                            type = "create-trivial-smoke",
                                            smoke_name = smokeAddingFuelName,
                                            -- speed = {-0.03, 0},
                                            -- speed_multiplier = 0.99,
                                            -- speed_multiplier_deviation = 1.1,
                                            offset_deviation = {{-0.5, -0.5}, {0.5, 0.5}},
                                            speed_from_center = 0.01
                                        }
                                    }
                            }
                    },

                pictures = create_fire_pictures({ blend_mode = "normal", animation_speed = 1, scale = 0.5, tint2 = attributes.tint2}),

                smoke_source_pictures =
                    {
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-1.png",
                            line_length = 8,
                            width = 101,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = {-0.109375, -1.1875},
                            animation_speed = 0.5,
                        },
                        {
                            filename = "__base__/graphics/entity/fire-flame/fire-smoke-source-2.png",
                            line_length = 8,
                            width = 99,
                            height = 138,
                            frame_count = 31,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = {-0.203125, -1.21875},
                            animation_speed = 0.5,
                        },
                    },

                burnt_patch_pictures = create_burnt_patch_pictures(attributes),
                burnt_patch_alpha_default = 0.4,
                burnt_patch_alpha_variations = {
                    -- { tile = "grass", alpha = 0.4 },
                    -- { tile = "grass-medium", alpha = 0.4 },
                    -- { tile = "grass-dry", alpha = 0.45 },
                    -- { tile = "dirt", alpha = 0.3 },
                    -- { tile = "dirt-dark", alpha = 0.35 },
                    -- { tile = "sand", alpha = 0.24 },
                    -- { tile = "sand-dark", alpha = 0.28 },
                    { tile = "stone-path", alpha = 0.26 },
                    { tile = "concrete", alpha = 0.24 },
                },

                smoke =
                    {
                        {
                            name = smokeName,
                            deviation = {0.5, 0.5},
                            frequency = 0.25 / 2,
                            position = {0.0, -0.8},
                            starting_vertical_speed = 0.05,
                            starting_vertical_speed_deviation = 0.005,
                            vertical_speed_slowdown = 0.99,
                            starting_frame_deviation = 60,
                            height = -0.5,
                        }
                    },

                light = {intensity = 1, size = 20},

                working_sound =
                    {
                        sound = { filename = "__base__/sound/furnace.ogg" },
                        max_sounds_per_type = 3
                    },

                 }
                }
    )
    return name
end

function fireUtils.makeAcidSplashFire(attributes, stickerName)

    local name = attributes.name .. "-acid-fire-rampant"

    local acidFire = {
        type = "fire",
        name = name,
        flags = {"placeable-off-grid", "not-on-map"},
		localised_name = {"", {"rampant.acid-pool"}},
        damage_per_tick = {amount = 0, type = "acid"},
        maximum_damage_multiplier = 3,
        damage_multiplier_increase_per_added_fuel = 1,
        damage_multiplier_decrease_per_tick = 0.005,

        collision_mask = { "water-tile" },

        --spawn_entity = "fire-flame-on-tree",
        uses_alternative_behavior = true,
        limit_overlapping_particles = true,
        initial_render_layer = "object",
        render_layer = "lower-object-above-shadow",
        secondary_render_layer = "higher-object-above",
        secondary_picture_fade_out_start = 30,
        secondary_picture_fade_out_duration = 60,

        spread_delay = 300,
        spread_delay_deviation = 180,
        maximum_spread_count = 100,

        particle_alpha = 0.6,
        particle_alpha_blend_duration = 60*5,
        --flame_alpha = 0.35,
        --flame_alpha_deviation = 0.05,

        emissions_per_second = 0,

        add_fuel_cooldown = 10,
        fade_in_duration = 1,
        fade_out_duration = 30,

        initial_lifetime = 60*7,--120,
        lifetime_increase_by = 160,
        lifetime_increase_cooldown = 4,
        maximum_lifetime = 1800,
        delay_between_initial_flames = 10,
        initial_flame_count = 1,
        burnt_patch_lifetime = 0,

        working_sound =
            {
                sound = { filename = "__base__/sound/furnace.ogg" },
                max_sounds_per_type = 3
            },

        on_damage_tick_effect =
            {
                type = "area",
                radius = attributes.radius or 2.5,
				force = "not-same",
                ignore_collision_condition = true,
                -- filter_enabled = true,
                action_delivery =
                    {
                        type = "instant",
                        target_effects =
                            {
                                {
                                    type = "create-sticker",
                                    sticker = stickerName
                                },
                                {
                                    type = "damage",
                                    damage = { amount = attributes.damagePerTick or 0, type = attributes.damageType or "acid" }
                                }
                            }
                    }
            },

        pictures =
            {
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 106,
                                height = 116,
                                frame_count = 26,
                                shift = util.mul_shift(util.by_pixel(-12, -10), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 210,
                                    height = 224,
                                    frame_count = 26,
                                    shift = util.mul_shift(util.by_pixel(-12, -8), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * attributes.scale,
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 134,
                                height = 98,
                                frame_count = 26,
                                shift = util.mul_shift(util.by_pixel(2, 0), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 266,
                                    height = 188,
                                    frame_count = 26,
                                    shift = util.mul_shift(util.by_pixel(2, 2), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * attributes.scale,
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 88,
                                height = 76,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(-10, -18), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 174,
                                    height = 150,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(-9, -17), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * attributes.scale,
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 120,
                                height = 136,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(6, 28), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 238,
                                    height = 266,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(6, 29), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * attributes.scale,
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 118,
                                height = 104,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(22, -16), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 236,
                                    height = 208,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(22, -16), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * attributes.scale,
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 110,
                                height = 70,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(16, 2), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 214,
                                    height = 140,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(17, 2), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * attributes.scale,
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 128,
                                height = 80,
                                frame_count = 24,
                                shift = util.mul_shift(util.by_pixel(16, -20), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 252,
                                    height = 154,
                                    frame_count = 24,
                                    shift = util.mul_shift(util.by_pixel(17, -19), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * attributes.scale,
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 124,
                                height = 80,
                                frame_count = 24,
                                shift = util.mul_shift(util.by_pixel(18, -16), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = attributes.scale,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 248,
                                    height = 160,
                                    frame_count = 24,
                                    shift = util.mul_shift(util.by_pixel(18, -16), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * attributes.scale,
                                }
                            }
                        }
                },
            },

        secondary_pictures =
            {
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-1.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 106,
                                height = 116,
                                frame_count = 26,
                                shift = util.mul_shift(util.by_pixel(-12, -10), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = attributes.ground_patch_scale ,
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 210,
                                    height = 224,
                                    frame_count = 26,
                                    shift = util.mul_shift(util.by_pixel(-12, -8), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-1-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 134,
                                height = 98,
                                frame_count = 26,
                                shift = util.mul_shift(util.by_pixel(2, 0), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-1-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 266,
                                    height = 188,
                                    frame_count = 26,
                                    shift = util.mul_shift(util.by_pixel(2, 2), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-2.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 88,
                                height = 76,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(-10, -18), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 174,
                                    height = 150,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(-9, -17), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-2-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 120,
                                height = 136,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(6, 28), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-2-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 238,
                                    height = 266,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(6, 29), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-3.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 118,
                                height = 104,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(22, -16), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 236,
                                    height = 208,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(22, -16), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-3-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 110,
                                height = 70,
                                frame_count = 29,
                                shift = util.mul_shift(util.by_pixel(16, 2), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-3-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 214,
                                    height = 140,
                                    frame_count = 29,
                                    shift = util.mul_shift(util.by_pixel(17, 2), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            }
                        },
                },
                {
                    layers =
                        {
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-4.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 128,
                                height = 80,
                                frame_count = 24,
                                shift = util.mul_shift(util.by_pixel(16, -20), (attributes.scale or 1)),
                                tint = attributes.tint2,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 252,
                                    height = 154,
                                    frame_count = 24,
                                    shift = util.mul_shift(util.by_pixel(17, -19), (attributes.scale or 1)),
                                    tint = attributes.tint2,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            },
                            {
                                filename = "__base__/graphics/entity/acid-splash/acid-splash-4-shadow.png",
                                line_length = 8,
                                direction_count = 1,
                                width = 124,
                                height = 80,
                                frame_count = 24,
                                shift = util.mul_shift(util.by_pixel(18, -16), (attributes.scale or 1)),
                                draw_as_shadow = true,
                                scale = (attributes.scale or 1),
                                hr_version = {
                                    filename = "__base__/graphics/entity/acid-splash/hr-acid-splash-4-shadow.png",
                                    line_length = 8,
                                    direction_count = 1,
                                    width = 248,
                                    height = 160,
                                    frame_count = 24,
                                    shift = util.mul_shift(util.by_pixel(18, -16), (attributes.scale or 1)),
                                    draw_as_shadow = true,
                                    scale = 0.5 * (attributes.scale or 1),
                                }
                            }
                        }
                }
            }
    }

    data:extend ({
            acidFire
    })
    return name
end

-- + !КДА 2021.11
local safeFireOnTree = util.table.deepcopy(data.raw["fire"]["fire-flame-on-tree"])
safeFireOnTree.name = "safe-fire-flame-on-tree-rampant"
safeFireOnTree.spawn_entity = nil
data:extend({safeFireOnTree})

local safeFire = util.table.deepcopy(data.raw["fire"]["fire-flame"])
safeFire.name = "safe-fire-flame-rampant"
safeFire.spawn_entity = "safe-fire-flame-on-tree-rampant"
safeFire.maximum_spread_count = 10
data:extend({safeFire})

local bitersSafeFire = util.table.deepcopy(data.raw["fire"]["fire-flame"])
bitersSafeFire.name = "biters-safe-fire-rampant"
bitersSafeFire.spawn_entity = "safe-fire-flame-on-tree-rampant"
bitersSafeFire.maximum_spread_count = 10
bitersSafeFire.maximum_lifetime = 240
bitersSafeFire.damage_per_tick = {amount = 0, type = "fire"}
bitersSafeFire.on_damage_tick_effect =
            {
                type = "area",
				radius = 0.5,
				force = "not-same",
                action_delivery =
                    {
                        type = "instant",
                        target_effects =
                            {
                                {
                                    type = "damage",									
                                    damage = { amount = 2, type = "fire" }
                                }
                            }
                    }
            }
data:extend({bitersSafeFire})

local safeFireSticker = util.table.deepcopy(data.raw["sticker"]["fire-sticker"])
safeFireSticker.name = "safe-fire-sticker-rampant"
safeFireSticker.spread_fire_entity = "safe-fire-flame-on-tree-rampant"
data:extend({safeFireSticker})


function fireUtils.makeAcidFireStream()

	local acidFireSticker = util.table.deepcopy(data.raw["sticker"]["fire-sticker"])
	acidFireSticker.name = "acidFire-sticker-rampant"
	-- acidFireSticker.spread_fire_entity = "safe-fire-flame-rampant"
	-- acidFireSticker.fire_spread_cooldown = 100
	-- acidFireSticker.fire_spread_radius = 2.5
	acidFireSticker.spread_fire_entity = nil
	acidFireSticker.fire_spread_cooldown = nil
	acidFireSticker.fire_spread_radius = nil
	acidFireSticker.animation.tint = { r = 0.5, g = 0.7, b = 0.5, a = 0.28 }
	acidFireSticker.duration_in_ticks = 5 * 60
	acidFireSticker.damage_per_tick = { amount = 200 / 60, type = "fire" }		-- (damage_interval = 10)
	data:extend(
		{acidFireSticker}
	)


	local AcidFireSteam = util.table.deepcopy(data.raw["stream"]["flamethrower-fire-stream"])
	AcidFireSteam.name = "acidFire-stream-rampant"
--	AcidFireSteam.particle_vertical_acceleration = 0.02
	AcidFireSteam.particle_horizontal_speed = 0.6
	AcidFireSteam.action = {}
    AcidFireSteam.action[1] =
      {
        type = "area",
        radius = 2.5,
        force = "not-same",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
				type = "create-sticker",
				sticker = "acidFire-sticker-rampant",
				show_in_tooltip = true
            },
            {
				type = "damage",
				damage = { amount = 0.5, type = "fire" },
				apply_damage_to_trees = false
            },
			{
				type = "damage",
				damage = { amount = 1, type = "acid" },
				apply_damage_to_trees = false
			}  
          }
        }
      }
	  AcidFireSteam.action[2] =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            {
              type = "create-fire",
              entity_name = "biters-safe-fire-rampant",
              show_in_tooltip = true
            }
          }
        }
      }
	AcidFireSteam.spine_animation.tint = {r=0.5, g=1, b=0.5, a=0.3} 
	data:extend({AcidFireSteam})
end	


return fireUtils
