local vanillaBuildings = require("prototypes/buildings/UpdatesVanilla")
local immunityUpdates = require("prototypes/utils/UpdateImmunities")	

-- if settings.startup["rampantFixed--removeBloodParticles"].value then
    -- local explosions = data.raw["explosion"]

    -- for k,v in pairs(explosions) do
        -- if string.find(k, "blood") then
            -- v["created_effect"] = nil
        -- end
    -- end
-- end

if settings.startup["rampantFixed--newEnemies"].value then
	if data.raw["damage-type"]["plasma"] then
		immunityUpdates.setPlasmaImmunities()
	end	
	if data.raw["damage-type"]["bob-pierce"] then
		immunityUpdates.setPierceImmunities()
	end	
	immunityUpdates.setArmorLaserElectricImmunities()
	immunityUpdates.setResistanceToUnknownDamageTypes()	
end

if settings.startup["rampantFixed--fireSafety-flamethrower"].value then
    local flamethrowerStream = data.raw["stream"]["handheld-flamethrower-fire-stream"]
	flamethrowerStream.action[1].action_delivery.target_effects[1].sticker = "safe-fire-sticker-rampant"
	if flamethrowerStream.action[2] then
		flamethrowerStream.action[2].action_delivery.target_effects[1].entity_name = "safe-fire-flame-rampant"
	end	
	
end

if settings.startup["rampantFixed--unitSpawnerBreath"].value then
    for _, unitSpawner in pairs(data.raw["unit-spawner"]) do
        if (string.find(unitSpawner.name, "hive") or string.find(unitSpawner.name, "biter") or
            string.find(unitSpawner.name, "spitter")) then
            if not unitSpawner.flags then
                unitSpawner.flags = {}
            end
            unitSpawner.flags[#unitSpawner.flags+1] = "breaths-air"
        end
    end
end


for k, unit in pairs(data.raw["unit"]) do
    if (string.find(k, "biter") or string.find(k, "spitter")) and unit.collision_box then
        if settings.startup["rampantFixed--enableSwarm"].value then
            unit.collision_box = {
                {unit.collision_box[1][1] * 0.20, unit.collision_box[1][2] * 0.20},
                {unit.collision_box[2][1] * 0.20, unit.collision_box[2][2] * 0.20}
            }
        end

		-- if string.find(k, "-rampant") and (string.find(k, "nuclear-biter") or string.find(k, "suicide-biter") or string.find(k, "fast-biter")) then
			-- unit.affected_by_tiles = false
		-- else	
			-- unit.affected_by_tiles = settings.startup["rampantFixed--unitsAffectedByTiles"].value
		-- end	

        unit.ai_settings = {
            destroy_when_commands_fail = false,
            allow_try_return_to_spawner = true
        }
    end
end

if settings.startup["rampantFixed--enableShrinkNestsAndWorms"].value then
    for k, unit in pairs(data.raw["unit-spawner"]) do
        if (string.find(k, "biter") or string.find(k, "spitter") or string.find(k, "hive")) and unit.collision_box then
            unit.collision_box = {
                {unit.collision_box[1][1] * 0.50, unit.collision_box[1][2] * 0.50},
                {unit.collision_box[2][1] * 0.50, unit.collision_box[2][2] * 0.50}
            }
        end
    end

    for k, unit in pairs(data.raw["turret"]) do
        if string.find(k, "worm") and unit.collision_box then
            unit.collision_box = {
                {unit.collision_box[1][1] * 0.70, unit.collision_box[1][2] * 0.70},
                {unit.collision_box[2][1] * 0.70, unit.collision_box[2][2] * 0.70}
            }
        end
    end
end

if settings.startup["rampantFixed--enableFadeTime"].value then
    for k, corpse in pairs(data.raw["corpse"]) do
        if (string.find(k, "biter") or string.find(k, "spitter") or string.find(k, "hive") or
            string.find(k, "worm") or string.find(k, "spawner")) then
			if string.sub(k, 1, 13) == "spawner-spawn" then 
				corpse.time_before_removed = 60
			else
				corpse.time_before_removed = settings.startup["rampantFixed--unitAndSpawnerFadeTime"].value * 60
			end
		end	
    end
end

if settings.startup["rampantFixed--addWallResistanceAcid"].value then
    vanillaBuildings.addWallResistance()
end
