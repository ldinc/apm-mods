-- Copyright (C) 2022  Dimm2101

-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.


-- imports

local chunkPropertyUtils = require("libs/ChunkPropertyUtils")
local unitUtils = require("libs/UnitUtils")
local baseUtils = require("libs/BaseUtils")
local mapUtils = require("libs/MapUtils")
local mathUtils = require("libs/MathUtils")
local unitGroupUtils = require("libs/UnitGroupUtils")
local chunkProcessor = require("libs/ChunkProcessor")
local mapProcessor = require("libs/MapProcessor")
local constants = require("libs/Constants")
local pheromoneUtils = require("libs/PheromoneUtils")
local squadDefense = require("libs/SquadDefense")
local squadAttack = require("libs/SquadAttack")
local squadCompression = require("libs/SquadCompression")

local aiAttackWave = require("libs/AIAttackWave")
local aiPlanning = require("libs/AIPlanning")
-- local interop = require("libs/Interop")
local chunkUtils = require("libs/ChunkUtils")
local upgrade = require("Upgrade")
local config = require("config")
local aiPredicates = require("libs/AIPredicates")
local stringUtils = require("libs/StringUtils")

-- constants
local BASE_CHANGING_CHANCE = constants.BASE_CHANGING_CHANCE

local AI_SETTLER_COST = constants.AI_SETTLER_COST

local RECOVER_NEST_COST = constants.RECOVER_NEST_COST
local RECOVER_WORM_COST = constants.RECOVER_WORM_COST

local RETREAT_GRAB_RADIUS = constants.RETREAT_GRAB_RADIUS

local RETREAT_SPAWNER_GRAB_RADIUS = constants.RETREAT_SPAWNER_GRAB_RADIUS

local PROCESS_QUEUE_SIZE = constants.PROCESS_QUEUE_SIZE

local DEFINES_WIRE_TYPE_RED = defines.wire_type.red
local DEFINES_WIRE_TYPE_GREEN = defines.wire_type.green

local ENERGY_THIEF_CONVERSION_TABLE = constants.ENERGY_THIEF_CONVERSION_TABLE
local ENERGY_THIEF_LOOKUP = constants.ENERGY_THIEF_LOOKUP

local SURFACE_IGNORED = constants.SURFACE_IGNORED
local OVERDAMAGEPROTECTION_THRESHOLD = constants.OVERDAMAGEPROTECTION_THRESHOLD 

-- imported functions

local isRampantSetting = stringUtils.isRampantSetting

local canMigrate = aiPredicates.canMigrate

local convertTypeToDrainCrystal = unitUtils.convertTypeToDrainCrystal

local squadDispatch = squadAttack.squadDispatch
local processDecompressQueue = squadCompression.processDecompressQueue
local processNonRampantSquads = squadCompression.processNonRampantSquads
local removeOneTickImmunity = squadCompression.removeOneTickImmunity
local onUnitPreKilled = squadCompression.onUnitPreKilled

local cleanUpMapTables = mapProcessor.cleanUpMapTables

local positionToChunkXY = mapUtils.positionToChunkXY

local processMapAIs = aiPlanning.processMapAIs


local processVengence = mapProcessor.processVengence
local processSpawners = mapProcessor.processSpawners

local processStaticMap = mapProcessor.processStaticMap

local disperseVictoryScent = pheromoneUtils.disperseVictoryScent

local getChunkByPosition = mapUtils.getChunkByPosition

local entityForPassScan = chunkUtils.entityForPassScan

local processPendingChunks = chunkProcessor.processPendingChunks
local processScanChunks = chunkProcessor.processScanChunks
local processPendingMutations = chunkProcessor.processPendingMutations

local processMap = mapProcessor.processMap
local processPlayers = mapProcessor.processPlayers
local scanEnemyMap = mapProcessor.scanEnemyMap
local scanPlayerMap = mapProcessor.scanPlayerMap
local scanResourceMap = mapProcessor.scanResourceMap
local suspendClearedMaps = mapProcessor.suspendClearedMaps

local processNests = mapProcessor.processNests

local rallyUnits = aiAttackWave.rallyUnits

local recycleBases = baseUtils.recycleBases

local deathScent = pheromoneUtils.deathScent
local victoryScent = pheromoneUtils.victoryScent

local createSquad = unitGroupUtils.createSquad

local createBase = baseUtils.createBase
local findNearbyBase = baseUtils.findNearbyBase

local processActiveNests = mapProcessor.processActiveNests

local getDeathGenerator = chunkPropertyUtils.getDeathGenerator

local retreatUnits = squadDefense.retreatUnits

local accountPlayerEntity = chunkUtils.accountPlayerEntity
local unregisterEnemyBaseStructure = chunkUtils.unregisterEnemyBaseStructure
local registerEnemyBaseStructure = chunkUtils.registerEnemyBaseStructure
local makeImmortalEntity = chunkUtils.makeImmortalEntity

local registerResource = chunkUtils.registerResource
local unregisterResource = chunkUtils.unregisterResource

local cleanSquads = squadAttack.cleanSquads

local processCompression = squadCompression.processCompression

local upgradeEntity = baseUtils.upgradeEntity
local rebuildNativeTables = baseUtils.rebuildNativeTables

local mRandom = math.random

local tRemove = table.remove

local sFind = string.find
local sSub = string.sub
local ShowNewBaseAligments = baseUtils.ShowNewBaseAligments
local thisIsNewEnemyPosition = chunkPropertyUtils.thisIsNewEnemyPosition

-- local references to global

local universe -- manages the chunks that make up the game universe

-- hook functions

local function onIonCannonFired(event)
    --[[
        event.force, event.surface, event.player_index, event.position, event.radius
    --]]
    local map = universe.maps[event.surface.index]
	if not map then
		return
	end	
	universe.retribution = universe.retribution + 1
	map.vengenceLimiter = 0
    map.ionCannonBlasts = map.ionCannonBlasts + 1
    map.points = map.points + 4000
    if universe.aiPointsPrintGainsToChat then
        game.print(map.surface.name .. ": Points: +" .. 4000 .. ". [Ion Cannon] Total: " .. string.format("%.2f", map.points))
    end

    local chunk = getChunkByPosition(map, event.position)
    if (chunk ~= -1) then
        rallyUnits(chunk, map, event.tick)
    end
end


local function hookEvents()
    if settings.startup["ion-cannon-radius"] ~= nil then
        script.on_event(remote.call("orbital_ion_cannon", "on_ion_cannon_fired"),
                        onIonCannonFired)
    end
end


local function onLoad()
    universe = global.universe	
    hookEvents()
end

