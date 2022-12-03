local smokeUtils = {}

-- module code

function smokeUtils.makeNewCloud(attributes, attack)
    local name = attributes.name .. "-cloud-rampant"

    data:extend({
            {
                type = "smoke-with-trigger",
                name = "dummy-" .. name,
                flags = {"not-on-map"},
                show_when_smoke_off = true,
                particle_count = 24,
                particle_spread = { 3.6 * 1.05, 3.6 * 0.6 * 1.05 },
                particle_distance_scale_factor = 0.5,
                particle_scale_factor = { 1, 0.707 },
                particle_duration_variation = 60 * 3,
                wave_speed = { 0.5 / 80, 0.5 / 60 },
                wave_distance = { 1, 0.5 },
                spread_duration_variation = 300 - 20,

                render_layer = "object",

                affected_by_wind = attributes.wind,
                cyclic = true,
                duration = attributes.duration or 60 * 20 + 4 * 60,
                fade_away_duration = 3 * 60,
                spread_duration = (300 - 20) / 2 ,
                color = attributes.tint or { r = 0.7, g = 0.9, b = 0.2 }, -- #035b6452

                animation =
                    {
                        width = 152,
                        height = 120,
                        line_length = 5,
                        frame_count = 60,
                        shift = {-0.53125, -0.4375},
                        priority = "high",
                        animation_speed = 0.25,
                        scale = 1,
                        filename = "__base__/graphics/entity/smoke/smoke.png",
                        flags = { "smoke" }
                    }
            },
            {
                type = "smoke-with-trigger",
                name = name,
                flags = {"not-on-map"},
                show_when_smoke_off = true,
                animation =
                    {
                        width = 152,
                        height = 120,
                        line_length = 5,
                        frame_count = 60,
                        shift = {-0.53125, -0.4375},
                        priority = "high",
                        animation_speed = 0.25,
                        filename = "__base__/graphics/entity/smoke/smoke.png",
                        flags = { "smoke" },
                        scale = 1,
                        tint = attributes.tint or { r = 0.7, g = 0.9, b = 0.2 }
                    },
                created_effect =
                    {
                        {
                            type = "cluster",
                            cluster_count = (attributes.scale and attributes.scale * 0.25) and 10,
                            distance = (attributes.scale and attributes.scale * 0.8) and 4,
                            distance_deviation = 5,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            type = "create-smoke",
                                            show_in_tooltip = false,
                                            entity_name = "dummy-" .. name,
                                            initial_height = 0
                                        }
                                }
                        },
                        {
                            type = "cluster",
                            cluster_count = (attributes.scale and attributes.scale * 0.4) and 11,
                            distance = (attributes.scale and attributes.scale * 1.8) and 8 * 1.1,
                            distance_deviation = 2,
                            action_delivery =
                                {
                                    type = "instant",
                                    target_effects =
                                        {
                                            type = "create-smoke",
                                            show_in_tooltip = false,
                                            entity_name = "dummy-" .. name,
                                            initial_height = 0
                                        }
                                }
                        }
                    },
                slow_down_factor = attributes.slowdown or 0,
                affected_by_wind = attributes.wind,
                cyclic = true,
                render_layer = "higher-object-above",
                duration = attributes.duration or 60 * 20,
                fade_away_duration = attributes.outDuration or (attributes.duration and attributes.duration * 0.25) or 2 * 60,
                spread_duration = attributes.inDuration or (attributes.duration and attributes.duration * 0.25) or 10,
                action = attack or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        type = "nested-result",
                                        action =
                                            {
                                                type = "area",
                                                radius = 11,
                                                entity_flags = {"breaths-air"},
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 8, type = "poison"}
                                                            }
                                                    }
                                            }
                                    }
                            }
                    },
                action_cooldown = attributes.cooldown or 30
            }
    })

    return name
end


function smokeUtils.makeCloud(attributes, attack)
    local name = attributes.name .. "-cloud-rampant"

    data:extend({
            {
                type = "smoke-with-trigger",
                name = name,
                flags = {"not-on-map"},
                show_when_smoke_off = true,
                animation =
                    {
                        filename = "__base__/graphics/entity/cloud/cloud-45-frames.png",
                        flags = { "compressed" },
                        priority = "low",
                        width = 256,
                        height = 256,
                        frame_count = 45,
                        animation_speed = 0.5,
                        line_length = 7,
                        scale = attributes.scale or 3,
                    },
				render_layer = attributes.render_layer,
                slow_down_factor = attributes.slowdown or 0,
                affected_by_wind = attributes.wind,
                cyclic = true,
                duration = attributes.duration or 60 * 20,
                fade_away_duration = attributes.outDuration or (attributes.duration and attributes.duration * 0.25) or 2 * 60,
                spread_duration = attributes.inDuration or (attributes.duration and attributes.duration * 0.25) or 10,
                color = attributes.tint or { r = 0.2, g = 0.9, b = 0.2 },
                action = attack or
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects =
                                    {
                                        type = "nested-result",
                                        action =
                                            {
                                                type = "area",
                                                radius = 11,
                                                entity_flags = {"breaths-air"},
                                                action_delivery =
                                                    {
                                                        type = "instant",
                                                        target_effects =
                                                            {
                                                                type = "damage",
                                                                damage = { amount = 8, type = "poison"}
                                                            }
                                                    }
                                            }
                                    }
                            }
                    },
                action_cooldown = attributes.cooldown or 30
            }
    })

    return name
