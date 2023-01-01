local biterFunctions = {}

local sounds = require("__base__.prototypes.entity.sounds")
local unitSpawnerUtils = require("UnitSpawnerUtils")
local unitUtils = require("UnitUtils")
local wormUtils = require("WormUtils")
local particleUtils = require("ParticleUtils")

local biterdieanimation = unitUtils.biterdieanimation
local biterattackanimation = unitUtils.biterattackanimation
local biterrunanimation = unitUtils.biterrunanimation
local spitter_alternative_attacking_animation_sequence = unitUtils.spitter_alternative_attacking_animation_sequence
local spawner_integration = unitSpawnerUtils.spawner_integration
local spawner_idle_animation = unitSpawnerUtils.spawner_idle_animation
local spawner_die_animation = unitSpawnerUtils.spawner_die_animation
local wormFoldedAnimation = wormUtils.wormFoldedAnimation
local wormPreparingAnimation = wormUtils.wormPreparingAnimation
local wormPreparedAnimation = wormUtils.wormPreparedAnimation
local wormPreparedAlternativeAnimation = wormUtils.wormPreparedAlternativeAnimation
local wormStartAttackAnimation = wormUtils.wormStartAttackAnimation
local wormEndAttackAnimation = wormUtils.wormEndAttackAnimation
local wormDieAnimation = wormUtils.wormDieAnimation
local biter_water_reflection = unitUtils.biter_water_reflection
local spitter_water_reflection = unitUtils.spitter_water_reflection
local math3d = require "math3d"	-- + !КДА 2021.11
-- + !КДА 2021.11
local fireUtils = require("FireUtils")
fireUtils.makeAcidFireStream()	
-- - !КДА 2021.11
local makeDamagedParticle = particleUtils.makeDamagedParticle

