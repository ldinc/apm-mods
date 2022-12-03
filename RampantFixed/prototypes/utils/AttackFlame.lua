local attackFlame = {}

-- imported

local streamUtils = require("StreamUtils")
local fireUtils = require("FireUtils")
local stickerUtils = require("StickerUtils")

-- constants

-- imported functions

local makeStream = streamUtils.makeStream
local makeFire = fireUtils.makeFire
local makeSticker = stickerUtils.makeSticker
local makeSpreadEffect = fireUtils.makeSpreadEffect
local makeSpreadOnceEffect = fireUtils.makeSpreadOnceEffect

-- module code

function attackFlame.createAttackFlame(attributes)

    local spawnEntityName = makeSpreadOnceEffect({		--makeSpreadEffect({
            name = attributes.name,
            tint2 = attributes.tint2,
            fireDamagePerTick = attributes.fireDamagePerTick,
            fireDamagePerTickType = attributes.fireDamagePerTickType,
    })
    local fireName = makeFire({
            name = attributes.name,
            tint2 = attributes.tint2 or {r=0, g=0.9, b=0, a=0.5},
            spawnEntityName = spawnEntityName,
            fireDamagePerTick = attributes.fireDamagePerTick,
            fireDamagePerTickType = attributes.fireDamagePerTickType,
            damageMaxMultipler = attributes.damageMaxMultipler,
            multiplerIncrease = attributes.multiplerIncrease,
            multiplerDecrease = attributes.multiplerDecrease
    })
    local stickerName = makeSticker({
            name = attributes.name,
            --spawnEntityName = spawnEntityName,
            stickerDuration = attributes.stickerDuration,
            stickerDamagePerTick = attributes.stickerDamagePerTick,
            stickerDamagePerTickType = attributes.stickerDamagePerTickType,
            stickerMovementModifier = attributes.stickerMovementModifier,
            tint2 = attributes.tint2,
            fireSpreadRadius = attributes.fireSpreadRadius
    })

    return makeStream({
            name = attributes.name,
            tint2 = attributes.tint2 or {r=0, g=1, b=1, a=0.5},
            particleTimeout = attributes.particleTimeout,
            scale = attributes.scale,
            actions = {
                {
                    type = "area",
                    radius = attributes.radius or 2.5,
                    force = "not-same",
                    action_delivery =
                        {
                            type = "instant",
                            target_effects =
                                {
                                    {
                                        type = "create-sticker",
                                        sticker = stickerName,
                                        check_buildability = true
                                    },
                                    {
                                        type = "create-entity",
                                        entity_name = "water-splash",
                                        tile_collision_mask = { "ground-tile" }
                                    },
                                    {
                                        type = "damage",
                                        damage = { amount = attributes.damage, type = attributes.damageType or "fire" }
                                    }
                                }
                        }
                },
                {
                    type = "direct",
                    action_delivery = {
                        type = "instant",
                        target_effects = {
                            type= "create-fire",
                            entity_name = fireName,
                            check_buildability = true
                        }
                    }
                }
            }
    })
end

return attackFlame
