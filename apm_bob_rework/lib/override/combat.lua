local combat    = require "lib.entities.combat"
local alloys    = require "lib.entities.alloys"
local plates    = require "lib.entities.plates"
local materials = require "lib.entities.materials"
local product   = require "lib.entities.product"
local gems      = require "lib.entities.gems"
local wires     = require "lib.entities.wires"
local logic     = require "lib.entities.logic"
local pipes     = require "lib.entities.pipes"
local pumps     = require "lib.entities.pumps"
local energy    = require "lib.entities.buildings.energy"
local modules   = require "lib.entities.modules"
local fluids    = require "lib.entities.fluids"
local nuclear   = require "lib.entities.nuclear"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local mod = apm.lib.utils.recipe.ingredient.mod

--TODO: rework

require('lib.entities.base')
local t = require('lib.tier.base')
require('lib.utils.debug')

local alloy = require('lib.entities.alloys')

local buffStackSizeForArtillery = function(name)
	local item = data.raw.ammo[name]
	if item then
		item.stack_size = 20
	end
end

local changeRange = function(type, name, radius)
	local typed = data.raw[type]
	if typed == nil then
		return
	end
	local turret = typed[name]
	if turret and turret.attack_parameters then
		turret.attack_parameters.range = radius
	end
end

local changeAmmo = function(type, name, new)
	local typed = data.raw[type]
	if typed == nil then
		return
	end
	local turret = typed[name]
	if turret and turret.attack_parameters then
		turret.attack_parameters.ammo_categories = new
	end
end

local ammoTurretType = 'ammo-turret'
local gunType = 'gun'
local electricTurretType = 'electric-turret'

local drop = function()
	local rm = apm.lib.utils.recipe.remove

	rm('bio-magazine-ammo-rampant-arsenal')
	rm('he-magazine-ammo-rampant-arsenal')
	rm('incendiary-magazine-ammo-rampant-arsenal')
	rm('bio-shotgun-ammo-rampant-arsenal')
	rm('he-shotgun-ammo-rampant-arsenal')
	rm('incendiary-shotgun-ammo-rampant-arsenal')
	rm('uranium-shotgun-ammo-rampant-arsenal')
	-- rm('bio-rocket-ammo-rampant-arsenal')
	-- rm('he-rocket-ammo-rampant-arsenal')
	-- rm('incendiary-rocket-ammo-rampant-arsenal')
	-- rm('rocket')
	-- rm('explosive-rocket')
	rm('bob-electric-rocket')
	rm('electric-bullet-magazine')
	rm('electric-bullet')
	rm('electric-bullet-projectile')
	-- rm('plasma-bullet')
	-- rm('plasma-bullet-projectile')
	-- rm('plasma-rocket-warhead')
	rm('electric-rocket-warhead')
	rm('shotgun-electric-shell')
	-- rm('plasma-bullet-magazine')
	-- rm('plasma-rocket')
	-- rm('shotgun-plasma-shell')
	rm('bob-plasma-turret')
	rm('bob-plasma-turret-1')
	rm('bob-plasma-turret-2')
	rm('bob-plasma-turret-3')
	rm('bob-plasma-turret-4')
	rm('bob-plasma-turret-5')
	rm('distractor-artillery-shell')
	rm('fire-artillery-shell')
	rm('poison-artillery-shell')
	rm('explosive-artillery-shell')
	rm('atomic-artillery-shell')
	rm('mk3-generator-rampant-arsenal')
	rm('mk3-shield-rampant-arsenal')
	rm('mending-wall-rampant-arsenal')
	rm('mending-gate-rampant-arsenal')
	rm('reinforced-wall')
	rm('reinforced-gate')
	rm('medic-item-rampant-arsenal')
	rm('lightning-item-rampant-arsenal')
	rm('advanced-beam-item-rampant-arsenal')
	rm('gun-item-rampant-arsenal')

	-- drop vehicle plasma cannons ...
	rm('vehicle-big-turret-1')
	rm('vehicle-big-turret-2')
	rm('vehicle-big-turret-3')
	rm('vehicle-big-turret-4')
	rm('vehicle-big-turret-5')
	rm('vehicle-big-turret-6')
