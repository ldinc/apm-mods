local graphics = require "lib.entities.graphics"
local spawners = require "lib.entities.new.spawners"

-- TODO: return back to this shit...
if settings.startup['apm_bob_rework_change_spawners'].value == true and false then

    local function arachnids_spawner_integration(path)
        return {
            filename = path.idle.integration.lr,
            variation_count = 4,
            width = 5,
            height = 20,
            shift = util.by_pixel(2, -2),
            frame_count = 1,
            line_length = 1,
            hr_version =
            {
                filename = path.idle.integration.hr,
                variation_count = 4,
                width = 5,
                height = 20,
                shift = util.by_pixel(3, -3),
                frame_count = 1,
                line_length = 1,
                scale = 0.5
            }
        }
    end

    local function arachnids_spawner_idle_animation(scale, variation, path)
        return {
            layers =
            {
                {
                    filename = path.idle.animation.lr,
                    line_length = 1,
                    width = 175,
                    height = 181,
                    frame_count = 1,
                    shift = util.mul_shift(util.by_pixel(-10, -20), scale),
                    --shift = util.by_pixel(-10, -20),
                    y = variation * 181,
                    scale = scale,
                    hr_version =
                    {
                        filename = path.idle.animation.hr,
                        line_length = 1,
                        width = 350,
                        height = 362,
                        frame_count = 1,
                        shift = util.mul_shift(util.by_pixel(-10, -20), scale),
                        --shift = util.by_pixel(-10, -20),
                        y = variation * 362,
                        scale = 0.5 * scale
                    }
                },
                {
                    filename = path.idle.animation.shadows.lr,
                    draw_as_shadow = true,
                    width = 185,
                    height = 120,
                    frame_count = 1,
                    shift = util.mul_shift(util.by_pixel(20, -2), scale),
                    line_length = 1,
                    y = variation * 120,
                    scale = 1.18 * scale,
                    hr_version =
                    {
                        filename = path.idle.animation.shadows.hr,
                        draw_as_shadow = true,
                        width = 370,
                        height = 240,
                        frame_count = 1,
                        shift = util.mul_shift(util.by_pixel(20, -2), scale),
                        line_length = 1,
                        y = variation * 240,
                        scale = 0.59 * scale
                    }
                }
            }
        }
    end

    local function arachnids_spawner_die_animation(scale, variation, path)
        return {
            layers =
            {
                {
                    filename = path.death.lr,
                    line_length = 8,
                    width = 175,
                    height = 181,
                    frame_count = 8,
                    direction_count = 1,
                    shift = util.mul_shift(util.by_pixel(-10, -20), scale),
                    y = variation * 181,
                    scale = scale,
                    hr_version =
                    {
                        filename = path.death.hr,
                        line_length = 8,
                        width = 350,
                        height = 362,
                        frame_count = 8,
                        direction_count = 1,
                        shift = util.mul_shift(util.by_pixel(-10, -20), scale),
                        y = variation * 362,
                        scale = 0.5 * scale
                    }
                },
                {
                    filename = path.death.shadows.lr,
                    draw_as_shadow = true,
                    width = 185,
                    height = 120,
                    frame_count = 8,
                    direction_count = 1,
                    shift = util.mul_shift(util.by_pixel(20, -2), scale),
                    line_length = 8,
                    y = variation * 120,
                    scale = 1.18 * scale,
                    hr_version =
                    {
                        filename = path.death.shadows.hr,
                        draw_as_shadow = true,
                        width = 370,
                        height = 240,
                        frame_count = 8,
                        direction_count = 1,
                        shift = util.mul_shift(util.by_pixel(20, -2), scale),
                        line_length = 8,
                        y = variation * 240,
                        scale = 0.59 * scale
                    }
                }
            }
        }
    end

    local patchSpawner = function(
        bitter, bitter_corpse,
        splitter, splitter_corpse,
        scale0, scale1, scale2, scale3,
        path
    )

        local animations = {
            arachnids_spawner_idle_animation(scale0, 0, path),
            arachnids_spawner_idle_animation(scale1, 1, path),
            arachnids_spawner_idle_animation(scale2, 2, path),
            arachnids_spawner_idle_animation(scale3, 3, path)
        }

        local unit = data.raw["unit-spawner"][bitter]
        unit.animations = animations
        unit.integration = { sheet = arachnids_spawner_integration(path) }

        local corpse = data.raw["corpse"][bitter_corpse]

        local animation = {
            arachnids_spawner_die_animation(scale0, 0, path),
            arachnids_spawner_die_animation(scale1, 1, path),
            arachnids_spawner_die_animation(scale2, 2, path),
            arachnids_spawner_die_animation(scale3, 3, path)
        }

        corpse.animation =  animation
        corpse.ground_patch = { sheet = arachnids_spawner_integration(path) }
        corpse.dying_speed = 0.04

        local animations  = {
            arachnids_spawner_idle_animation(scale3, 0, path),
            arachnids_spawner_idle_animation(scale2, 1, path),
            arachnids_spawner_idle_animation(scale0, 2, path),
            arachnids_spawner_idle_animation(scale1, 3, path)
        }
        
        local unit = data.raw["unit-spawner"][splitter]
        unit.animations = animations
        unit.integration = { sheet = arachnids_spawner_integration(path) }

        local animation = {
            arachnids_spawner_die_animation(scale3, 0, path),
            arachnids_spawner_die_animation(scale2, 1, path),
            arachnids_spawner_die_animation(scale0, 2, path),
            arachnids_spawner_die_animation(scale1, 3, path),
        }

        local corpse =  data.raw["corpse"][splitter_corpse]
        corpse.animation = animation
        corpse.ground_patch = { sheet = arachnids_spawner_integration(path) }
        corpse.dying_speed = 0.04
    end

    local patch = function()
        local biter_spawner_scale_0 = 1.5
        local biter_spawner_scale_1 = 1.7
        local biter_spawner_scale_2 = 2
        local biter_spawner_scale_3 = 2.2

        patchSpawner(
            'biter-spawner', 'biter-spawner-corpse',
            'spitter-spawner', 'spitter-spawner-corpse',
            biter_spawner_scale_0, biter_spawner_scale_1, biter_spawner_scale_2, biter_spawner_scale_3,
            graphics.arahnids.spawner
        )
        -- try patch rampant
        patchSpawner(
            'acid-biter-spawner-v1-t1-rampant',
            'acid-biter-spawner-v1-t1-corpse-rampant',
            'acid-hive-v1-t1-rampant',
            'acid-hive-v1-t1-corpse-rampant',
            biter_spawner_scale_0, biter_spawner_scale_1, biter_spawner_scale_2, biter_spawner_scale_3,
            graphics.arahnids.spawner.rampant.acidic
        )
    end

    patch()
end