end

function smokeUtils.makeSmokeWithGlow(attributes)
    local name = attributes.name .. "-glow-smoke-rampant"
    data:extend(
        {
            smokeUtils.makeSmokeBasic
            {
                name = name,
                color = attributes.smokeWithGlowTint,
                start_scale = 0.5,
                end_scale = 1,
                duration = 300,
                spread_delay = 120,
                fade_away_duration = 90,
                fade_in_duration = 60,
                animation =
                    {
                        filename = "__base__/graphics/entity/fire-smoke/fire-smoke.png",
                        flags = { "compressed" },
                        line_length = 8,
                        width = 253,
                        height = 210,
                        frame_count = 60,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = {-0.265625, -0.09375},
                        priority = "high",
                        animation_speed = 0.25,
                    },
                glow_animation =
                    {
                        filename = "__base__/graphics/entity/fire-smoke/fire-smoke-glow.png",
                        flags = { "compressed" },
                        blend_mode = "additive",
                        line_length = 8,
                        width = 253,
                        height = 152,
                        frame_count = 60,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = {-0.265625, 0.8125},
                        priority = "high",
                        animation_speed = 0.25,
                    },
                glow_fade_away_duration = 70
    }})
    return name
end

function smokeUtils.makeSmokeWithoutGlow(attributes)
    local name = attributes.name .. "-without-glow-smoke-rampant"
    data:extend({
            smokeUtils.makeSmokeBasic
            {
                name = name,
                color = attributes.smokeWithoutGlowTint,
                start_scale = 0.5,
                end_scale = 1,
                duration = 300,
                spread_delay = 120,
                fade_away_duration = 90,
                fade_in_duration = 60,
                animation =
                    {
                        filename = "__base__/graphics/entity/fire-smoke/fire-smoke.png",
                        flags = { "compressed" },
                        line_length = 8,
                        width = 253,
                        height = 210,
                        frame_count = 60,
                        axially_symmetrical = false,
                        direction_count = 1,
                        shift = {-0.265625, -0.09375},
                        priority = "high",
                        animation_speed = 0.25,
                    },
            }
    })
    return name
end

function smokeUtils.makeSmokeSoft(attributes)
    local name = attributes.name .. "-soft-smoke-rampant"
    data:extend({
            smokeUtils.makeSmokeBasic({
                    name = name,
                    color = attributes.softSmokeTint,
                    start_scale = 0.5,
                    end_scale = 1.2,
                    duration = 300,
                    spread_delay = 120,
                    fade_away_duration = 60,
            })
    })
    return name
end

function smokeUtils.makeSmokeAddingFuel(attributes)
    local name =  attributes.name .. "-adding-fuel-rampant"
    data:extend({
            smokeUtils.makeSmokeBasic({
                    name = name,
                    start_scale = 0.5,
                    end_scale = 0.7,
                    duration = 300,
                    spread_delay = 120,
                    fade_away_duration = 60,
                    fade_in_duration = 60,
                    animation =
                        {
                            filename = "__base__/graphics/entity/fire-smoke/fire-smoke.png",
                            flags = { "compressed" },
                            line_length = 8,
                            width = 253,
                            height = 210,
                            frame_count = 60,
                            axially_symmetrical = false,
                            direction_count = 1,
                            shift = {-0.265625, -0.09375},
                            priority = "high",
                            animation_speed = 0.25,
                        }
            })
    })
    return name
end

function smokeUtils.makeSmokeBasic(attributes)
    return {
        type = "trivial-smoke",
        name = attributes.name,
        flags = {"not-on-map"},
        duration = attributes.duration or 600,
        fade_in_duration = attributes.fade_in_duration or 0,
        fade_away_duration = attributes.fade_away_duration or 600,
        spread_duration = attributes.spread_duration or 600,
        start_scale = attributes.start_scale or 0.20,
        end_scale = attributes.end_scale or 1.0,
        color = attributes.color,
        cyclic = true,
        affected_by_wind = attributes.affected_by_wind or true,
        animation = attributes.animation or
            {
                width = 152,
                height = 120,
                line_length = 5,
                frame_count = 60,
                axially_symmetrical = false,
                direction_count = 1,
                shift = {-0.53125, -0.4375},
                priority = "high",
                flags = { "compressed" },
                animation_speed = 0.25,
                filename = "__base__/graphics/entity/smoke/smoke.png"
            },
        glow_animation = attributes.glow_animation,
        glow_fade_away_duration = attributes.glow_fade_away_duration,
        vertical_speed_slowdown = attributes.vertical_speed_slowdown
    }
end

return smokeUtils