end

local buildLaserTurret = function()
	local recipe = combat.turret.laser.basic
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, gems.ruby.polished, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 10)

	recipe = combat.turret.laser.advance
	tier = t.blue
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, gems.sapphire.polished, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 20)

	recipe = combat.turret.laser.extra
	tier = apm.bob_rework.lib.tier.blue

	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 60)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, gems.diamond.polished, 25)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 200)
end

local buildCanonTurret = function()
	local recipe = combat.turret.cannon.basic
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.basic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)

	recipe = combat.turret.cannon.rapid
	tier = t.blue
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.basic, 25)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 30)
end

local buildRocketTurret = function()
	local recipe = combat.turret.rocket.basic
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.basic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 15)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 15)

	local recipe = combat.turret.rocket.rapid
	local tier = t.blue
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.basic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 30)
end

local buildFlameTurrets = function()
	local recipe = 'acid-cannon-rampant-arsenal'
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20)

	local recipe = 'flamethrower-turret'
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20)

	local recipe = 'suppression-cannon-item-rampant-arsenal'
	local tier = t.blue
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 60)
end

local buildSolarPanel = function(recipe, tier, shell, conduct)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, shell, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, conduct, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 5)
	if tier.level == 5 then
		apm.lib.utils.recipe.ingredient.mod(recipe, shell, 12)
	end
end

local buildEqBurnerGen = function()
	local recipe = combat.equip.generator.burner.basic
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.burner, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.egenerator, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.logic, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)

	local recipe = combat.equip.generator.burner.advance
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.egenerator, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.burner.basic, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.wire, 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)
end

local buildFusionReactorEq = function(recipe, level)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.PU, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.APU, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.low.density.structure, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 10)
end

local buildEqReactors = function()
	buildFusionReactorEq(combat.equip.generator.nuclear.basic, 1)
	local recipe = combat.equip.generator.nuclear.advance
	buildFusionReactorEq(recipe, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, energy.heat.pipe.extra, 10)
end

local buildPersonalLaser = function(recipe, tier, optics)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	if tier.extraLogic then
		apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 5)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, optics, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 10)
end

local buildExoskeleton = function(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 5 * tier.level)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
	if tier.extraLogic then
		apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 30)
	end
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 30)
end

local buildPersonalRoboportsControl = function()
	local recipe = 'personal-roboport-robot-equipment-2'
	local prev = 'personal-roboport-robot-equipment'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, modules.case, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 5)

	prev = recipe
	recipe = 'personal-roboport-robot-equipment-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, modules.case, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 5)

	prev = recipe
	recipe = 'personal-roboport-robot-equipment-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, modules.case, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 5)
end

local buildPersonalRoboport = function(recipe, tier, level)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	local antenna = 'roboport-antenna-' .. tostring(level)
	local hatch = 'roboport-door-' .. tostring(level)
	local pad = 'roboport-chargepad-' .. tostring(level)
	apm.lib.utils.recipe.ingredient.mod(recipe, antenna, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, hatch, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, pad, 2)
end

local buildNightvision = function(recipe, tier, optics)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, optics, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 5)
end

local changeIron2GM = function(recipe, count)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, count)
end

local changeIron2Steel = function(recipe, count)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, count)
end

local changeIronCladMortar = function()
	local recipe = combat.turret.mortar.base
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.iron, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.brick, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.brass, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.bearing.brass, 2)

	changeRange(ammoTurretType, recipe, 55)
	changeAmmo(ammoTurretType, recipe, { [0] = 'capsule-launcher' })
end

local updateWeapons = function()
	local recipe = combat.gun.pistol
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.tin, 6)

	recipe = combat.gun.submachine
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.bronze, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.bronze, 6)

	recipe = combat.gun.minigun
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.bronze, 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.bearing.bronze, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.bronze, 4)

	recipe = combat.gun.shotgun.basic
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.bronze, 10)

	recipe = combat.gun.shotgun.combat
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.brass, 8)

	recipe = combat.gun.rifle.basic
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 14)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.bronze, 6)

	recipe = combat.gun.rifle.sniper
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.glass, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.brass, 2)

	recipe = combat.gun.rifle.laser
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, gems.diamond, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, gems.ruby, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, wires.unsulated, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.PU, 20)

	recipe = combat.gun.launcher.rocket.basic
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 10)

	recipe = combat.gun.launcher.rocket.advance
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.invar, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.circuit.advanced, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.aluminium, 2)

	recipe = combat.gun.flamethrower
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.cobalt.steel, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.cobaltSteel, 4)
	apm.lib.utils.recipe.ingredient.mod(recipe, pumps.red, 1)

	recipe = combat.gun.mortar
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 4)

	changeIronCladMortar()