local function makeSpitterCorpse(attributes)
    local name = attributes.name .. "-corpse-rampant"

    local corpse = {
        type = "corpse",
        name = name,
        icon = "__base__/graphics/icons/big-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selectable_in_game = false,
        selection_box = {{-1, -1}, {1, 1}},
        subgroup="corpses",
        order = "c[corpse]-b[spitter]-a[small]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-on-map"},
    }

    corpse.animation = spitterdyinganimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint)
    corpse.dying_speed = 0.04
    corpse.time_before_removed = 15 * 60 * 60
    corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
    corpse.shuffle_directions_at_frame = 4
    corpse.final_render_layer = "lower-object-above-shadow"

    corpse.ground_patch_render_layer = "decals" -- "transport-belt-integration"
    corpse.ground_patch_fade_in_delay = 1 / 0.02 --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
    corpse.ground_patch_fade_in_speed = 0.002
    corpse.ground_patch_fade_out_start = 50 * 60
    corpse.ground_patch_fade_out_duration = 20 * 60

    local a = 1
    local d = 0.9
    corpse.ground_patch =
        {
            sheet =
                {
                    filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
                    flags = { "low-object" },
                    line_length = 4,
                    variation_count = 4,
                    frame_count = 1,
                    width = 84,
                    height = 68,
                    shift = util.by_pixel(1, 0),
                    tint = attributes.tint2 or attributes.tint or {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
                    scale = attributes.scale * 2,
                    hr_version =
                        {
                            filename = "__base__/graphics/entity/biter/hr-blood-puddle-var-main.png",
                            flags = { "low-object" },
                            line_length = 4,
                            variation_count = 4,
                            frame_count = 1,
                            width = 164,
                            height = 134,
                            shift = util.by_pixel(-0.5,-0.5),
                            tint = attributes.tint2 or attributes.tint or {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
                            scale = attributes.scale
                        }
                }
        }

    data:extend(
        {
            corpse
    })
    return name
end

local function makeBiterCorpse(attributes)
    local name = attributes.name .. "-corpse-rampant"

    local corpse = {
        type = "corpse",
        name = name,
        icon = "__base__/graphics/icons/small-biter-corpse.png",
        icon_size = 64,
        icon_mipmaps = 4,
        selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
        selectable_in_game = false,
        subgroup="corpses",
        order = "c[corpse]-a[biter]-a[small]",
        flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"}
    }

    corpse.animation = biterdieanimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint, attributes.altBiter)
    corpse.dying_speed = 0.04
    corpse.time_before_removed = 15 * 60 * 60
    corpse.direction_shuffle = { { 1, 2, 3, 16 }, { 4, 5, 6, 7 }, { 8, 9, 10, 11 }, { 12, 13, 14, 15 } }
    corpse.shuffle_directions_at_frame = 7
    corpse.final_render_layer = "lower-object-above-shadow"

    corpse.ground_patch_render_layer = "decals" -- "transport-belt-integration"
    corpse.ground_patch_fade_in_delay = 1 / 0.02 --  in ticks; 1/dying_speed to delay the animation until dying animation finishes
    corpse.ground_patch_fade_in_speed = 0.002
    corpse.ground_patch_fade_out_start = 50 * 60
    corpse.ground_patch_fade_out_duration = 20 * 60

    local a = 1
    local d = 0.9
    corpse.ground_patch =
        {
            sheet =
                {
                    filename = "__base__/graphics/entity/biter/blood-puddle-var-main.png",
                    flags = { "low-object" },
                    line_length = 4,
                    variation_count = 4,
                    frame_count = 1,
                    width = 84,
                    height = 68,
                    shift = util.by_pixel(1, 0),
                    tint = attributes.tint2 or attributes.tint or {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
                    scale = attributes.scale * 2,
                    hr_version =
                        {
                            filename = "__base__/graphics/entity/biter/hr-blood-puddle-var-main.png",
                            flags = { "low-object" },
                            line_length = 4,
                            variation_count = 4,
                            frame_count = 1,
                            width = 164,
                            height = 134,
                            shift = util.by_pixel(-0.5,-0.5),
                            tint = attributes.tint2 or attributes.tint or {r = 0.6 * d * a, g = 0.1 * d * a, b = 0.6 * d * a, a = a},
                            scale = attributes.scale
                        }
                }
        }

    data:extend({
            corpse
    })
    return name
end

local function makeUnitSpawnerCorpse(attributes)
    local name = attributes.name .. "-corpse-rampant"
    data:extend({
            {
                type = "corpse",
                name = name,
                flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
                icon = "__base__/graphics/icons/biter-spawner-corpse.png",
                icon_size = 64,
                icon_mipmaps = 4,
                collision_box = {{-2, -2}, {2, 2}},
                selection_box = {{-2, -2}, {2, 2}},
                selectable_in_game = false,
                dying_speed = 0.04,
                time_before_removed = 15 * 60 * 60,
                subgroup="corpses",
                order = "c[corpse]-c[spitter-spawner]",
                final_render_layer = "remnants",
                animation =
                    {
                        spawner_die_animation(0, attributes.tint, attributes.scale, attributes.tint2),
                        spawner_die_animation(1, attributes.tint, attributes.scale, attributes.tint2),
                        spawner_die_animation(2, attributes.tint, attributes.scale, attributes.tint2),
                        spawner_die_animation(3, attributes.tint, attributes.scale, attributes.tint2)
                    }
            }
    })
    return name
end

local function makeWormCorpse(attributes)
    local name = attributes.name .. "-corpse-rampant"
    data:extend({
            {
                type = "corpse",
                name = name,
                icon = "__base__/graphics/icons/medium-worm-corpse.png",
                icon_size = 64,
                icon_mipmaps = 4,
                selection_box = {{-0.8, -0.8}, {0.8, 0.8}},
                selectable_in_game = false,
                subgroup="corpses",
                order = "c[corpse]-c[worm]-b[medium]",
                flags = {"placeable-neutral", "placeable-off-grid", "building-direction-8-way", "not-repairable", "not-on-map"},
                dying_speed = 0.01,
                time_before_removed = 15 * 60 * 60,
                final_render_layer = "lower-object-above-shadow",
                animation = wormDieAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
                ground_patch =
                    {
                        sheet = worm_integration(attributes.scale)
                    }
            }
    })
    return name
end

-- + !КДА 2021.11
function biterFunctions.addTrigger_effect(trigger, addTrigger)
	if not trigger then
		return {addTrigger}
	end
	if not (type(trigger)=="table") then
		return {addTrigger}	
	end
	if not addTrigger then
		return trigger		
	end
	
	local returnValue = {}
	if trigger["type"] then	-- this is not array of triggers, we need {trigger1, trigger2, trigger}
		returnValue = {trigger}
	else
		for i = 1, #trigger do
			returnValue[i] = trigger[i]
		end	
	end
	returnValue[#returnValue+1] = addTrigger
	return returnValue
end
-- - !КДА 2021.11

function biterFunctions.makeBiter(attributes)
    local resistances = {}
    for k,v in pairs(attributes.resistances) do
        v.type = k
        resistances[#resistances+1] = v
    end
    --    print(name .. " " .. biterAttributes.health)
	local collisionBoxRange = (attributes.collisionModifier or 1)
	if not (collisionBoxRange == 0) then
		collisionBoxRange = math.max(collisionBoxRange, 0.1)
	end
				
    local entity = {
        type = "unit",
        name = attributes.name .. "-rampant",
		localised_name = {
            "",
            {"rampant."..attributes.faction},
            {"rampant."..attributes.unitName},
            {"rampant.t"..attributes.tier}
        },
        icon = "__base__/graphics/icons/small-biter.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = attributes.flags or {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        max_health = attributes.health or 1,
        order = "b-b-a",
        subgroup="enemies",
        healing_per_tick = attributes.healing or 0,
        damaged_trigger_effect = attributes.damaged_trigger_effect,		
        water_reflection = biter_water_reflection(attributes.scale),
        resistances = resistances,
        collision_box = {
            {-0.4 * collisionBoxRange, -0.4 * collisionBoxRange},
            {0.4 * collisionBoxRange, 0.4 * collisionBoxRange}
        },
        selection_box = {
            {-0.7 * attributes.scale, -1.5 * attributes.scale},
            {0.7 * attributes.scale, 0.3 * attributes.scale}
        },
        sticker_box = {
            {-0.6 * attributes.scale, -0.8 * attributes.scale},
            {0.6 * attributes.scale, 0}
        },
        attack_parameters = attributes.attack,
        vision_distance = attributes.vision or 30,
        movement_speed = attributes.movement,
        loot = attributes.loot,
        spawning_time_modifier = attributes.spawningTimeModifer or nil,
        distance_per_frame = attributes.distancePerFrame or 0.1,
        pollution_to_join_attack = attributes.pollutionToAttack or 200,
        distraction_cooldown = attributes.distractionCooldown or 300,
        corpse = makeBiterCorpse(attributes),
--        dying_explosion = attributes.explosion,
        dying_trigger_effect = attributes.dyingEffect,
        enemy_map_color = ((not settings.startup["rampantFixed--oldRedEnemyMapColor"].value) and attributes.tint2) or nil,
        affected_by_tiles = false,
        dying_sound = sounds.biter_dying(0.3 + (0.05 * attributes.effectiveLevel)),
        working_sound =  sounds.biter_calls(0.2 + (0.05 * attributes.effectiveLevel)),
        running_sound_animation_positions = {2,},
        run_animation = biterrunanimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint, attributes.altBiter),
        ai_settings = { destroy_when_commands_fail = false, allow_try_return_to_spawner = true }
    }
	if attributes.additionalFlags then
		for i = 1, #attributes.additionalFlags do
			entity.flags[#entity.flags+1] = attributes.additionalFlags[i]
		end
	end
    if attributes.collisionMask then
        entity.collision_mask = attributes.collisionMask
    end
	
	if not settings.startup["rampantFixed--removeBloodParticles"].value then
		entity.damaged_trigger_effect = biterFunctions.addTrigger_effect(entity.damaged_trigger_effect, makeDamagedParticle(attributes))
	end
    return entity
end

function biterFunctions.makeSpitter(attributes)
    local resistances = {}
    for k,v in pairs(attributes.resistances) do
        v.type = k
        resistances[#resistances+1] = v
    end
    --    print(name .. " " .. biterAttributes.health)
    local entity = {
        type = "unit",
        name = attributes.name .. "-rampant",
		localised_name = {
            "",
            {"rampant."..attributes.faction},
            {"rampant."..attributes.unitName},
            {"rampant.t"..attributes.tier}
        },
        icon = "__base__/graphics/icons/small-spitter.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = attributes.flags or {"placeable-player", "placeable-enemy", "placeable-off-grid", "not-repairable", "breaths-air"},
        max_health = attributes.health,
        order = "b-b-a",
        subgroup="enemies",
        healing_per_tick = attributes.healing,
        damaged_trigger_effect = attributes.damaged_trigger_effect,		
        resistances = resistances,
        collision_box = {{-0.4 * attributes.scale  * (attributes.collisionModifier or 1), -0.4 * attributes.scale  * (attributes.collisionModifier or 1)},
            {0.4 * attributes.scale  * (attributes.collisionModifier or 1), 0.4 * attributes.scale  * (attributes.collisionModifier or 1)}},
        selection_box = {{-0.7 * attributes.scale, -1.5 * attributes.scale},
            {0.7 * attributes.scale, 0.3 * attributes.scale}},
        sticker_box = {{-0.6 * attributes.scale, -0.8 * attributes.scale},
            {0.6 * attributes.scale, 0}},
        attack_parameters = attributes.attack,
        loot = attributes.loot,
        vision_distance = attributes.vision or 30,
        movement_speed = attributes.movement,
        spawning_time_modifier = attributes.spawningTimeModifer or nil,
        distance_per_frame = attributes.distancePerFrame or 0.1,
        pollution_to_join_attack = attributes.pollutionToAttack or 200,
        distraction_cooldown = attributes.distractionCooldown or 300,
        alternative_attacking_frame_sequence = spitter_alternative_attacking_animation_sequence(),
        corpse = makeSpitterCorpse(attributes),
--        dying_explosion = attributes.explosion,
        enemy_map_color = ((not settings.startup["rampantFixed--oldRedEnemyMapColor"].value) and attributes.tint2) or nil,
        dying_trigger_effect = attributes.dyingEffect,
        dying_sound =  sounds.spitter_dying(0.3 + (0.05 * attributes.effectiveLevel)),
        working_sound =  sounds.biter_calls(0.2 + (0.05 * attributes.effectiveLevel)),
        running_sound_animation_positions = {2,},
        water_reflection = spitter_water_reflection(attributes.scale),
        affected_by_tiles = false,
        run_animation = spitterrunanimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        ai_settings = { destroy_when_commands_fail = false, allow_try_return_to_spawner = true }
    }
	if attributes.additionalFlags then
		for i = 1, #attributes.additionalFlags do
			entity.flags[#entity.flags+1] = attributes.additionalFlags[i]
		end
	end
    if attributes.collisionMask then
        entity.collision_mask = attributes.collisionMask
    end
	if not settings.startup["rampantFixed--removeBloodParticles"].value then
		entity.damaged_trigger_effect = biterFunctions.addTrigger_effect(entity.damaged_trigger_effect, makeDamagedParticle(attributes))
	end
    return entity
end

function biterFunctions.makeUnitSpawner(attributes)
    local resistances = {}
    for k,v in pairs(attributes.resistances) do
        v.type = k
        resistances[#resistances+1] = v
    end
    -- print(attributes.name)
    local o = {
        type = "unit-spawner",
        name = attributes.name .. "-rampant",
		localised_name = {
            "",
            {"rampant."..attributes.faction},
            {"rampant."..attributes.unitName},
            {"rampant.t"..attributes.tier}
        },
        icon = "__base__/graphics/icons/biter-spawner.png",
        icon_size = 64,
        icon_mipmaps = 4,
        flags = {"placeable-player", "placeable-enemy", "not-repairable"},
        max_health = attributes.health,
        order="b-b-g",
        subgroup="enemies",
        loot = attributes.loot,
        resistances = resistances,
        working_sound =
            {
                sound =
                    {
                        {
                            filename = "__base__/sound/creatures/spawner.ogg",
                            volume = 0.2 + (0.05 * attributes.effectiveLevel)
                        }
                    },
                apparent_volume = 0.4 + (0.1 * attributes.effectiveLevel)
            },
        dying_sound =
            {
                {
                    filename = "__base__/sound/creatures/spawner-death-1.ogg",
                    volume = 0.4 + (0.05 * attributes.effectiveLevel)
                },
                {
                    filename = "__base__/sound/creatures/spawner-death-2.ogg",
                    volume = 0.4 + (0.05 * attributes.effectiveLevel)
                }
            },
        healing_per_tick = attributes.healing or 0.02,
        collision_box = {{-3.0 * attributes.scale, -2.0 * attributes.scale}, {2.0 * attributes.scale, 2.0 * attributes.scale}},
        selection_box = {{-3.5 * attributes.scale, -2.5 * attributes.scale}, {2.5 * attributes.scale, 2.5 * attributes.scale}},
        -- in ticks per 1 pu
        pollution_absorption_absolute = attributes.pollutionAbsorptionAbs or 20,
        pollution_absorption_proportional = attributes.pollutionAbsorptionPro or 0.01,
        map_generator_bounding_box = {{-4.2 * attributes.scale, -3.2 * attributes.scale}, {3.2 * attributes.scale, 3.2 * attributes.scale}},
        corpse = makeUnitSpawnerCorpse(attributes),
        dying_explosion = attributes.explosion or "blood-explosion-huge",
        dying_trigger_effect = attributes.dyingEffect,
        max_count_of_owned_units = attributes.unitsOwned or 7,
        max_friends_around_to_spawn = attributes.unitsToSpawn or 5,
        enemy_map_color = ((not settings.startup["rampantFixed--oldRedEnemyMapColor"].value) and attributes.tint2) or nil,
        animations =
            {
                spawner_idle_animation(0, attributes.tint, attributes.scale, attributes.tint2 or attributes.tint),
                spawner_idle_animation(1, attributes.tint, attributes.scale, attributes.tint2 or attributes.tint),
                spawner_idle_animation(2, attributes.tint, attributes.scale, attributes.tint2 or attributes.tint),
                spawner_idle_animation(3, attributes.tint, attributes.scale, attributes.tint2 or attributes.tint)
            },
        integration =
            {
                sheet = spawner_integration(attributes.scale)
            },
        result_units = attributes.unitSet,
        -- With zero evolution the spawn rate is 6 seconds, with max evolution it is 2.5 seconds
        spawning_cooldown = attributes.spawningCooldown or ((attributes.spawningCooldownStart and attributes.spawningCooldownEnd) and {attributes.spawningCooldownStart, attributes.spawningCooldownEnd}) or {360, 150},
        spawning_radius = attributes.spawningRadius or 10,
        spawning_spacing = attributes.spawningSpacing or 3,
        max_spawn_shift = 0,
        max_richness_for_spawn_shift = 100,
        build_base_evolution_requirement = attributes.evolutionRequirement or 0.0,
        call_for_help_radius = attributes.helpRadius or 50,
        spawn_decorations_on_expansion = true,
        spawn_decoration =
            {
                {
                    decorative = "light-mud-decal",
                    spawn_min = 0,
                    spawn_max = 2,
                    spawn_min_radius = 2,
                    spawn_max_radius = 5,
                },
                {
                    decorative = "dark-mud-decal",
                    spawn_min = 0,
                    spawn_max = 3,
                    spawn_min_radius = 2,
                    spawn_max_radius = 6,
                },
                {
                    decorative = "enemy-decal",
                    spawn_min = 3,
                    spawn_max = 5,
                    spawn_min_radius = 2,
                    spawn_max_radius = 7,
                },
                {
                    decorative = "enemy-decal-transparent",
                    spawn_min = 4,
                    spawn_max = 20,
                    spawn_min_radius = 2,
                    spawn_max_radius = 14,
                    radius_curve = 0.9
                },
                {
                    decorative = "muddy-stump",
                    spawn_min = 2,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6,
                },
                {
                    decorative = "red-croton",
                    spawn_min = 2,
                    spawn_max = 8,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6,
                },
                {
                    decorative = "red-pita",
                    spawn_min = 1,
                    spawn_max = 5,
                    spawn_min_radius = 3,
                    spawn_max_radius = 6,
                },
                {
                    decorative = "lichen-decal",
                    spawn_min = 1,
                    spawn_max = 2,
                    spawn_min_radius = 2,
                    spawn_max_radius = 7
                }
            }
    }
	if attributes.additionalFlags then
		for i = 1, #attributes.additionalFlags do
			entity.flags[#entity.flags+1] = attributes.additionalFlags[i]
		end
	end
    if attributes.autoplace then
        o["autoplace"] = enemy_spawner_autoplace(attributes.autoplace)
    end
    return o
end

function biterFunctions.makeWorm(attributes)
    local resistances = {}
    for k,v in pairs(attributes.resistances) do
        v.type = k
        resistances[#resistances+1] = v
    end
	-- if attributes.clusterAttack then
		-- error(serpent.dump(attributes.attack))
	-- end	
    --    print(name .. " " .. attributes.health)
    local o = {
        type = "turret",
        name = attributes.name .. "-rampant",
		localised_name = {
            "",
            {"rampant."..attributes.faction},
            {"rampant."..attributes.unitName},
            {"rampant.t"..attributes.tier}
        },
        icon = "__base__/graphics/icons/medium-worm.png",
        icon_size = 64, icon_mipmaps = 4,
        flags = attributes.flags or {"placeable-player", "placeable-enemy", "not-repairable", "not-repairable", "breaths-air"},
        order="b-b-e",
        subgroup="enemies",
        max_health = attributes.health,
        loot = attributes.loot,
        -- shooting_cursor_size = 3.5 * attributes.scale,
        resistances = resistances,
        healing_per_tick = attributes.healing or 0.01,
        collision_box = {{-1.1 * attributes.scale, -1.0 * attributes.scale}, {1.1 * attributes.scale, 1.0 * attributes.scale}},
        selection_box = {{-1.1 * attributes.scale, -1.0 * attributes.scale}, {1.1 * attributes.scale, 1.0 * attributes.scale}},
        shooting_cursor_size = attributes.cursorSize or 3,
        rotation_speed = attributes.rotationSpeed or 1,
        corpse = makeWormCorpse(attributes),
        dying_explosion = attributes.explosion or "blood-explosion-big",
        dying_trigger_effect = attributes.dyingEffect,
        inventory_size = attributes.inventorySize,
        dying_sound = sounds.worm_dying(0.3 + (0.05 * attributes.effectiveLevel)),
        folded_speed = 0.01,
        folded_speed_secondary = 0.024,
        folded_animation = wormFoldedAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        preparing_speed = attributes.preparingSpeed or 0.024,
        preparing_animation = wormPreparingAnimation(attributes.scale, attributes.tint, "forward", attributes.tint2 or attributes.tint),
        preparing_sound = sounds.worm_standup(0.4 + (0.05 * attributes.effectiveLevel)),
        prepared_speed = 1,		-- 0.024
--        prepared_speed_secondary = 0.012,		--0.012,
        prepared_animation = wormPreparedAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        prepared_sound = sounds.worm_breath(0.2 + (0.05 * attributes.effectiveLevel)),
        -- prepared_alternative_speed = 0.5,	--0.014,
        -- prepared_alternative_speed_secondary = 0.5,	--0.010,
        -- prepared_alternative_chance = 0.2,
        -- prepared_alternative_animation = wormPreparedAlternativeAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        -- prepared_alternative_sound = sounds.worm_roar_alternative(0.2 + (0.05 * attributes.effectiveLevel)),


        starting_attack_speed = 0.1,	--0.034,
        starting_attack_animation = wormStartAttackAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        starting_attack_sound = sounds.worm_roars(0.2 + (0.05 * attributes.effectiveLevel)),
        ending_attack_speed = 0.1,	--0.016,
        ending_attack_animation = wormEndAttackAnimation(attributes.scale, attributes.tint, attributes.tint2 or attributes.tint),
        folding_speed = 0.1,		--attributes.foldingSpeed or 0.015,
        folding_animation =  wormPreparingAnimation(attributes.scale, attributes.tint, "backward", attributes.tint2 or attributes.tint),
        folding_sound = sounds.worm_fold (0.4 + (0.05 * attributes.effectiveLevel)),
        prepare_range = attributes.prepareRange or (attributes.range and (attributes.range+7)) or 30,	-- + !КДА 2021.11 and (attributes.range+7))
        integration = worm_integration(attributes.scale),
        attack_parameters = attributes.attack,
        secondary_animation = true,
        enemy_map_color = ((not settings.startup["rampantFixed--oldRedEnemyMapColor"].value) and attributes.tint2) or nil,
        random_animation_offset = true,
        attack_from_start_frame = true,

        allow_turning_when_starting_attack = true,
        build_base_evolution_requirement = attributes.evolutionRequirement or 0.0,
        call_for_help_radius = attributes.helpRadius or 60,
        spawn_decorations_on_expansion = true,
        spawn_decoration =
            {
                {
                    decorative = "worms-decal",
                    spawn_min = 1,
                    spawn_max = 3,
                    spawn_min_radius = 1,
                    spawn_max_radius = 5
                },
                {
                    decorative = "shroom-decal",
                    spawn_min = 1,
                    spawn_max = 2,
                    spawn_min_radius = 1,
                    spawn_max_radius = 2
                },
                {
                    decorative = "enemy-decal",
                    spawn_min = 1,
                    spawn_max = 4,
                    spawn_min_radius = 1,
                    spawn_max_radius = 4,
                },
                {
                    decorative = "enemy-decal-transparent",
                    spawn_min = 3,
                    spawn_max = 5,
                    spawn_min_radius = 1,
                    spawn_max_radius = 4,
                },
            }
    }

	if attributes.additionalFlags then
		for i = 1, #attributes.additionalFlags do
			entity.flags[#entity.flags+1] = attributes.additionalFlags[i]
		end
	end
    if attributes.autoplace then
        o["autoplace"] = enemy_worm_autoplace(attributes.autoplace)
    end
    return o

end

function biterFunctions.createSuicideAttack(attributes, blastWave, animation)
    local o = {
        type = "projectile",
        range = 2,
        cooldown = attributes.cooldown or 35,
        range_mode = "bounding-box-to-bounding-box",
        ammo_category = "melee",
        ammo_type = {
            category = "biological"
        },
        sound = sounds.biter_roars(0.3 + (attributes.effectiveLevel * 0.05)),
        animation = animation
    }

    if attributes.nuclear then
		o.range = 5	-- + !КДА
        o.ammo_type.action = {
            type = "direct",
            action_delivery =
                {
                     type = "instant",
                    target_effects = {
						{
							type = "damage",
							show_in_tooltip = true,
							affects_target = true,
							damage = {amount = attributes.damage, type = "explosion"}
						}
					},
					source_effects = {
						{
							type = "damage",
							affects_target = true,
							show_in_tooltip = false,
							damage = {amount = attributes.healthDamage or 5, type = "explosion"}
						},
					-- },
                    -- target_effects =
                        -- {
                            {
                                type = "set-tile",
                                tile_name = "nuclear-ground",
                                radius = attributes.radius * 0.25,
                                apply_projection = true,
                                tile_collision_mask = { "water-tile" },
                            },
                            {
                                type = "destroy-cliffs",
                                radius = attributes.radius * 0.18,
                                explosion = "explosion"
                            },
                            {
                                type = "create-entity",
                                entity_name = "nuke-explosion"
                            },
                            {
                                type = "camera-effect",
                                effect = "screen-burn",
                                duration = 60,
                                ease_in_duration = 5,
                                ease_out_duration = 60,
                                delay = 0,
                                strength = 6,
                                full_strength_max_distance = 200,
                                max_distance = 800
                            },
                            {
                                type = "play-sound",
                                sound = sounds.nuclear_explosion(0.9),
                                play_on_target_position = false,
                                -- min_distance = 200,
                                max_distance = 1000,
                                -- volume_modifier = 1,
                                audible_distance_modifier = 3
                            },
                            {
                                type = "play-sound",
                                sound = sounds.nuclear_explosion_aftershock(0.4),
                                play_on_target_position = false,
                                -- min_distance = 200,
                                max_distance = 1000,
                                -- volume_modifier = 1,
                                audible_distance_modifier = 3
                            },
                            -- {
                                -- type = "damage",
								-- show_in_tooltip = true,
								-- affects_target = true,
                                -- damage = {amount = attributes.damage, type = "explosion"}
                            -- },
                            {
                                type = "create-entity",
                                entity_name = "huge-scorchmark",
                                check_buildability = true,
                            },
                            {
                                type = "invoke-tile-trigger",
                                repeat_count = 1,
                            },
                            {
                                type = "destroy-decoratives",
                                include_soft_decoratives = true, -- soft decoratives are decoratives with grows_through_rail_path = true
                                include_decals = true,
                                invoke_decorative_trigger = true,
                                decoratives_with_trigger_only = false, -- if true, destroys only decoratives that have trigger_effect set
                                radius = attributes.radius * 0.35 -- large radius for demostrative purposes
                            },
                            {
                                type = "create-decorative",
                                decorative = "nuclear-ground-patch",
                                spawn_min_radius = attributes.radius * 0.1,
                                spawn_max_radius = attributes.radius * 0.12,
                                spawn_min = 30,
                                spawn_max = 40,
                                apply_projection = true,
                                spread_evenly = true
                            },
                            {
                                type = "nested-result",
								show_in_tooltip = true,
								affects_target = true,
                                action =
                                    {
                                        type = "area",
                                        target_entities = false,
										show_in_tooltip = true,
                                        trigger_from_target = true,
                                        repeat_count = 100,
                                        radius = attributes.radius * 0.30,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-ground-zero-projectile",
                                                starting_speed = 0.6 * 0.8,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
								show_in_tooltip = true,
								affects_target = true,
                                action =
                                    {
                                        type = "area",
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 100,
                                        radius = attributes.radius,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-wave",
                                                starting_speed = 0.5 * 0.7,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
                                action =
                                    {
                                        type = "area",
                                        show_in_tooltip = false,
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 100,
                                        radius = attributes.radius * 0.75,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-wave-spawns-cluster-nuke-explosion",
                                                starting_speed = 0.5 * 0.7,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
                                action =
                                    {
                                        type = "area",
                                        show_in_tooltip = false,
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 50,
                                        radius = attributes.radius * 0.07,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-wave-spawns-fire-smoke-explosion",
                                                starting_speed = 0.5 * 0.65,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
                                action =
                                    {
                                        type = "area",
                                        show_in_tooltip = false,
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 100,
                                        radius = attributes.radius * 0.07,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-wave-spawns-nuke-shockwave-explosion",
                                                starting_speed = 0.5 * 0.65,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
                                action =
                                    {
                                        type = "area",
                                        show_in_tooltip = false,
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 100,
                                        radius = attributes.radius * 0.85,
                                        action_delivery =
                                            {
                                                type = "projectile",
                                                projectile = "atomic-bomb-wave-spawns-nuclear-smoke",
                                                starting_speed = 0.5 * 0.65,
                                                starting_speed_deviation = nuke_shockwave_starting_speed_deviation,
                                            }
                                    }
                            },
                            {
                                type = "nested-result",
                                action =
                                    {
                                        type = "area",
                                        show_in_tooltip = false,
                                        target_entities = false,
                                        trigger_from_target = true,
                                        repeat_count = 10,
                                        radius = attributes.radius * 0.18,
                                        action_delivery =
                                            {
                                                type = "instant",
                                                target_effects =
                                                    {
                                                        {
                                                            type = "create-entity",
                                                            entity_name = "nuclear-smouldering-smoke-source",
                                                            tile_collision_mask = { "water-tile" }
                                                        }
                                                    }
                                            }
                                    }
                            }
                        }
                }
        }
    else
        o.ammo_type.action = {
            type = "direct",
            action_delivery = {
                type = "instant",
                source_effects = {
                    {
                        type = "damage",
                        affects_target = true,
                        show_in_tooltip = false,
                        damage = {amount =attributes.healthDamage or 5, type = "explosion"}
                    }
                },
                target_effects = {
                    {
                        type = "create-entity",
                        entity_name = attributes.attackExplosion
                    },
                    {
                        type = "nested-result",
                        action = {
                            type = "area",
                            radius = attributes.radius,
							force = "not-same", 
                            action_delivery = {
                                type = "instant",
                                target_effects = {
                                    {
                                        type = "damage",
                                        damage = {
                                            amount = attributes.damage,
                                            type = attributes.damageType or "explosion"
                                        }
                                    },
                                }
                            }
                        }
                    },
                    {
                        type = "create-entity",
                        entity_name = attributes.attackScorchmark or "small-scorchmark",
                        check_buildability = true
                    }
                }

            },
        }

    end
    return o
end

-- + !КДА 2021.11
function biterFunctions.makeflamerAtack(range, damage, animation)
    local attack_parameters =
    {
      type = "stream",
      cooldown = 20,
      range = range,
      min_range = 1,

      turn_range = 1,	-- 1.0 / 3.0
      fire_penalty = 15,
	  damage_modifier = damage*0.04,	

      gun_barrel_length = 0.4,

	  animation = animation,
      ammo_type =
      {
        category = "biological",
        action =
        {
          type = "direct",
          action_delivery = 	--flamesteam(damage)
         {
            type = "stream",
            stream = "acidFire-stream-rampant",
           source_offset = {0.15, -0.5}
          }
        }
      },

      cyclic_sound =
      {
        begin_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-start-03.ogg",
            volume = 0.5
          }
        },
        middle_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-mid-03.ogg",
            volume = 0.5
          }
        },
        end_sound =
        {
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-01.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-02.ogg",
            volume = 0.5
          },
          {
            filename = "__base__/sound/fight/flamethrower-turret-end-03.ogg",
            volume = 0.5
          }
        }
      }
    } 
	return attack_parameters
end
-- + !КДА 2021.11

-- + !КДА 2021.12
function biterFunctions.makeMeleePoisonCloud(range, tier, animation)
    local attack_parameters =
    {
        type = "projectile",
        range = range,
        cooldown = 30,
        range_mode = "bounding-box-to-bounding-box",
        ammo_category = "melee",
        ammo_type = {
            category = "biological",
			action =
			{
			  {
				type = "direct",
				action_delivery =
				{
				  type = "instant",
				  target_effects =
				  {
					{
					  type = "create-smoke",
					  show_in_tooltip = true,
					  entity_name = "poison-cloud-Dmg-Heal"..tier.."-cloud-rampant",
					  initial_height = 0
					}
				  }
				}
			  }
			},
			
         },
        animation = animation
	}
	return attack_parameters
end
-- + !КДА 2021.11


function biterFunctions.makeWormAlienLootTable(name)
    local biterLoot

    local a = settings.startup["bobmods-enemies-enableartifacts"]
    local b = settings.startup["NE_Alien_Artifacts"]
    local d = settings.startup["NE_Bio_Ammo_Damage"]
    local artifacts = (a and a.value) or (b and b.value) or d
    local c = settings.startup["bobmods-enemies-enablenewartifacts"]
    local newArtifacts = c and c.value

    if newArtifacts and name then
		local itemname = "alien-artifact-" .. name
		if data.raw["item"][itemname] then
			biterLoot = {
				[1] = {  item = itemname,  count_min = 1,  count_max = 1,  probability = 0.5 },
				[2] = {  item = itemname,  count_min = 1,  count_max = 2,  probability = 0.5 },
				[3] = {  item = itemname,  count_min = 1,  count_max = 3,  probability = 0.5 },
				[4] = {  item = itemname,  count_min = 2,  count_max = 3,  probability = 0.5 },
				[5] = {  item = itemname,  count_min = 2,  count_max = 3,  probability = 0.5 },
				[6] = {  item = itemname,  count_min = 2,  count_max = 3,  probability = 0.5 },
				[7] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.75 },
				[8] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.75 },
				[9] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.75 },
				[10] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.75 }
			}
		end	
    elseif artifacts then
        biterLoot = {
            [1] = {  item = "alien-artifact",  count_min = 1,  count_max = 1,  probability = 0.5 },
            [2] = {  item = "alien-artifact",  count_min = 1,  count_max = 2,  probability = 0.5 },
            [3] = {  item = "alien-artifact",  count_min = 1,  count_max = 3,  probability = 0.5 },
            [4] = {  item = "alien-artifact",  count_min = 2,  count_max = 3,  probability = 0.5 },
            [5] = {  item = "alien-artifact",  count_min = 2,  count_max = 3,  probability = 0.5 },
            [6] = {  item = "alien-artifact",  count_min = 2,  count_max = 3,  probability = 0.5 },
            [7] = {  item = "alien-artifact",  count_min = 2,  count_max = 4,  probability = 0.75 },
            [8] = {  item = "alien-artifact",  count_min = 2,  count_max = 4,  probability = 0.75 },
            [9] = {  item = "alien-artifact",  count_min = 2,  count_max = 4,  probability = 0.75 },
            [10] = {  item = "alien-artifact",  count_min = 3,  count_max = 4,  probability = 0.75 }
        }
    end

    return biterLoot
end

function biterFunctions.makeSpawnerAlienLootTable(name)
    local biterLoot
    local a = settings.startup["bobmods-enemies-enableartifacts"]
    local b = settings.startup["NE_Alien_Artifacts"]
    local d = settings.startup["NE_Bio_Ammo_Damage"]
    local artifacts = (a and a.value) or (b and b.value) or d
    local c = settings.startup["bobmods-enemies-enablenewartifacts"]
    local newArtifacts = c and c.value

    if newArtifacts and name then
		local itemname = "alien-artifact-" .. name
		if data.raw["item"][itemname] then
        biterLoot = {
            [1] = {  item = itemname,  count_min = 1,  count_max = 1,  probability = 0.5 },
            [2] = {  item = itemname,  count_min = 1,  count_max = 2,  probability = 0.5 },
            [3] = {  item = itemname,  count_min = 1,  count_max = 3,  probability = 0.5 },
            [4] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.5 },
            [5] = {  item = itemname,  count_min = 2,  count_max = 5,  probability = 0.5 },
            [6] = {  item = itemname,  count_min = 2,  count_max = 5,  probability = 0.5 },
            [7] = {  item = itemname,  count_min = 2,  count_max = 6,  probability = 0.75 },
            [8] = {  item = itemname,  count_min = 2,  count_max = 6,  probability = 0.75 },
            [9] = {  item = itemname,  count_min = 3,  count_max = 7,  probability = 0.75 },
            [10] = {  item = itemname,  count_min = 3,  count_max = 7,  probability = 0.75 }
        }
		end
    elseif artifacts then
        biterLoot = {
            [1] = {  item = "alien-artifact",  count_min = 1,  count_max = 1,  probability = 0.5 },
            [2] = {  item = "alien-artifact",  count_min = 1,  count_max = 2,  probability = 0.5 },
            [3] = {  item = "alien-artifact",  count_min = 1,  count_max = 3,  probability = 0.5 },
            [4] = {  item = "alien-artifact",  count_min = 2,  count_max = 4,  probability = 0.5 },
            [5] = {  item = "alien-artifact",  count_min = 2,  count_max = 5,  probability = 0.5 },
            [6] = {  item = "alien-artifact",  count_min = 1,  count_max = 3,  probability = 0.5 },
            [7] = {  item = "alien-artifact",  count_min = 2,  count_max = 5,  probability = 0.75 },
            [8] = {  item = "alien-artifact",  count_min = 3,  count_max = 6,  probability = 0.75 },
            [9] = {  item = "alien-artifact",  count_min = 3,  count_max = 6,  probability = 0.75 },
            [10] = {  item = "alien-artifact",  count_min = 3,  count_max = 7,  probability = 0.75 }
        }
    end

    return biterLoot
end

function biterFunctions.makeUnitAlienLootTable(name)
    local biterLoot
    local a = settings.startup["bobmods-enemies-enableartifacts"]
    local b = settings.startup["NE_Alien_Artifacts"]
    local artifacts = (a and a.value) or (b and b.value)
    local c = settings.startup["bobmods-enemies-enablesmallartifacts"]
    local smallArtifacts = (c and c.value) or (b and b.value)
    local d = settings.startup["bobmods-enemies-enablenewartifacts"]
    local newArtifacts = d and d.value

    if (c and c.value) and newArtifacts and name then
		local itemname = "small-alien-artifact-" .. name
		if data.raw["item"][itemname] then
        biterLoot = {
            [1] = {  item = itemname,  count_min = 1,  count_max = 1,  probability = 0.25 },
            [2] = {  item = itemname,  count_min = 1,  count_max = 2,  probability = 0.25 },
            [3] = {  item = itemname,  count_min = 1,  count_max = 3,  probability = 0.25 },
            [4] = {  item = itemname,  count_min = 2,  count_max = 4,  probability = 0.5 },
            [5] = {  item = itemname,  count_min = 2,  count_max = 5,  probability = 0.5 },
            [6] = {  item = itemname,  count_min = 2,  count_max = 5,  probability = 0.5 },
            [7] = {  item = itemname,  count_min = 2,  count_max = 6,  probability = 0.75 },
            [8] = {  item = itemname,  count_min = 2,  count_max = 6,  probability = 0.75 },
            [9] = {  item = itemname,  count_min = 3,  count_max = 7,  probability = 0.75 },
            [10] = {  item = itemname,  count_min = 3,  count_max = 7,  probability = 0.75 }
        }
		end
    elseif smallArtifacts then
        biterLoot = {
            [1] = {  item = "small-alien-artifact",  count_min = 1,  count_max = 1,  probability = 0.25 },
            [2] = {  item = "small-alien-artifact",  count_min = 1,  count_max = 2,  probability = 0.25 },
            [3] = {  item = "small-alien-artifact",  count_min = 1,  count_max = 3,  probability = 0.25 },
            [4] = {  item = "small-alien-artifact",  count_min = 2,  count_max = 4,  probability = 0.5 },
            [5] = {  item = "small-alien-artifact",  count_min = 2,  count_max = 5,  probability = 0.5 },
            [6] = {  item = "small-alien-artifact",  count_min = 2,  count_max = 5,  probability = 0.5 },
            [7] = {  item = "small-alien-artifact",  count_min = 2,  count_max = 6,  probability = 0.75 },
            [8] = {  item = "small-alien-artifact",  count_min = 2,  count_max = 6,  probability = 0.75 },
            [9] = {  item = "small-alien-artifact",  count_min = 3,  count_max = 7,  probability = 0.75 },
            [10] = {  item = "small-alien-artifact",  count_min = 3,  count_max = 7,  probability = 0.75 }
        }
    elseif artifacts then
        biterLoot = {
            [1] = nil,
            [2] = nil,
            [3] = nil,
            [4] = nil,
            [5] = nil,
            [6] = {  item = "alien-artifact",  count_min = 1,  count_max = 3,  probability = 0.5 },
            [7] = {  item = "alien-artifact",  count_min = 2,  count_max = 5,  probability = 0.75 },
            [8] = {  item = "alien-artifact",  count_min = 3,  count_max = 6,  probability = 0.75 },
            [9] = {  item = "alien-artifact",  count_min = 3,  count_max = 6,  probability = 0.75 },
            [10] = {  item = "alien-artifact",  count_min = 3,  count_max = 7,  probability = 0.75 }
        }
    end

    return biterLoot
end

------- SchallAlienLoot
function biterFunctions.makeSchallAlienLootTables()
    local lootTables = {}	
	if not settings.startup["alienloot-artifact-drop"] then
		return lootTables
	end	
	local artifactDrop = settings.startup["alienloot-artifact-drop"].value
	local tierMultiplier = settings.startup["alienloot-loot-tier-multiplier"].value
	local artifactAmountSpawner = settings.startup["alienloot-artifact-amount-spawner"].value
	local richness = settings.startup["alienloot-richness"].value
			
	local richness_Table = {
	["none"] = 0,
	["basic"] = 1,
	["low"] = 1.5,
	["medium"] = 2,
	["2×"] = 4,
	["4×"] = 8,
	}		
	local count_max = (richness_Table[richness] or 0)
	if count_max == 0 then
		return lootTables
	end
	
	local alienOre1 = "alien-ore-1"
	local alienOre2 = "alien-ore-2"
	local alienOre3 = "alien-ore-3"
	local alienArtifact = "alien-artifact"
	local tierMultipliers = {}
	for i = 1, 4 do
		tierMultipliers[i] = tierMultiplier^(i-1)
	end
	local artifact_table = {
	  ["off"]           = {spawner = false, worm = false, mover = false},
	  ["spawner"]       = {spawner = true,  worm = false, mover = false},
	  ["spawner-worm"]  = {spawner = true,  worm = true,  mover = false},
	  ["all"]           = {spawner = true,  worm = true,  mover = true },
	}
	
	if artifact_table[artifactDrop].mover then
        lootTables.biterLoot = {
            [1] = {{ item = alienOre1,  count_min = 1,  count_max = count_max,  probability = 0.5 }},
            [2] = {{ item = alienOre1,  count_min = 1,  count_max = count_max,  probability = 1}},
            [3] = {{ item = alienOre1,  count_min = 1,  count_max = count_max,  probability = 1}, 	{ item = alienOre2,  count_min = 1,  count_max = count_max,  probability = 0.25}},
            [4] = {{ item = alienOre1,  count_min = 1,  count_max = count_max,  probability = 1}, 	{ item = alienOre2,  count_min = 1,  count_max = count_max,  probability = 0.5}},
            [5] = {{ item = alienOre1,  count_min = 1,  count_max = count_max,  probability = 0.5}, { item = alienOre2,  count_min = 1,  count_max = count_max,  probability = 1}},
            [6] = {{ item = alienOre2,  count_min = 1,  count_max = count_max,  probability = 1}, 	{ item = alienOre3,  count_min = 1,  count_max = count_max,  probability = 0.25}},
            [7] = {{ item = alienOre2,  count_min = 1,  count_max = count_max,  probability = 0.5}, { item = alienOre3,  count_min = 1,  count_max = count_max,  probability = 0.5}},
            [8] = {{ item = alienOre3,  count_min = 1,  count_max = count_max,  probability = 1}, 	{ item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 0.25}},
            [9] = {{ item = alienOre3,  count_min = 1,  count_max = count_max,  probability = 0.5}, { item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 0.5}},
            [10] ={{ item = alienOre3,  count_min = 1,  count_max = count_max,  probability = 0.5},{ item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 1}},
       }
	end	
	if artifact_table[artifactDrop].worm then
        lootTables.wormLoot = {
            [1] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 0.25 }},
            [2] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 0.30 }},
            [3] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max,  probability = 0.35 }},
            [4] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[2],  probability = 0.40 }},
            [5] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[2],  probability = 0.45 }},
            [6] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[2],  probability = 0.50 }},
            [7] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[3],  probability = 0.55 }},
            [8] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[3],  probability = 0.60 }},
            [9] = {{   item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[3],  probability = 0.65 }},
            [10] = {{  item = alienArtifact,  count_min = 1,  count_max = count_max * tierMultipliers[4],  probability = 0.70 }}
        }
	end	
	if artifact_table[artifactDrop].spawner then
        lootTables.spawnerLoot = {
            [1] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner,  probability = 0.65 }},
            [2] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner,  probability = 0.70 }},
            [3] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner,  probability = 0.75 }},
            [4] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[2],  probability = 0.80 }},
            [5] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[2],  probability = 0.85 }},
            [6] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[2],  probability = 0.90 }},
            [7] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[3],  probability = 0.95 }},
            [8] = {{ item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[3],  probability = 1.00 }},
            [9] = {{  item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[3],  probability = 1.00 }},
            [10] = {{ item = alienArtifact,  count_min = 1,  count_max = artifactAmountSpawner * tierMultipliers[4],  probability = 1.00 }}
        }
	end	
	return lootTables	
