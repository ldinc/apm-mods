local smokeUtils = require("prototypes/utils/SmokeUtils")

local chunkScannerCorpse = util.table.deepcopy(data.raw["corpse"]["small-biter-corpse"])
chunkScannerCorpse.name = "chunk-scanner-corpse"
chunkScannerCorpse.time_before_removed = 1
data:extend({chunkScannerCorpse})

local chunkScannerSquad = util.table.deepcopy(data.raw["unit"]["small-biter"])
chunkScannerSquad.name = "chunk-scanner-squad-rampant"
chunkScannerSquad.health = 1
chunkScannerSquad.collision_box = {{-6, -6}, {6, 6}}
chunkScannerSquad.healing_per_tick = -1
chunkScannerSquad.corpse = "chunk-scanner-corpse"
data:extend({chunkScannerSquad})

local chunkScannerSquadMovement = util.table.deepcopy(data.raw["unit"]["small-biter"])
chunkScannerSquadMovement.name = "chunk-scanner-squad-movement-rampant"
chunkScannerSquadMovement.health = 1
chunkScannerSquadMovement.collision_box = {{-1, -1}, {1, 1}}
chunkScannerSquadMovement.healing_per_tick = -1
chunkScannerSquadMovement.corpse = "chunk-scanner-corpse"
data:extend({chunkScannerSquadMovement})



smokeUtils.makeNewCloud(
    {
        name = "build-clear",
        wind = false,
        scale = 9,
        duration = 540,
        cooldown = 10,
        tint = { r=0.7, g=0.2, b=0.7 }
    },
    {
        type = "area",
        radius = 17,
        force = "not-same",
        action_delivery =
            {
                type = "instant",
                target_effects =
                    {
                        {
                            type = "damage",
                            damage = { amount = 1.1, type = "poison"}
                        },
                        {
                            type = "damage",
                            damage = { amount = 1.1, type = "acid"}
                        },
                        {
                            type = "damage",
                            damage = { amount = 1.1, type = "fire"}
                        }
                    }
            }
    }
)