end

local buildBattery = function(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 5 * tier.level)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	if tier.extraLogic then
		apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 5)
	end
end

local tuneAtomicBomb = function()
	local recipe = 'atomic-bomb'
	local set = function(item, count)
		if count == nil then
			count = 1
		end

		apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
	end

	set('apm_oxide_pellet_pu239', 2)

	local item = data.raw.projectile['atomic-rocket']
	if item ~= nil then
		-- modify attack result
		-- apm.bob_rework.lib.utils.debug.object(item)

		-- item.ammo_type.action = nil
		-- item.ammo_type.action = {
		-- 	action = {
		-- 		type = "direct",
		-- 		action_delivery = {
		-- 		  type = "instant",
		-- 		  target_effects = {
		-- 			{
		-- 			  type = "create-entity",
		-- 			  entity_name = "plasma-explosion",
		-- 			},
		-- 			{
		-- 			  type = "damage",
		-- 			  damage = { amount = 1200, type = "plasma" },
		-- 			},
		-- 			{
		-- 			  type = "nested-result",
		-- 			  action = {
		-- 				type = "area",
		-- 				radius = 3.5,
		-- 				action_delivery = {
		-- 				  type = "instant",
		-- 				  target_effects = {
		-- 					{
		-- 					  type = "damage",
		-- 					  damage = { amount = 1800, type = "plasma" },
		-- 					},
		-- 					{
		-- 					  type = "create-sticker",
		-- 					  sticker = "plasma-sticker",
		-- 					},
		-- 				  },
		-- 				},
		-- 			  },
		-- 			},
		-- 			{
		-- 			  type = "create-entity",
		-- 			  entity_name = "small-scorchmark",
		-- 			  check_buildability = true,
		-- 			},
		-- 		  },
		-- 		},
		-- 	  },
		-- }
	end
end