end
-------
------- alien-module mod (aka Alien Loot Economy).
function biterFunctions.makeAlienLootEconomyTables()
    local lootTables = {}	
	if not settings.startup["alien-module-drop-amount"] then
		return lootTables
	end	
	local kf = settings.startup["alien-module-drop-amount"].value / 100
	
	local alienOre = "artifact-ore"
	
	lootTables.biterLoot = {
		[1] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.2}},
		[2] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.3}},
		[3] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.4}},
		[4] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.5}},
		[5] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.6}},
		[6] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.7}},
		[7] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.8}},
		[8] = {{ item = alienOre,   count_min = kf,  count_max = kf,  probability = 0.9}},
		[9] = {{ item = alienOre,  count_min = kf,  count_max = kf,  probability = 1}},
		[10] ={{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 1}},
   }
	lootTables.wormLoot = {
		[1] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.2}},
		[2] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.3}},
		[3] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.4}},
		[4] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.5}},
		[5] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.6}},
		[6] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.7}},
		[7] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.8}},
		[8] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 0.9}},
		[9] = {{ item = alienOre,  count_min = kf,  count_max = 2*kf,  probability = 1}},
		[10] ={{ item = alienOre,  count_min = 2*kf,  count_max = 3*kf,  probability = 1}},
	}
	lootTables.spawnerLoot = {
		[1] = {{ item = alienOre,  count_min = 2*kf,  count_max = 3*kf,  probability = 1}},
		[2] = {{ item = alienOre,  count_min = 3*kf,  count_max = 4*kf,  probability = 1}},
		[3] = {{ item = alienOre,  count_min = 4*kf,  count_max = 5*kf,  probability = 1}},
		[4] = {{ item = alienOre,  count_min = 5*kf,  count_max = 6*kf,  probability = 1}},
		[5] = {{ item = alienOre,  count_min = 6*kf,  count_max = 7*kf,  probability = 1}},
		[6] = {{ item = alienOre,  count_min = 7*kf,  count_max = 8*kf,  probability = 1}},
		[7] = {{ item = alienOre,  count_min = 8*kf,  count_max = 9*kf,  probability = 1}},
		[8] = {{ item = alienOre,  count_min = 9*kf,  count_max = 10*kf,  probability = 1}},
		[9] = {{ item = alienOre,  count_min = 10*kf,  count_max = 12*kf,  probability = 1}},
		[10] ={{ item = alienOre,  count_min = 12*kf,  count_max = 15*kf,  probability = 1}},
	}
	return lootTables	
