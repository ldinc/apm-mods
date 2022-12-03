local vanillaUpdates = require("prototypes/utils/UpdatesVanilla")

local attackBall = require("prototypes/utils/AttackBall")
local constants = require("libs/Constants")

if settings.startup["rampantFixed--useDumbProjectiles"].value or settings.startup["rampantFixed--newEnemies"].value then
    attackBall.generateVanilla()
    vanillaUpdates.useDumbProjectiles()
end

for _, robot in pairs(data.raw["logistic-robot"]) do
    -- if not robot.collision_mask then
    --     robot.collision_mask = {}
    -- end
    -- robot.collision_mask[#robot.collision_mask+1] = "layer-13"

    if (settings.startup["rampantFixed--unkillableLogisticRobots"].value) then
        robot.resistances = {}
        for damageType, _ in pairs(data.raw["damage-type"]) do
            robot.resistances[damageType] = {
                type = damageType,
                percent = 100
            }
        end
    end
end

for _, robot in pairs(data.raw["construction-robot"]) do
    -- if not robot.collision_mask then
    --     robot.collision_mask = {}
    -- end
    -- robot.collision_mask[#robot.collision_mask+1] = "layer-13"

    if (settings.startup["rampantFixed--unkillableConstructionRobots"].value) then
        robot.resistances = {}
        for damageType, _ in pairs(data.raw["damage-type"]) do
            robot.resistances[damageType] = {
                type = damageType,
                percent = 100
            }
        end
    end
end

if settings.startup["rampantFixed--useDumbProjectiles"].value or settings.startup["rampantFixed--newEnemies"].value then
    attackBall.generateVanilla()
    vanillaUpdates.useDumbProjectiles()
end


-- for _, robot in pairs(data.raw["combat-robot"]) do
--     if not robot.collision_mask then
--         robot.collision_mask = {}
--     end
--     robot.collision_mask[#robot.collision_mask+1] = "layer-13"
-- end

--[[
    try to make sure new maps use the correct map settings without having to completely load the mod.
    done because seeing desync issues with dynamic map-settings changes before re-saving the map.
--]]
local mapSettings = data.raw["map-settings"]["map-settings"]

mapSettings.max_failed_behavior_count = 3 -- constants.MAX_FAILED_BEHAVIORS

mapSettings.unit_group.member_disown_distance = constants.UNIT_GROUP_DISOWN_DISTANCE
mapSettings.unit_group.tick_tolerance_when_member_arrives = constants.UNIT_GROUP_TICK_TOLERANCE

mapSettings.unit_group.max_group_radius = constants.UNIT_GROUP_MAX_RADIUS
mapSettings.unit_group.max_member_speedup_when_behind = constants.UNIT_GROUP_MAX_SPEED_UP
mapSettings.unit_group.max_member_slowdown_when_ahead = constants.UNIT_GROUP_MAX_SLOWDOWN
mapSettings.unit_group.max_group_slowdown_factor = constants.UNIT_GROUP_SLOWDOWN_FACTOR


-- data.raw["utility-constants"]["default"].unit_group_pathfinding_resolution = -5