local function onChunkGenerated(event)
    -- queue generated chunk for delayed processing, queuing is required because
    -- some mods (RSO) mess with chunk as they are generated, which messes up the
    -- scoring.
    universe.pendingChunks[event] = true
end

local function replaceNewEnemiesNests()
	local totalReplaced = 0
	for _,surface in pairs(game.surfaces) do
		local buildings = surface.find_entities_filtered({force = "enemy", type={"turret", "unit-spawner"}})
		local buildingsTotal = #buildings
		for i=1,buildingsTotal do
			local building = buildings[i]
			local entityName
			local entityPosition = {x = 0, y = 0}
			
			if building.type == "turret" then
				local wormTier = 0
				wormTier = universe.buildingTierLookup[building.name]
				if wormTier then
					if wormTier < 3 then
						entityName = "small-worm-turret"
					elseif wormTier < 6 then	
						entityName = "medium-worm-turret"
					elseif wormTier < 9 then
						entityName = "big-worm-turret"
					else
						entityName = "behemoth-worm-turret"
					end
				end	
			elseif building.type == "unit-spawner" then	
				local faction = universe.enemyAlignmentLookup[building.name]
				local hiveType = universe.buildingHiveTypeLookup[building.name]
				if faction then
					if hiveType == "spitter-spawner" then
						entityName = "spitter-spawner"
					else
						entityName = "biter-spawner"
					end
				end
			end	
			if entityName then
				entityPosition.x = building.position.x
				entityPosition.y = building.position.y
				building.destroy()
				surface.create_entity({name = entityName, position = entityPosition, force = "enemy"}) 
				totalReplaced = totalReplaced + 1
			end	
		end	

		if universe.bases then
		    for i, base in pairs(universe.bases) do
				base.thisIsRampantEnemy = false
			end			
		end
	end	
	game.print({"description.rampantFixed--msg_replaceNewEnemiesNests", totalReplaced})
	universe.NEW_ENEMIES = false
end

local function on_gui_click(event)
	local guiElement = event.element
	if guiElement.name == "rampantFixed--button_disableNewEnemies_disable" then
		replaceNewEnemiesNests()
		guiElement.parent.destroy()
		 
		local player_settings = settings.get_player_settings(game.players[event.player_index])
		player_settings["rampantFixed--showDisableNewEnemiesButton"] = {value = false}
	elseif guiElement.name == "rampantFixed--button_disableNewEnemies_cancel" then
		guiElement.parent.destroy()
		local player_settings = settings.get_player_settings(game.players[event.player_index])
		player_settings["rampantFixed--showDisableNewEnemiesButton"] = {value = false}
	end
end

local function create_disableNewEnemies_frame(player)
	local gui = player.gui.screen

	for i, children in pairs(gui.children) do
		if children.name ==  "rampantFixed--disableNewEnemies_frame" then
			children.destroy()
			break
		end
	end
	
	local frame = gui.add{name = "rampantFixed--disableNewEnemies_frame", type = "frame", style = "non_draggable_frame", direction = "horizontal", caption={"description.rampantFixed--msg-ask-disableNewEnemies"}}
	frame.add{type = "button", name = "rampantFixed--button_disableNewEnemies_disable", caption = {"description.rampantFixed--button_disableNewEnemies_disable"}}
	frame.add{type = "button", name = "rampantFixed--button_disableNewEnemies_cancel", caption = {"description.rampantFixed--button_disableNewEnemies_cancel"}}
end

local function onModSettingsChange(event)

    if not isRampantSetting(event.setting) then
        return
    end

    --game.print("onModSettingsChange() processing for Rampant")

    upgrade.compareTable(universe,
                         "safeBuildings",
                         settings.global["rampantFixed--safeBuildings"].value)
    upgrade.compareTable(universe.safeEntities,
                         "curved-rail",
                         settings.global["rampantFixed--safeBuildings-curvedRail"].value)
    upgrade.compareTable(universe.safeEntities,
                         "straight-rail",
                         settings.global["rampantFixed--safeBuildings-straightRail"].value)
    upgrade.compareTable(universe.safeEntities,
                         "rail-signal",
                         settings.global["rampantFixed--safeBuildings-railSignals"].value)
    upgrade.compareTable(universe.safeEntities,
                         "rail-chain-signal",
                         settings.global["rampantFixed--safeBuildings-railChainSignals"].value)
    upgrade.compareTable(universe.safeEntities,
                         "train-stop",
                         settings.global["rampantFixed--safeBuildings-trainStops"].value)
    upgrade.compareTable(universe.safeEntities,
                         "lamp",
                         settings.global["rampantFixed--safeBuildings-lamps"].value)

    local changed, newValue = upgrade.compareTable(universe.safeEntities,
                                                   "big-electric-pole",
                                                   settings.global["rampantFixed--safeBuildings-bigElectricPole"].value)
    if changed then
        universe.safeEntities["big-electric-pole"] = newValue
        universe.safeEntities["big-electric-pole-2"] = newValue
        universe.safeEntities["big-electric-pole-3"] = newValue
        universe.safeEntities["big-electric-pole-4"] = newValue
        universe.safeEntities["lighted-big-electric-pole-4"] = newValue
        universe.safeEntities["lighted-big-electric-pole-3"] = newValue
        universe.safeEntities["lighted-big-electric-pole-2"] = newValue
        universe.safeEntities["lighted-big-electric-pole"] = newValue
    end

    upgrade.compareTable(universe,
                         "aiDifficulty",
                         settings.global["rampantFixed--aiDifficulty"].value)
    upgrade.compareTable(universe,
                         "raidAIToggle",
                         settings.global["rampantFixed--raidAIToggle"].value)
    upgrade.compareTable(universe,
                         "siegeAIToggle",
                         settings.global["rampantFixed--siegeAIToggle"].value)

    upgrade.compareTable(universe,
                         "attackPlayerThreshold",
                         settings.global["rampantFixed--attackPlayerThreshold"].value)
    upgrade.compareTable(universe,
                         "attackUsePlayer",
                         settings.global["rampantFixed--attackWaveGenerationUsePlayerProximity"].value)

    upgrade.compareTable(universe,
                         "attackWaveMaxSize",
                         settings.global["rampantFixed--attackWaveMaxSize"].value)
    upgrade.compareTable(universe,
                         "attackWaveMaxSizeEvoPercent",
                         settings.global["rampantFixed--attackWaveMaxSizeEvoPercent"].value)
    upgrade.compareTable(universe,
                         "aiNocturnalMode",
                         settings.global["rampantFixed--permanentNocturnal"].value)
    upgrade.compareTable(universe,
                         "aiPointsScaler",
                         settings.global["rampantFixed--aiPointsScaler"].value)

    universe.aiPointsPrintGainsToChat = settings.global["rampantFixed--aiPointsPrintGainsToChat"].value
    universe.aiPointsPrintSpendingToChat = settings.global["rampantFixed--aiPointsPrintSpendingToChat"].value

    universe.enabledMigration = universe.expansion and settings.global["rampantFixed--enableMigration"].value
    universe.peacefulAIToggle = settings.global["rampantFixed--peacefulAIToggle"].value
    universe.printAIStateChanges = settings.global["rampantFixed--printAIStateChanges"].value
    universe.debugTemperament = settings.global["rampantFixed--debugTemperament"].value

    upgrade.compareTable(universe,
                         "AI_MAX_SQUAD_COUNT",
                         settings.global["rampantFixed--maxNumberOfSquads"].value)
    upgrade.compareTable(universe,
                         "AI_MAX_BUILDER_COUNT",
                         settings.global["rampantFixed--maxNumberOfBuilders"].value)

	if universe.NEW_ENEMIES then
		for playerIndex, player in pairs(game.players) do
			local player_settings = settings.get_player_settings(player)
			if player.admin then
				if player_settings["rampantFixed--showDisableNewEnemiesButton"].value then
					create_disableNewEnemies_frame(player)
				end	
			end
		end
	end
    return true