end
-------
function biterFunctions.findRange(entity)
    return entity.attack_parameters.range
end

local function findKey(key, obj)
    for k,v in pairs(obj) do
        if (k == key) and v then
            return v
        elseif (type(v) == "table") then
            local val = findKey(key, v)
            if val then
                return val
            end
        end
    end
end

function biterFunctions.findRunScale(entity)
    return findKey("scale", entity.run_animation.layers)
end

function biterFunctions.findTint(entity)
    return findKey("tint", entity.run_animation.layers)
end

function biterFunctions.createElectricAttack(attributes, electricBeam, animation)
    return
        {
            type = "beam",
            ammo_category = "biological",
            range_mode = "bounding-box-to-bounding-box",
            cooldown = attributes.cooldown or 20,
            warmup = attributes.warmup,
            min_attack_distance = (attributes.range and (attributes.range - 2)) or 15,
            range = (attributes.range and (attributes.range + 2)) or 15,
            ammo_type =
                {
                    category = "biological",
                    action =
                        {
                            type = "line",
                            range = (attributes.range and (attributes.range + 2)) or 15,
                            width = attributes.width or 0.5,
                            force = "not-same",
                            action_delivery = (attributes.actions and attributes.actions(attributes, electricBeam)) or
                                {
                                    type = "beam",
                                    beam = electricBeam or "electric-beam",
                                    duration = attributes.duration or 20
                                }
                        }
                },
            animation = animation
        }