local modify = function()
	local recipe = product.chemistry.cordite
	apm.lib.utils.recipe.ingredient.mod(recipe, 'gun-cotton', 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'nitroglycerin', 30)
	apm.lib.utils.recipe.result.mod(recipe, recipe, 10)

	local recipe = 'piercing-rounds-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 1)

	local recipe = 'firearm-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 1)

	local recipe = 'apm_ammonium_sulfate_chem'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_coal_saturated_wastewater', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'ammonia', 15)

	local recipe = 'shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 1)

	local recipe = 'piercing-shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 1)

	local recipe = 'artillery-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.tungsten, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.cordite, 50)

	local recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.cordite, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.explosives, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 4)

	local recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.cordite, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.explosives, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 4)

	-- local recipe = combat.equip.generator.nuclear.advance
	-- apm.lib.utils.recipe.ingredient.mod(recipe, 'fusion-reactor-equipment-2', 0)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, 'nuclear-reactor', 1)

	local recipe = 'mech-leg-segment'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.titaniumAlloy, 10)

	local recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, alloy.gunmetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 2)

	local recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)

	local recipe = 'scatter-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.cordite, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)

	local recipe = 'artillery-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.tungsten, 15)

	local recipe = 'atomic-bomb'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'rocket-body', 1)

	local recipe = 'grenade'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 5)

	local recipe = 'rifle-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.bronze, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.tin, 15)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.gray.logic, 2)

	local recipe = combat.turret.rifle
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.wood, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 1)

	local rbody = 'rocket-body'
	local rhead = 'rocket-warhead'

	local recipe = 'rocket'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 10)

	local recipe = 'explosive-rocket'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, rbody, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosive-rocket-warhead', 1)

	local recipe = 'bio-rocket-ammo-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, rbody, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'poison-rocket-warhead', 1)

	local recipe = 'he-rocket-ammo-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, rbody, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosive-rocket-warhead', 1)

	local recipe = 'incendiary-rocket-ammo-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, rbody, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'flame-rocket-warhead', 1)

	apm.lib.utils.technology.add.recipe_for_unlock('rocketry', rbody)
	apm.lib.utils.technology.add.recipe_for_unlock('rocketry', rhead)
	apm.lib.utils.technology.remove.recipe_from_unlock('bob-poison-rocket', 'bob-poison-rocket')
	apm.lib.utils.technology.remove.recipe_from_unlock('bob-flame-rocket', 'bob-flame-rocket')
	apm.lib.utils.technology.remove.recipe_from_unlock('bob-explosive-rocket', 'bob-explosive-rocket')

	apm.lib.utils.technology.delete('bob-rocket')

	local recipe = 'mortar-gun-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 1)

	local recipe = 'grenade-capsule-ammo-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.gun.powder, 2)

	local recipe = 'he-artillery-ammo-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'cluster-grenade', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 20)

	local recipe = 'poison-capsule'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'coal', 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'sulfur', 2)
	-- apm.lib.utils.recipe.category.change(recipe, 'crafting-with-fluid')

	local recipe = 'toxic-capsule-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.category.change(recipe, 'crafting-with-fluid')
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'chlorine', 20)

	local recipe = 'poison-bullet-projectile'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.category.change(recipe, 'crafting-with-fluid')
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'chlorine', 5)

	local recipe = 'paralysis-capsule-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.category.change(recipe, 'crafting-with-fluid')
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.gunmetal, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'ammonia', 20)

	local recipe = 'fire-capsule'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'electronic-circuit', 0)
	local recipe = 'slowdown-capsule'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.resin, 5)

	local recipe = 'cluster-grenade'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.explosives, 5)

	local recipe = 'poison-rocket-warhead'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.category.change(recipe, 'crafting-with-fluid')
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.plastic, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'chlorine', 20)

	local recipe = combat.equip.generator.transmitter.battery
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, wires.tinned, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.logic, 15)

	local recipe = combat.equip.generator.transmitter.tesla
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.wire, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.logic, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 2)

	recipe = combat.wall.red
	local tier = t.red
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, materials.refined.concrete, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)

	recipe = combat.wall.blue
	tier = t.blue
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.tungstenCarbide, 15)

	buildBattery(combat.equip.battery.I, t.yellow)
	local recipe = combat.equip.battery.II
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.battery.I, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.logic, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, t.yellow.wire, 10)

	recipe = 'flame-rocket-warhead'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, fluids.napalm, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)

	buildBattery(combat.equip.battery.III, t.red)
	buildBattery(combat.equip.battery.IV, t.blue)

	changeRange(ammoTurretType, 'rapid-cannon-ammo-turret-rampant-arsenal', 50)
	changeRange(ammoTurretType, 'cannon-ammo-turret-rampant-arsenal', 50)
	changeRange(ammoTurretType, 'rocket-ammo-turret-rampant-arsenal', 70)
	changeRange(ammoTurretType, 'rapid-rocket-ammo-turret-rampant-arsenal', 70)
	changeRange(ammoTurretType, 'gun-turret', 22)
	changeRange(ammoTurretType, 'bob-gun-turret-2', 24)
	changeRange(ammoTurretType, 'bob-gun-turret-3', 26)
	changeRange(ammoTurretType, 'bob-gun-turret-4', 28)
	changeRange(ammoTurretType, 'bob-gun-turret-5', 30)
	changeRange(ammoTurretType, 'bob-sniper-turret-1', 50)
	changeRange(ammoTurretType, 'bob-sniper-turret-2', 55)
	changeRange(ammoTurretType, 'bob-sniper-turret-3', 60)
	changeRange(ammoTurretType, 'rifle-ammo-turret-rampant-arsenal', 20)
	changeRange(ammoTurretType, 'shotgun-ammo-turret-rampant-arsenal', 22)

	changeRange(electricTurretType, 'laser-turret', 28)
	changeRange(electricTurretType, 'bob-laser-turret-2', 30)
	changeRange(electricTurretType, 'bob-laser-turret-3', 32)
	changeRange(electricTurretType, 'bob-laser-turret-4', 34)
	changeRange(electricTurretType, 'bob-laser-turret-5', 36)
	changeRange(electricTurretType, 'advanced-laser-electric-turret-rampant-arsenal', 56)

	changeRange(gunType, 'rocket-launcher', 60)
	changeRange(gunType, 'rocket-launcher-gun-rampant-arsenal', 60)

	local activeDefenceEquipment = 'active-defense-equipment'
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment', 30)
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment-2', 32)
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment-3', 34)
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment-4', 36)
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment-5', 38)
	changeRange(activeDefenceEquipment, 'personal-laser-defense-equipment-6', 40)

	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-1', 30)
	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-2', 32)
	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-3', 34)
	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-4', 36)
	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-5', 38)
	changeRange(activeDefenceEquipment, 'vehicle-laser-defense-6', 40)

	local generator = data.raw['generator-equipment']['apm_equipment_burner_generator_advanced']
	generator.shape.width = 2
	generator.shape.height = 2

	local shells = {
		[1] = 'cannon-shell',
		[2] = 'explosive-cannon-shell',
		[3] = 'bio-cannon-shell-ammo-rampant-arsenal',
		[4] = 'he-cannon-shell-ammo-rampant-arsenal',
		[5] = 'incendiary-cannon-shell-ammo-rampant-arsenal',
		[6] = 'scatter-cannon-shell',
		[7] = 'uranium-cannon-shell',
		[8] = 'explosive-uranium-cannon-shell'
	}
	for _, shell in ipairs(shells) do
		local ammo = data.raw.ammo[shell]

		if ammo and ammo.ammo_type and ammo.ammo_type.action and ammo.ammo_type.action.action_delivery then
			ammo.ammo_type.action.action_delivery.max_range = 60
		end

		if ammo and ammo.ammo_type and ammo.ammo_type and ammo.ammo_type.action then
			for _, v in ipairs(ammo.ammo_type.action) do
				if v.action_delivery and v.action_delivery.max_range then
					v.action_delivery.max_range = 60
				end
			end
		end
	end

	recipe = combat.ammo.artillery.bio
	mod(recipe, 'toxic-capsule-rampant-arsenal', 1)

	changeIron2GM('grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('bio-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('he-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('incendiary-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('cluster-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('posion-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('toxic-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('slowdown-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('paralysis-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('defender-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('distractor-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('destroyer-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('landmine-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('bio-landmine-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('he-landmine-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('incendiary-landmine-grenade-capsule-ammo-rampant-arsenal', 2)
	changeIron2GM('incendiary-landmine-grenade-capsule-ammo-rampant-arsenal', 2)
	-- changeIron2GM('bio-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('he-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('incendiary-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('toxic-capsule-rampant-arsenal', 1)
	changeIron2GM('paralysis-capsule-rampant-arsenal', 3)

	recipe = combat.ammo.cannon.bio
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, combat.capsule.toxic, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, combat.ammo.cannon.explosive, 1)

	changeIron2Steel(combat.ammo.cannon.he, 1)
	changeIron2Steel(combat.ammo.cannon.incendiary, 1)
	apm.lib.utils.recipe.ingredient.replace(combat.ammo.cannon.incendiary, fluids.oil.light, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.mod(combat.ammo.cannon.incendiary, fluids.napalm, 40)

	apm.lib.utils.recipe.ingredient.replace(combat.ammo.shotgun.incendiary, fluids.oil.light, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.replace(combat.ammo.shotgun.incendiary, fluids.oil.heavy, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.mod(combat.ammo.shotgun.incendiary, fluids.napalm, 5)

	apm.lib.utils.recipe.ingredient.replace(combat.grenade.incendiary, fluids.oil.light, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.replace(combat.grenade.incendiary, fluids.oil.heavy, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.mod(combat.grenade.incendiary, fluids.napalm, 20)

	apm.lib.utils.recipe.ingredient.replace(combat.projectiles.bullet.flame, fluids.oil.light, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.replace(combat.projectiles.bullet.flame, fluids.oil.heavy, fluids.napalm, 1)
	apm.lib.utils.recipe.ingredient.mod(combat.projectiles.bullet.flame, fluids.napalm, 5)

	apm.lib.utils.recipe.ingredient.remove_all(combat.capsule.fire)
	apm.lib.utils.recipe.ingredient.mod(combat.capsule.fire, fluids.napalm, 50)
	apm.lib.utils.recipe.ingredient.mod(combat.capsule.fire, materials.plastic, 3)
	apm.lib.utils.recipe.ingredient.mod(combat.capsule.fire, alloy.gunmetal, 3)

	recipe = 'plasma-rocket-warhead'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.fusion.catalyst, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, fluids.deuterium, 200)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 1)

	recipe = 'bob-plasma-rocket'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.rocket, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'plasma-rocket-warhead', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'rocket-body', 1)

	recipe = 'plasma-bullet-projectile'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.fusion.catalyst, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, fluids.deuterium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.PU, 2)

	recipe = 'shotgun-plasma-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, nuclear.fusion.catalyst, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, fluids.deuterium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, alloys.titanium, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, product.chemistry.cordite, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'shotgun-shell-casing', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, logic.PU, 2)

	recipe = 'land-mine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, plates.iron, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, combat.grenade.base, 2)

	buildLaserTurret()
	buildCanonTurret()
	buildRocketTurret()
	buildFlameTurrets()
	--
	buildSolarPanel('solar-panel-equipment', apm.bob_rework.lib.tier.red, apm.bob_rework.lib.entities.glass,
		apm.bob_rework.lib.entities.silver)
	buildSolarPanel('solar-panel-equipment-2', apm.bob_rework.lib.tier.blue, apm.bob_rework.lib.entities.siliconWafer,
		apm.bob_rework.lib.entities.gold)
	--
	buildEqBurnerGen()
	buildEqReactors()
	buildPersonalRoboportsControl()
	--
	buildPersonalLaser('personal-laser-defense-equipment', apm.bob_rework.lib.tier.red, 'ruby-5')
	buildPersonalLaser('personal-laser-defense-equipment-2', apm.bob_rework.lib.tier.blue, 'sapphire-5')
	--
	buildExoskeleton('exoskeleton-equipment', apm.bob_rework.lib.tier.red)
	buildExoskeleton('exoskeleton-equipment-2', apm.bob_rework.lib.tier.blue)
	--
	buildPersonalRoboport('personal-roboport-equipment', apm.bob_rework.lib.tier.red, 1)
	buildPersonalRoboport('personal-roboport-mk2-equipment', apm.bob_rework.lib.tier.blue, 2)
	--
	buildNightvision('night-vision-equipment', apm.bob_rework.lib.tier.yellow, apm.bob_rework.lib.entities.glass)
	--

	updateWeapons()

	buffStackSizeForArtillery('cannon-shell')
	buffStackSizeForArtillery('explosive-cannon-shell')
	buffStackSizeForArtillery('bio-cannon-shell-ammo-rampant-arsenal')
	buffStackSizeForArtillery('he-cannon-shell-ammo-rampant-arsenal')
	buffStackSizeForArtillery('incendiary-cannon-shell-ammo-rampant-arsenal')
	buffStackSizeForArtillery('scatter-cannon-shell')
	buffStackSizeForArtillery('uranium-cannon-shell')
	buffStackSizeForArtillery('explosive-uranium-cannon-shell')
	buffStackSizeForArtillery('artillery-shell')
	buffStackSizeForArtillery('bio-artillery-ammo-rampant-arsenal')
	buffStackSizeForArtillery('he-artillery-ammo-rampant-arsenal')
	buffStackSizeForArtillery('incendiary-artillery-ammo-rampant-arsenal')
	buffStackSizeForArtillery('nuclear-artillery-ammo-rampant-arsenal')

	tuneAtomicBomb()

	local recipe = combat.ammo.shotgun.basic
	local turret = data.raw['ammo-turret'][recipe]
	if turret then
		turret.attack_parameters.damage_modifier = 3.5
	end
end

apm.bob_rework.lib.override.combat = function()
	drop()
	modify()
end