end

local function prepMap(surface)

    local surfaceIndex = surface.index

    if not universe.maps then
        universe.maps = {}
    end
	
	if SURFACE_IGNORED(surface, universe) then
		return	
	end
	
    surface.print("Rampant, fixed - Indexing surface:" .. tostring(surface.index) .. ", please wait.")

    local map = universe.maps[surfaceIndex]
    if not map then
        map = {}
        universe.maps[surfaceIndex] = map
    end

    map.processedChunks = 0
    map.processQueue = {}
    map.processIndex = 1
    map.cleanupIndex = 1
    map.scanPlayerIndex = 1
    map.scanResourceIndex = 1
    map.scanEnemyIndex = 1
    map.processStaticIndex = 1
    map.outgoingScanWave = true
    map.outgoingStaticScanWave = true

	map.chunkToPlayerTurrets = {}
    map.chunkToBase = {}
    map.chunkToNests = {}
    map.chunkToTurrets = {}
    map.chunkToTraps = {}
    map.chunkToUtilities = {}
    map.chunkToHives = {}
    map.chunkToPlayerBase = {}
    map.chunkToPlayerBaseDetection = {}
    map.chunkToResource = {}

    map.chunkToSquad = {}

    map.chunkToRetreats = {}
    map.chunkToRallys = {}

    map.chunkToPassable = {}
    map.chunkToPathRating = {}
    map.chunkToDeathGenerator = {}
    map.chunkToDrained = {}
    map.chunkToVictory = {}
    map.chunkToActiveNest = {}
    map.chunkToActiveRaidNest = {}

    map.nextChunkSort = 0
    map.nextChunkSortTick = 0

    map.deployVengenceIterator = nil
    map.recycleBaseIterator = nil
    map.processActiveSpawnerIterator = nil
    map.processActiveRaidSpawnerIterator = nil
    map.processMigrationIterator = nil
    map.processNestIterator = nil
    map.victoryScentIterator = nil

    map.chunkScanCounts = {}
    map.chunkFactionCounts = {}

    map.enemiesToSquad = {}
    map.enemiesToSquad.len = 0
    map.chunkRemovals = {}
    map.processActiveNest = {}
    map.tickActiveNest = {}

    map.emptySquadsOnChunk = {}

    map.surface = surface
    map.universe = universe

    map.vengenceQueue = {}
    map.points = 0
    map.state = constants.AI_STATE_AGGRESSIVE
    map.baseId = 0
    map.squads = nil
    map.pendingAttack = nil
    map.building = nil

    map.evolutionLevel = game.forces.enemy.evolution_factor
    map.canAttackTick = 0
    map.drainPylons = {}
    map.groupNumberToSquad = {}
    map.activeRaidNests = 0
    map.activeNests = 0
    map.destroyPlayerBuildings = 0
    map.lostEnemyUnits = 0
    map.lostEnemyBuilding = 0
    map.rocketLaunched = 0
    map.builtEnemyBuilding = 0
    map.ionCannonBlasts = 0
    map.artilleryBlasts = 0

	map.vengenceLimiter = 0
	map.squadsGenerated = 0	-- (every 20 active Nests chunks = 1 max squad in agressive mode), aiAttackWave.formSquads
    map.temperament = 0.5
    map.temperamentScore = 0
    map.stateTick = 0

	map.nextPlayerScan = 0
	
    -- queue all current chunks that wont be generated during play
    local tick = game.tick
    local position = {0,0}
    map.nextChunkSort = 0
    for chunk in surface.get_chunks() do
        local x = chunk.x
        local y = chunk.y
        position[1] = x
        position[2] = y
        if surface.is_chunk_generated(position) then
            onChunkGenerated({ surface = surface,
                               area = { left_top = { x = x * 32,
                                                     y = y * 32}}})
        end
    end

    processPendingChunks(universe, tick, true)
end

local function setNewEnemySide()
	universe["ALLOW_OTHER_ENEMIES"] = settings.startup["rampantFixed--allowOtherEnemies"].value
	universe["NEW_ENEMIES_SIDE"] = settings.startup["rampantFixed--newEnemiesSide"].value
end

local function onConfigChanged()
    local version = upgrade.attempt(universe)
    if version then
        if not universe then
            universe = global.universe
        end
    end

    onModSettingsChange({setting="rampantFixed--"})

    upgrade.compareTable(universe,
                         "ENEMY_SEED",
                         settings.startup["rampantFixed--enemySeed"].value)
    upgrade.compareTable(universe,
                         "ENEMY_VARIATIONS",
                         settings.startup["rampantFixed--newEnemyVariations"].value)
    upgrade.compareTable(universe,
                         "NEW_ENEMIES",
                         settings.startup["rampantFixed--newEnemies"].value)
			
	upgrade.rebuildActivePlayerForces(universe)
	
    if universe.NEW_ENEMIES then
        rebuildNativeTables(universe, game.create_random_generator(universe.ENEMY_SEED))
		if not universe["NEW_ENEMIES_SIDE"] then
			setNewEnemySide()
		end
    else
        universe.buildingHiveTypeLookup = {}
        universe.buildingHiveTypeLookup["biter-spawner"] = "biter-spawner"
        universe.buildingHiveTypeLookup["spitter-spawner"] = "spitter-spawner"
        universe.buildingHiveTypeLookup["small-worm-turret"] = "turret"
        universe.buildingHiveTypeLookup["medium-worm-turret"] = "turret"
        universe.buildingHiveTypeLookup["big-worm-turret"] = "turret"
        universe.buildingHiveTypeLookup["behemoth-worm-turret"] = "turret"
    end

    for _,surface in pairs(game.surfaces) do
        if not universe.maps then
            universe.maps = {}
        end
        if (not universe.maps[surface.index]) and (not SURFACE_IGNORED(surface, universe)) then
            prepMap(surface)
        end
    end
		