end

function biterFunctions.createProjectileAttack(attributes, projectile, animation)
	local speed_modifier = 1
	if attributes.clusterAttack then
		speed_modifier = 0.8
	end
	local rangeModifier = (attributes.attackModifiers and attributes.attackModifiers.range) or 0
 	local damageModifier = (attributes.attackModifiers and attributes.attackModifiers.damage) or 1
    return {
        type = "projectile",
        ammo_category = "biological",
        range_mode = "bounding-box-to-bounding-box",
        cooldown = attributes.cooldown or 15,
        warmup = attributes.warmup,
        cooldown_deviation = 0.15,
        projectile_creation_distance = 0.6,
        range = rangeModifier + (attributes.range or 20),
        min_attack_distance = rangeModifier + ((attributes.range and (attributes.range - 2)) or 20),
        lead_target_for_projectile_speed = 0.95,	
        use_shooter_direction = true,
        ammo_type =
            {
                category = "biological",
                clamp_position = true,
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "projectile",
                                projectile = projectile or "defender-bullet",
                                starting_speed = (attributes.startingSpeed or 0.6)*speed_modifier,	
                                max_range = rangeModifier + (attributes.maxRange or (attributes.range + 1) or 20)
                            }
                    }
            },
        animation = animation
    }
end

-- + !КДА 2021.11
function biterFunctions.createSpawnAttack(attributes, projectile, animation)
    return {
        type = "projectile",
        ammo_category = "biological",
        range_mode = "bounding-box-to-bounding-box",
        cooldown = attributes.cooldown or 15,
        warmup = attributes.warmup,
        cooldown_deviation = 0.15,
        projectile_creation_distance = 0.6,
        range = attributes.range or 20,
        min_attack_distance = (attributes.range and (attributes.range - 2)) or 20,
        lead_target_for_projectile_speed = 0.95,	
        use_shooter_direction = true,
        ammo_type =
            {
                category = "biological",
                clamp_position = true,
                target_type = "position",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "projectile",
                                projectile = projectile,
                                starting_speed = attributes.startingSpeed or 0.6,	
                                max_range = attributes.maxRange or (attributes.range + 1) or 20
                            }
                    }
            },
        animation = animation
    }

end
-- - !КДА

function biterFunctions.createMeleeAttack(attackAttributes)
    local meleeAttackEffects = {
        type = "damage",
        damage = { amount = attackAttributes.damage * 0.25, type = attackAttributes.damageType or "physical" }
    }

    if attackAttributes.meleePuddleGenerator then
        local o = {}
        o[1] = meleeAttackEffects
        o[2] = attackAttributes.meleePuddleGenerator(attackAttributes)
        meleeAttackEffects = o
    end
    return {
        type = "projectile",
        range = attackAttributes.range or 0.5,
        cooldown = attackAttributes.cooldown or 35,
        cooldown_deviation = 0.15,
        range_mode = "bounding-box-to-bounding-box",
        ammo_category = "melee",
        ammo_type = {
            category = "melee",
            target_type = "entity",
            action =
                {
                    {
                        type = "area",
                        radius = attackAttributes.radius,
                        force = "not-same",
                        ignore_collision_condition = true,
                        action_delivery =
                            {
                                type = "instant",
								source_effects = attackAttributes.sourceEffect and attackAttributes.sourceEffect(attackAttributes),
                                target_effects =
                                    {
                                        type = "damage",
                                        damage = { amount = attackAttributes.damage * 0.75, type = attackAttributes.damageType or "physical" }
                                    }
                            }
                    },
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "instant",
                                target_effects = meleeAttackEffects
                            }
                    }
                }
        },
        sound = sounds.biter_roars(0.2 + (attackAttributes.effectiveLevel * 0.05)),
        animation = biterattackanimation(attackAttributes.scale, attackAttributes.tint, attackAttributes.tint2 or attackAttributes.tint, attackAttributes.altBiter)
    }