end

local function onBuild(event)
    local entity = event.created_entity or event.entity
    if entity.valid then
--		game.print("onBuild.."..entity.name)
        local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
        if (entity.type == "resource") and (entity.force.name == "neutral") then
            registerResource(entity, map)
        else
            accountPlayerEntity(entity, map, true, false)
            if universe.safeBuildings then
                if universe.safeEntities[entity.type] or universe.safeEntities[entity.name] then
                    entity.destructible = false
                end
            end
        end
    end
end

local function onMine(event)
    local entity = event.entity
    if entity.valid then
        local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
        if (entity.type == "resource") and (entity.force.name == "neutral") then
            if (entity.amount == 0) then
                unregisterResource(entity, map)
            end
        else
            accountPlayerEntity(entity, map, false, false)
        end
    end
end

-----------------
local landfillVectors = {{0,0}, {1,0}, {0,1}, {-1,0}, {0,-1}}

local function biters_landfill(entity)
	if entity.prototype.max_health < 300 then return end	
	local position = entity.position
	local surface = entity.surface
	for _, vector in pairs(landfillVectors) do
		local tile = surface.get_tile({position.x + vector[1], position.y + vector[2]})
		if tile.collides_with("resource-layer") then
			surface.set_tiles({{name = "landfill", position = tile.position}},true,true,true,true)
			local particle_pos = {tile.position.x + 0.5, tile.position.y + 0.5}
			for _ = 1, 50, 1 do
				surface.create_particle({
					name = "stone-particle",
					position = particle_pos,
					frame_speed = 0.1,
					vertical_speed = 0.12,
					height = 0.01,
					movement = {-0.05 + mRandom(0, 100) * 0.001, -0.05 + mRandom(0, 100) * 0.001}
				})
			end
		end
	end
end
-----------------

local function onDeath(event)
    local entity = event.entity
    if entity.valid then
        local surface = entity.surface
        local map = universe.maps[surface.index]
		if not map then
			return
		end	
		if (entity.force.name == "neutral") then
			if (entity.name == "cliff") then
				entityForPassScan(map, entity)
			end
			return
		end
		
        local entityPosition = entity.position
        local chunk = getChunkByPosition(map, entityPosition)
        local cause = event.cause
        local tick = event.tick
        local entityType = entity.type
        if (entity.force.name == "enemy") then

            local artilleryBlast = (cause and
                                    ((cause.type == "artillery-wagon") or (cause.type == "artillery-turret")))

			if (not artilleryBlast) and (entity.force.name == "enemy") then
				local incomingRange = 0
				if event.cause and event.cause.valid then
					incomingRange = mathUtils.euclideanDistancePoints(entity.position.x, entity.position.y, event.cause.position.x, event.cause.position.y)
					if incomingRange >= 90 then
						artilleryBlast = true
					end
				end	
			
			
			end
			
            if artilleryBlast then
                map.artilleryBlasts = map.artilleryBlasts + 1
				map.vengenceLimiter = 0
				universe.retribution = universe.retribution + 0.002
				
				if cause and cause.valid and (cause.type == "electric-turret") then
					if mRandom() < 0.005 then
						entity.surface.create_entity({
							name = "targetDummyPlasma-rampant",
							position = entityPosition, 
							force = "enemy",
							})	
					end		
				end
            end

            if (entityType == "unit") then
                if (chunk ~= -1) then
					if event.force and (event.force.name ~= "enemy") then
						biters_landfill(entity)
						-- drop death pheromone where unit died
						deathScent(map, chunk)

						if (not artilleryBlast) and (-getDeathGenerator(map, chunk) < -universe.retreatThreshold) and cause and cause.valid then
							retreatUnits(chunk,
										 cause,
										 map,
										 tick,
										 (artilleryBlast and RETREAT_SPAWNER_GRAB_RADIUS) or RETREAT_GRAB_RADIUS)
						end

						map.lostEnemyUnits = map.lostEnemyUnits + 1
						local chainVengenceCoefficient = settings.global["rampantFixed--chainVengenceCoefficient"].value	-- 0.6 default
						local vengenceOffset = chainVengenceCoefficient ^ map.vengenceLimiter
						if (not surface.peaceful_mode) and (mRandom() < (universe.rallyThreshold * vengenceOffset)) then
							rallyUnits(chunk, map, tick)
						end
					end
					squadCompression.onUnitKilled(universe, surface, entity, event.force, cause)
				end	
            elseif event.force and (event.force.name ~= "enemy") and
                ((entityType == "unit-spawner") or (entityType == "turret"))
            then
				map.vengenceLimiter = 0
				local pointsGain = 0
                if (entityType == "unit-spawner") then
					if artilleryBlast then
						universe.retribution = universe.retribution + 0.018	-- additional retribution points					
					end
					if universe.aiDifficulty ~= "Hard" then
						pointsGain = RECOVER_NEST_COST * 0.2
					else
						pointsGain = RECOVER_NEST_COST
					end
                else
					if universe.aiDifficulty ~= "Hard" then
						pointsGain = RECOVER_WORM_COST * 0.01
					else
						pointsGain = RECOVER_WORM_COST
					end		
                end
				
				if artilleryBlast then
					pointsGain = pointsGain * 1.2						
				end
				
                map.points = map.points + pointsGain
                if universe.aiPointsPrintGainsToChat and (pointsGain > 0) then
                        game.print(map.surface.name .. ": Points: +" .. pointsGain .. ". [Worm or Nest Lost] Total: " .. string.format("%.2f", map.points))				
				end
				

                unregisterEnemyBaseStructure(map, entity, event.damage_type)

                if (chunk ~= -1) then
                    rallyUnits(chunk, map, tick)

                    if (not artilleryBlast) and cause and cause.valid then
                        retreatUnits(chunk,
                                     cause,
                                     map,
                                     tick,
                                     RETREAT_SPAWNER_GRAB_RADIUS)
                    end
                end
            else
                local entityUnitNumber = entity.unit_number
                local pair = map.drainPylons[entityUnitNumber]
                if pair then
                    local target = pair[1]
                    local pole = pair[2]
                    if target == entity then
                        map.drainPylons[entityUnitNumber] = nil
                        if pole.valid then
                            map.drainPylons[pole.unit_number] = nil
                            pole.die()
                        end
                    elseif (pole == entity) then
                        map.drainPylons[entityUnitNumber] = nil
                        if target.valid then
                            map.drainPylons[target.unit_number] = nil
                            target.destroy()
                        end
                    end
                end
            end

        elseif (entity.force.name ~= "enemy") then
            local creditNatives = false
            if (event.force ~= nil) and (event.force.name == "enemy") then
                creditNatives = true
                if (chunk ~= -1) then
                    victoryScent(map, chunk, entityType)
                end

                local drained = (entityType == "electric-turret") and map.chunkToDrained[chunk]
                if cause or (drained and (drained - tick) > 0) then
                    if ((cause and ENERGY_THIEF_LOOKUP[cause.name]) or (not cause)) then
                        local conversion = ENERGY_THIEF_CONVERSION_TABLE[entityType]
                        if conversion then
                            local newEntity = surface.create_entity({
                                    position=entity.position,
                                    name=convertTypeToDrainCrystal(entity.force.evolution_factor, conversion),
                                    direction=entity.direction
                            })
                            if (conversion == "pole") then
                                local targetEntity = surface.create_entity({
                                        position=entity.position,
                                        name="pylon-target-rampant",
                                        direction=entity.direction
                                })
                                targetEntity.backer_name = ""
                                local pair = {targetEntity, newEntity}
                                map.drainPylons[targetEntity.unit_number] = pair
                                map.drainPylons[newEntity.unit_number] = pair
                                local wires = entity.neighbours
                                if wires then
                                    for _,v in pairs(wires.copper) do
                                        if (v.valid) then
                                            newEntity.connect_neighbour(v);
                                        end
                                    end
                                    for _,v in pairs(wires.red) do
                                        if (v.valid) then
                                            newEntity.connect_neighbour({
                                                    wire = DEFINES_WIRE_TYPE_RED,
                                                    target_entity = v
                                            });
                                        end
                                    end
                                    for _,v in pairs(wires.green) do
                                        if (v.valid) then
                                            newEntity.connect_neighbour({
                                                    wire = DEFINES_WIRE_TYPE_GREEN,
                                                    target_entity = v
                                            });
                                        end
                                    end
                                end
                            elseif newEntity.backer_name then
                                newEntity.backer_name = ""
                            end
                        end
                    end
                end
            elseif (entity.type == "resource") and (entity.force.name == "neutral") then
                if (entity.amount == 0) then
                    unregisterResource(entity, map)
                end
            end
            if creditNatives and universe.safeBuildings and
                (universe.safeEntities[entityType] or universe.safeEntities[entity.name])
            then
                makeImmortalEntity(surface, entity)
            else
                accountPlayerEntity(entity, map, false, creditNatives)
            end	
        end
    end