end

function biterFunctions.biterAttackSounds(effectiveLevel)
    return {
        {
            filename = "__base__/sound/creatures/Spiters_1_1.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_1_2.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_2_1.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_2_2.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_3_1.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_3_2.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_4_1.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_4_2.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_5_1.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        },
        {
            filename = "__base__/sound/creatures/Spiters_5_2.ogg",
            volume = 0.2 + (effectiveLevel * 0.05)
        }
    }
end

function biterFunctions.createRangedAttack(attributes, attack, animation)
    if (attributes.attackType == "stream") then
        return biterFunctions.createStreamAttack(attributes, attack, animation)
    elseif (attributes.attackType == "projectile") then
		return biterFunctions.createProjectileAttack(attributes, attack, animation)
    else
        error("Unknown range attack")
    end
end

function biterFunctions.createStreamAttack(attributes, fireAttack, animation)
    local attack = {
        type = "stream",
        ammo_category = "biological",
        cooldown = attributes.cooldown,
        range = attributes.range,
        min_range = attributes.minRange,
        cooldown_deviation = 0.15,

        turn_range = attributes.turnRange,
        fire_penalty = attributes.firePenalty,

        warmup = attributes.warmup or 0,

        damage_modifier = attributes.damageModifier or 1.0,
        range_mode = "bounding-box-to-bounding-box",
        lead_target_for_projectile_speed = attributes.particleHoizontalSpeed or 0.6,

        projectile_creation_parameters = spitter_shoot_shiftings(attributes.scale, attributes.scale * 20),

        use_shooter_direction = true,

        gun_barrel_length = 2 * attributes.scale,
        gun_center_shift = {
            north = {0, -0.65 * attributes.scale},
            east = {0, 0},
            south = {0, 0},
            west = {0, 0}
        },
        ammo_type =
            {
                category = "biological",
                action =
                    {
                        type = "direct",
                        action_delivery =
                            {
                                type = "stream",
                                stream = fireAttack,
                                duration = 160,
                            }
                    }
            },

        cyclic_sound =
            {
                begin_sound = biterFunctions.biterAttackSounds(attributes.effectiveLevel),
                middle_sound =
                    {
                        {
                            filename = attributes.midSound or "__RampantFixed__/sounds/attacks/acid-mid.ogg",
                            volume = 0.2 + (attributes.effectiveLevel * 0.05)
                        }
                    },
                end_sound =
                    {
                        {
                            filename = attributes.endSound or "__RampantFixed__/sounds/attacks/acid-end.ogg",
                            volume = 0.2 + (attributes.effectiveLevel * 0.05)
                        }
                    }
            },
        animation = animation
    }

    return attack
end

function biterFunctions.makeResistance(name, decrease, percentage)
    local obj = {
        type = name,
    }
    if (decrease ~= 0) then
        obj.decrease = decrease
    end
    if (percentage ~= 0) then
        obj.percentage = percentage
    end
    return obj
end

return biterFunctions