end

local function onEnemyBaseBuild(event)
    local entity = event.entity
    if entity.valid then
        local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
		
		if map.suspended then
			map.suspended = false
			map.suspendCheckTick = event.tick				
		end
		
        local chunk = getChunkByPosition(map, entity.position)
        if (chunk ~= -1) then
            local base
            if universe.NEW_ENEMIES then
				local thisIsRampantEnemy = false
                base = findNearbyBase(map, chunk, MAXIMUM_BASE_RADIUS, BASE_CHANGING_CHANCE)
                if not base then
					thisIsRampantEnemy = thisIsNewEnemyPosition(universe, chunk.x, chunk.y)
                    base = createBase(map,
                                      chunk,
                                      event.tick,
									  thisIsRampantEnemy)
                end
				if base and base.thisIsRampantEnemy then
					entity = upgradeEntity(entity,
										   base.alignment,
										   map ,nil, true)
				end						   
            end
            if entity and entity.valid then
                event.entity = registerEnemyBaseStructure(map, entity, base)
            end
        else
            local x,y = positionToChunkXY(entity.position)
            onChunkGenerated({
                    surface = entity.surface,
                    area = {
                        left_top = {
                            x = x,
                            y = y
                        }
                    }
            })
        end
    end
end

local function onSurfaceTileChange(event)
    local surfaceIndex = event.surface_index or (event.robot and event.robot.surface and event.robot.surface.index)
    local map = universe.maps[surfaceIndex]
	if not map then
		return
	end	
    local surface = map.surface
    local chunks = {}
    local tiles = event.tiles
    if event.tile then
        if ((event.tile.name == "landfill") or sFind(event.tile.name, "water")) then
            for i=1,#tiles do
                local position = tiles[i].position
                local chunk = getChunkByPosition(map, position)

                if (chunk ~= -1) then
					local chunkIndex = {chunk.x, chunk.y, map.surface.index}
                    universe.chunkToPassScan[chunkIndex] = true
                else
                    local x,y = positionToChunkXY(position)
                    local addMe = true
                    for ci=1,#chunks do
                        local c = chunks[ci]
                        if (c.x == x) and (c.y == y) then
                            addMe = false
                            break
                        end
                    end
                    if addMe then
                        local chunkXY = {x=x,y=y}
                        chunks[#chunks+1] = chunkXY
                        onChunkGenerated({area = { left_top = chunkXY },
                                          surface = surface})
                    end
                end
            end
        end
    else
        for i=1,#tiles do
            local tile = tiles[i]
            if (tile.name == "landfill") or sFind(tile.name, "water") then
                local position = tile.position
                local chunk = getChunkByPosition(map, position)

                if (chunk ~= -1) then
					local chunkIndex = {chunk.x, chunk.y, map.surface.index}
                    universe.chunkToPassScan[chunkIndex] = true
                else
                    local x,y = positionToChunkXY(position)
                    local addMe = true
                    for ci=1,#chunks do
                        local c = chunks[ci]
                        if (c.x == x) and (c.y == y) then
                            addMe = false
                            break
                        end
                    end
                    if addMe then
                        local chunkXY = {x=x,y=y}
                        chunks[#chunks+1] = chunkXY
                        onChunkGenerated({area = { left_top = chunkXY },
                                          surface = surface})
                    end
                end
            end
        end
    end
end

local function onResourceDepleted(event)
    local entity = event.entity
    if entity.valid then
		local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
        unregisterResource(entity, map)
    end
end

local function onRobotCliff(event)
    local entity = event.robot
    if entity.valid then
        local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
        if (event.item.name == "cliff-explosives") then
            entityForPassScan(map, event.cliff)
        end
    end
end

local function onUsedCapsule(event)
    local surface = game.players[event.player_index].surface
    local map = universe.maps[surface.index]
	if not map then
		return
	end	
    if (event.item.name == "cliff-explosives") then
        local position2Top = universe.position2Top
        local position2Bottom = universe.position2Bottom
        position2Top.x = event.position.x-0.75
        position2Top.y = event.position.y-0.75
        position2Bottom.x = event.position.x+0.75
        position2Bottom.y = event.position.y+0.75
        local cliffs = surface.find_entities_filtered(universe.cliffQuery)
        for i=1,#cliffs do
            entityForPassScan(map, cliffs[i])
        end
    end
end

local function onRocketLaunch(event)
    local entity = event.rocket_silo or event.rocket
    if entity.valid then
        local map = universe.maps[entity.surface.index]
		local points
		if game.active_mods["space-exploration"] then
			universe.retribution = universe.retribution + 2
			points = 500
		else
			universe.retribution = universe.retribution + 10
			points = 5000
		end	
		if not map then
			return
		end	
 		map.vengenceLimiter = 0
        map.rocketLaunched = map.rocketLaunched + 1
        map.points = map.points + points
        if universe.aiPointsPrintGainsToChat then
            game.print(map.surface.name .. ": Points: +" .. points .. ". [Rocket Launch] Total: " .. string.format("%.2f", map.points))
        end
    end
end

local function onTriggerEntityCreated(event)
    local entity = event.entity

    if entity.valid and (entity.name  == "drain-trigger-rampant") then
		local map = universe.maps[entity.surface.index]
		if not map then
			return
		end	
		local chunk = getChunkByPosition(map, entity.position)
		if (chunk ~= -1) then
			map.chunkToDrained[chunk] = event.tick + 60
		end
		entity.destroy()
	end
end

local function onInit()
    global.universe = {}
    hookEvents()
    onConfigChanged()
	setNewEnemySide()
	
end

local function onGroupFinishedGathering(event)
    local group = event.group
    if not group.valid or (group.force.name ~= "enemy") then
		return
	end
	local map = universe.maps[group.surface.index]
	if not map then 
		--group.destroy()
		return		
	end
	local squad = universe.groupNumberToSquad[group.group_number]
	if (not group.is_script_driven) or squad then
		if (map.state == constants.AI_STATE_PEACEFUL) or (universe.aiNocturnalMode and (group.surface.darkness <= 0.65)) then
			group.destroy()
			return		
		end	
	end
	
	if squad then
		processCompression(map, squad, getChunkByPosition(map, group.position), true)
	elseif (#group.members > 70) and group.position and not group.is_script_driven then
		local nonRampantSquad = createSquad(group.position, map, group, false)
		nonRampantSquad.nonRampantSquad = true
		processCompression(map, nonRampantSquad, getChunkByPosition(map, group.position), false)
		if nonRampantSquad.compressed then
			universe.nonRampantCompressedSquads[group.group_number] = nonRampantSquad
			--game.print("non-rampant squad#"..group.group_number..", "..#group.members.." units [gps=" .. group.position.x .. "," .. group.position.y .."]")	-- debug
		end	
	end
	
	if squad and group.is_script_driven then
		squadDispatch(map, squad)
	end
end

local function onForceCreated(event)
	if event.force then
		if game.forces["enemy"].is_friend(event.force) then
			return
		end	
		if game.forces["enemy"].get_cease_fire(event.force) then
			return
		end	
	end
    universe.activePlayerForces[#universe.activePlayerForces+1] = event.force.name
end

local function onForceDiplomacyChanged(event)
	local otherForce = event.force
	if event.force.name == "enemy" then
		otherForce = event.other_force
	end
	local thisIsEnemyFriend = game.forces["enemy"].is_friend(otherForce)
	thisIsEnemyFriend = thisIsEnemyFriend or game.forces["enemy"].get_cease_fire(otherForce)
	if thisIsEnemyFriend then
		for i=#universe.activePlayerForces,1,-1 do
			if (universe.activePlayerForces[i] == otherForce.name) then
				tRemove(universe.activePlayerForces, i)
				break
			end
		end
	else
		local forceFound = false
		for i=#universe.activePlayerForces,1,-1 do
			if (universe.activePlayerForces[i] == otherForce.name) then
				forceFound = true
				break
			end	
		end	
		if not forceFound then
			universe.activePlayerForces[#universe.activePlayerForces+1] = otherForce.name
		end
	end
end 

local function onForceMerged(event)
    for i=#universe.activePlayerForces,1,-1 do
        if (universe.activePlayerForces[i] == event.source_name) then
            tRemove(universe.activePlayerForces, i)
            break
        end
    end
end

local function onSurfaceCreated(event)
	local surface = game.surfaces[event.surface_index]
	if not SURFACE_IGNORED(surface, universe) then
		prepMap(surface)
	end	
end

local function onSurfaceDeleted(event)
    local surfaceIndex = event.surface_index
    if (universe.mapIterator == surfaceIndex) then
        universe.mapIterator, universe.activeMap = next(universe.maps, universe.mapIterator)
    end
    if (universe.suspendMapsIterator == surfaceIndex) then
        universe.suspendMapsIterator = next(universe.maps, universe.suspendMapsIterator)
    end
    universe.maps[surfaceIndex] = nil
end

local function onBuilderArrived(event)
    local builder = event.group
    if not (builder and builder.valid) then
        builder = event.unit
        if not (builder and builder.valid and builder.force.name == "enemy") then
            return
        end
    elseif (builder.force.name ~= "enemy") then
        return
    end
    local targetPosition = universe.position
    targetPosition.x = builder.position.x
    targetPosition.y = builder.position.y

    if universe.aiPointsPrintSpendingToChat then
        game.print("Settled: [gps=" .. targetPosition.x .. "," .. targetPosition.y .."]")		
    end
    builder.surface.create_entity(universe.createBuildCloudQuery)
end

local targetDummyArray= {}
targetDummyArray["targetDummyPlasma-rampant"] = true
targetDummyArray["targetDummyFire-rampant"] = true
targetDummyArray["targetDummyPhysical-rampant"] = true
targetDummyArray["targetDummyLaser-rampant"] = true
local protectedAreaUnitsQuery = {
		position = nil,
		radius = 6,
        force = "enemy",
        type={"unit"}
		}
 
local function onSectorScanned(event)
	local entity = event.radar
	if entity.valid then
		if targetDummyArray[entity.name] then
			if entity.name == "targetDummyPlasma-rampant" then
				protectedAreaUnitsQuery.position = entity.position
				local protectedEntities = entity.surface.find_entities_filtered(protectedAreaUnitsQuery)
				for i = 1, #protectedEntities do
					local protectedEntity = protectedEntities[i]
					protectedEntity.destructible = false
					universe.protectedUnits[protectedEntity.unit_number] = {entity = protectedEntity, tick = game.tick + 120}
					--game.print("tick:"..game.tick.. " add protection to "..universe.protectedUnits[protectedEntity.unit_number].tick)
				end	
			end
			entity.damage(30, "neutral")
		elseif entity.name == "test-rampant" then
			onEntitySpawned(event)
			entity.damage(1, "neutral")
		end
	end
	return
end

local function processProtectedUnits()
	-- if not universe then
		-- return
	-- end	
	for unitNumber, protectionData in pairs(universe.protectedUnits) do
		if not protectionData.entity.valid then
			universe.protectedUnits[unitNumber] = nil
		elseif protectionData.tick <= game.tick then
			protectionData.entity.destructible = true
			universe.protectedUnits[unitNumber] = nil	
			--game.print("tick:"..game.tick.." remove protection")
		end
	end
end


-- this variables reset after reloading (player can change/disable protecion at startup settings)
-- as practice has shown, local variables do not lead to desynchronization, unless it leads to different results
local unitsProtection = {}
local OP_Efficiency = settings.startup["rampantFixed--oneshotProtection_efficiency"].value
local LR_Efficiency = settings.startup["rampantFixed--longRangeImmunity_efficiency"].value 
local OP_efficienty = OP_Efficiency * 0.01
local LR_DamagePercent = 1 - LR_Efficiency * 0.01
local allowOneshotProtection = settings.startup["rampantFixed--allowOneshotProtection"]
local allowLongRangeImmunity = settings.startup["rampantFixed--allowLongRangeImmunity"]
 

local function fillAndReturnUnitProtections(entity)
	if unitsProtection[entity.name] then
		return unitsProtection[entity.name]
	else
		local longRangeImmunity
		local overdamageProtection
		if entity.prototype.resistances then
			for resistance, values in pairs(entity.prototype.resistances) do
				if resistance == "rampant-longRangeImmunity" then
					if values.percent and (values.percent == LR_Efficiency) and (values.decrease > 5) then
						longRangeImmunity = values.decrease
					end	
				elseif resistance == "rampant-overdamageProtection" then
					if values.percent and (values.percent == OP_efficienty) and (values.decrease > 5) then 
						overdamageProtection = values.decrease
					end	
				end	
				
			end
		end	
		unitsProtection[entity.name] = {longRangeImmunity = longRangeImmunity, overdamageProtection = overdamageProtection}
		return unitsProtection[entity.name]
	end
end	
 
local function onEntityDamaged(event)
	if not event.entity then
		return
	end
	if event.entity.valid and event.entity.unit_number then
		local entity = event.entity
		 
		local unitProtection = fillAndReturnUnitProtections(event.entity)
		if (event.final_damage_amount > 0) and event.cause and (event.cause ~= event.entity) then
			-----------------
			if allowLongRangeImmunity and unitProtection.longRangeImmunity then					
				local incomingRange = 0
				if event.cause and event.cause.valid then
					 incomingRange = mathUtils.euclideanDistancePoints(entity.position.x, entity.position.y, event.cause.position.x, event.cause.position.y)
				end	
				if incomingRange>unitProtection.longRangeImmunity then
					local startHP = universe.unitProtectionData.unitCurrentHP[entity.unit_number] or (entity.prototype.max_health)
					if LR_DamagePercent > 0 then
						event.final_damage_amount = event.final_damage_amount * LR_DamagePercent
					else
						event.final_damage_amount =	0
					end	
					entity.health = startHP - event.final_damage_amount					
					event.final_health = entity.health					
					--game.print("LRI:"..startHP.."-("..event.original_damage_amount.."->"..event.final_damage_amount..")="..entity.health)	-- DEBUG
				end	
			end
			-----------------
			if allowOneshotProtection and unitProtection.overdamageProtection and (event.original_damage_amount > OVERDAMAGEPROTECTION_THRESHOLD) and (event.original_damage_amount >= event.final_damage_amount)  then
				local maxDamage = unitProtection.overdamageProtection
				local startHP = universe.unitProtectionData.unitCurrentHP[entity.unit_number] or (entity.prototype.max_health)
				if maxDamage<event.original_damage_amount then
					local final_damage_amount = maxDamage*(event.final_damage_amount/event.original_damage_amount)
					if OP_efficienty < 1 then
						final_damage_amount = event.final_damage_amount - (event.final_damage_amount - final_damage_amount) * OP_efficienty
					end
					event.final_damage_amount = final_damage_amount
					entity.health = startHP - final_damage_amount
				end	
				event.final_health = entity.health
				--game.print("OP:"..startHP.."-("..event.original_damage_amount.."->"..event.final_damage_amount..")="..entity.health..", source = ".. tostring(event.cause.name))		-- DEBUG
			end
		end
		
		if entity.health<=0 then 
			local compressedUnit = universe.compressedUnits[entity.unit_number]
			if compressedUnit and (compressedUnit.count > 1) then
				onUnitPreKilled(universe, entity.surface, entity, event.force, event.cause)
			end	
		end	
		if unitProtection.longRangeImmunity or unitProtection.overdamageProtection then
			if entity.health<=0 then
				universe.unitProtectionData.unitCurrentHP[entity.unit_number] = nil
			else
				universe.unitProtectionData.unitCurrentHP[entity.unit_number] = entity.health
			end
		end
	end		
end

local function showNewgameMessages()
	if universe.NEW_ENEMIES then
		game.print({"description.rampantFixed--EnemySettings1_1_10"})	
	end
	if game.active_mods["space-exploration"] and game.active_mods["combat-mechanics-overhaul"] and game.active_mods["Krastorio2"] then
		 if not settings.startup["rampantFixed--useBlockableSteamAttacks"].value then
			game.print({"description.rampantFixed--K2_SE_CMO_incompatibilityWarning"})
		 end			
	end
end	


-- hooks

script.on_event(defines.events.on_tick,
                function ()
                    local gameRef = game
                    local tick = gameRef.tick
                    local pick = tick % 8
					local pick60 = tick % 60
					---------
					if tick == 1 then
						showNewgameMessages()
					end	
					---------
					removeOneTickImmunity(universe)
					processProtectedUnits()
					
                    local map = universe.activeMap
					local mapCounter = 0			-- it looks very much like some mods are able to remove the main world. If this happens and there are no worlds left with biters, it will turn out to be an endless cycle.
                    if (not map) or map.suspended or (universe.processedChunks > #map.processQueue) then
						repeat
							universe.mapIterator, map = next(universe.maps, universe.mapIterator)
							if not map then
								universe.mapIterator, map = next(universe.maps, nil)	
								break
							end
							mapCounter = mapCounter + 1
						until map and ((not map.suspended) or (map.surface.name == "nauvis") or (mapCounter > 1000))	-- nauvis cant be suspended, but just in case...
						
                        universe.processedChunks = 0
                        universe.activeMap = map
                    end
					
					if not map then
						if universe.mapIterator then 
							universe.maps[universe.mapIterator] = nil
							universe.mapIterator = nil
						end	
                        processPendingChunks(universe, tick)
                        processScanChunks(universe)
                        universe.processedChunks = universe.processedChunks + PROCESS_QUEUE_SIZE
						return
					end	
					

                    if (pick == 0) then
                        processPendingChunks(universe, tick)
                        processScanChunks(universe)
                        universe.processedChunks = universe.processedChunks + PROCESS_QUEUE_SIZE
                        if universe.NEW_ENEMIES then
                            recycleBases(universe, tick)
                        end
                        cleanUpMapTables(map, tick)
						suspendClearedMaps(universe, tick)
                    elseif (pick == 1) then
                      processPlayers(gameRef.connected_players, universe, tick)
                    elseif (pick == 2) then
                        processMap(map, tick)			
                    elseif (pick == 3) then
                        processStaticMap(map)
                        disperseVictoryScent(map)
                        processVengence(map)
                    elseif (pick == 4) then
                        scanResourceMap(map, tick)		
                    elseif (pick == 5) then
                        scanEnemyMap(map, tick)
                        processSpawners(map, tick)
                    elseif (pick == 6) then
                        scanPlayerMap(map, tick)		
                        processNests(map, tick)			
                    elseif (pick == 7) then
						processPendingMutations(universe)
                    end
					
					if pick60 == 0 then						
                        processMapAIs(universe, gameRef.forces.enemy.evolution_factor, tick)						
					end

                    processActiveNests(universe, tick)
					processDecompressQueue(universe)
                    cleanSquads(universe)
end)

script.on_nth_tick(30000, 
	function()
		if universe then
			baseUtils.setRandomBaseToMutate(universe)
		end	
	end
)

--- copressed squads
script.on_nth_tick(60, 
	function()
		if universe and universe.nonRampantCompressedSquads then
			processNonRampantSquads(universe)
		end
	end
)

script.on_nth_tick(36000, 
	function()
		squadCompression.checkCompressedUnitsList(universe)
	end
)
--- 

script.on_event(defines.events.on_surface_deleted, onSurfaceDeleted)
script.on_event(defines.events.on_surface_cleared, onSurfaceCreated)
script.on_event(defines.events.on_surface_created, onSurfaceCreated)

script.on_init(onInit)
script.on_load(onLoad)
script.on_event(defines.events.on_runtime_mod_setting_changed, onModSettingsChange)
script.on_configuration_changed(onConfigChanged)

script.on_event(defines.events.on_resource_depleted, onResourceDepleted)
script.on_event({defines.events.on_player_built_tile,
                 defines.events.on_robot_built_tile,
                 defines.events.script_raised_set_tiles}, onSurfaceTileChange)

script.on_event(defines.events.on_player_used_capsule, onUsedCapsule)

script.on_event(defines.events.on_trigger_created_entity, onTriggerEntityCreated)

script.on_event(defines.events.on_pre_robot_exploded_cliff, onRobotCliff)

script.on_event(defines.events.on_biter_base_built, onEnemyBaseBuild)
script.on_event({defines.events.on_player_mined_entity,
                 defines.events.on_robot_mined_entity}, onMine)

script.on_event({defines.events.on_built_entity,
                 defines.events.on_robot_built_entity,
                 defines.events.script_raised_built,
                 defines.events.script_raised_revive}, onBuild)


script.on_event(defines.events.on_rocket_launched, onRocketLaunch)
script.on_event({defines.events.on_entity_died,
                 defines.events.script_raised_destroy}, onDeath)
script.on_event(defines.events.on_chunk_generated, onChunkGenerated)
script.on_event(defines.events.on_force_created, onForceCreated)
script.on_event(defines.events.on_forces_merged, onForceMerged)
script.on_event(defines.events.on_force_cease_fire_changed, onForceDiplomacyChanged)
script.on_event(defines.events.on_force_friends_changed, onForceDiplomacyChanged)

script.on_event(defines.events.on_unit_group_finished_gathering, onGroupFinishedGathering)

script.on_event(defines.events.on_build_base_arrived, onBuilderArrived)

-- + !КДА 2021.11
script.on_event(defines.events.on_sector_scanned, onSectorScanned)
--script.on_event(defines.events.on_script_trigger_effect, onScriptTriggerEffect)
script.on_event(defines.events.on_entity_damaged, onEntityDamaged, {{filter="type", type="unit"}})
-- - !КДА 2021.11
script.on_event(defines.events.on_gui_click, on_gui_click)

local function rampantSetAIState(event)
    local surfaceIndex = game.players[event.player_index].surface.index
    local map = universe.maps[surfaceIndex]
	if not map then
		local surfaceName = game.players[event.player_index].surface.name
		game.print(surfaceName .. " is excluded from processing ")
		return
	end	

    game.print(map.surface.name .. " is in " .. constants.stateEnglish[map.state])

    if event.parameter then
        local target = tonumber(event.parameter)

        if (target == nil) then
            game.print("invalid param")
            return
        end

        if (target ~= constants.AI_STATE_PEACEFUL and target ~= constants.AI_STATE_AGGRESSIVE and target ~= constants.AI_STATE_RAIDING and target ~= constants.AI_STATE_MIGRATING and target ~= constants.AI_STATE_SIEGE and target ~= constants.AI_STATE_ONSLAUGHT) then
            game.print(target .. " is not a valid state")
            return
        else
            map.state = target
            game.print(map.surface.name .. " is now in " .. constants.stateEnglish[map.state])
        end
    end
end

commands.add_command('rampantSetAIState', "", rampantSetAIState)

local function rampantForceMutations(event)
    local i = 0
    local basesTotal = 0
	
	for id, base in pairs(universe.bases) do
		basesTotal = basesTotal + 1
		if base and base.thisIsRampantEnemy then
			base.tier = 0
			i = i + 1
		end
	end
	game.print("Bases forces to mutate: ".. i.."/"..basesTotal)
	
end

commands.add_command('rampantForceMutations', "", rampantForceMutations)
