if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local drop = function ()
    local rm = apm.lib.utils.recipe.remove

	rm('bio-magazine-ammo-rampant-arsenal')
	rm('he-magazine-ammo-rampant-arsenal')
	rm('incendiary-magazine-ammo-rampant-arsenal')
	rm('bio-shotgun-ammo-rampant-arsenal')
	rm('he-shotgun-ammo-rampant-arsenal')
	rm('incendiary-shotgun-ammo-rampant-arsenal')
	rm('uranium-shotgun-ammo-rampant-arsenal')
	rm('bio-rocket-ammo-rampant-arsenal')
	rm('he-rocket-ammo-rampant-arsenal')
	rm('incendiary-rocket-ammo-rampant-arsenal')
	rm('rocket')
	rm('explosive-rocket')
	rm('bob-electric-rocket')
	rm('electric-bullet-magazine')
	rm('electric-bullet')
	rm('electric-bullet-projectile')
	rm('plasma-bullet')
	rm('plasma-bullet-projectile')
	rm('plasma-rocket-warhead')
	rm('electric-rocket-warhead')
	rm('shotgun-electric-shell')
	rm('plasma-bullet-magazine')
	rm('plasma-rocket')
	rm('shotgun-plasma-shell')
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
end

local buildLaserTurret = function ()
    local recipe = 'laser-turret'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'ruby-5', 1)
    local prev = recipe
    recipe = 'bob-laser-turret-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.battery, 12)
    prev = recipe
    recipe = 'bob-laser-turret-3'
    apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
    prev = recipe
    recipe = 'bob-laser-turret-4'
    apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
    prev = recipe
    recipe = 'bob-laser-turret-5'
    apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungstenCarbide, 20)

    local recipe = 'advanced-laser-item-rampant-arsenal'
    local tier = apm.bob_rework.lib.tier.titanium

	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 60)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'diamond-5', 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'large-accumulator-3', 20)
end

local buildShotgunTurret = function ()
    local recipe = 'shotgun-item-rampant-arsenal'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassBearing, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.brassGearWheel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.brass.constructionAlloy, 15)
end

local buildCanonTurret = function ()
    local recipe = 'cannon-item-rampant-arsenal'
    local tier = apm.bob_rework.lib.tier.steel
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 100)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.engineUnit, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
end

local buildRocketTurret = function ()
    local recipe = 'rocket-item-rampant-arsenal'
    local tier = apm.bob_rework.lib.tier.steel
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 15)
    
    local recipe = 'rapid-rocket-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.engineUnit, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
end

local genArtillery = function (recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 60)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 30)
    end
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 50*tier.level)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.engineUnit, 20 + 20*tier.level)
end

local buildArtillery = function ()
    genArtillery('artillery-turret', apm.bob_rework.lib.tier.steel)
    genArtillery('bob-artillery-turret-2', apm.bob_rework.lib.tier.aluminium)
    genArtillery('bob-artillery-turret-3', apm.bob_rework.lib.tier.titanium)
end

local buildGunTurret = function(recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 10)
end

local buildGunTurrets = function ()
    buildGunTurret('gun-turret', apm.bob_rework.lib.tier.brass)
    buildGunTurret('bob-gun-turret-2', apm.bob_rework.lib.tier.monel)
    buildGunTurret('bob-gun-turret-3', apm.bob_rework.lib.tier.steel)
    buildGunTurret('bob-gun-turret-4', apm.bob_rework.lib.tier.aluminium)
    buildGunTurret('bob-gun-turret-5', apm.bob_rework.lib.tier.titanium)

    buildGunTurret('bob-sniper-turret-1', apm.bob_rework.lib.tier.monel)
    buildGunTurret('bob-sniper-turret-2', apm.bob_rework.lib.tier.steel)
    buildGunTurret('bob-sniper-turret-3', apm.bob_rework.lib.tier.titanium)
end

local buildSolarPanel = function (recipe, tier, shell, conduct)
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

local buildEqBurnerGen = function ()
	local recipe = 'apm_equipment_burner_generator_basic'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.monel.logic, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.monel.wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)

	local recipe = 'apm_equipment_burner_generator_advanced'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.aluminium.logic, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.aluminium.wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)
end

local buildFusionReactorEq = function (recipe, level)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 30+20*level)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicProcessing, 100 + 50*level)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicAPU, 100 + 50*level)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lowDS, 30 + 20*level)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 10 + 5*level)
end

local buildEqReactors = function ()
	buildFusionReactorEq('fusion-reactor-equipment', 1)
	buildFusionReactorEq('fusion-reactor-equipment-2', 2)
	buildFusionReactorEq('fusion-reactor-equipment-3', 3)
	buildFusionReactorEq('fusion-reactor-equipment-4', 4)
	local recipe = 'nuclear-generator-rampant-arsenal'
	buildFusionReactorEq(recipe, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.heatPipe_t3, 20)
end

local buildPersonalLaser = function (recipe, tier, optics)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.optics, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 3)
end

local buildExoskeleton = function (recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, 5*tier.level)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 30)
end

local buildPersonalRoboport = function (recipe, level)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	local antenna = 'roboport-antenna-' .. tostring(level)
	local hatch = 'roboport-door-' .. tostring(level)
	apm.lib.utils.recipe.ingredient.mod(recipe, antenna, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, hatch, 1)
end

local buildPersonalChargePad = function (recipe, level)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	local pad = 'roboport-chargepad-' .. tostring(level)
	apm.lib.utils.recipe.ingredient.mod(recipe, pad, 2)
end

local buildPersonalRoboportsControl = function ()
	local recipe = 'personal-roboport-robot-equipment-2'
	local prev = 'personal-roboport-robot-equipment'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'module-case', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 5)

	prev = recipe
	recipe = 'personal-roboport-robot-equipment-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'module-case', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 5)

	prev = recipe
	recipe = 'personal-roboport-robot-equipment-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'module-case', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 5)
end

local buildPersonalRoboport = function (recipe, tier, level)
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

local buildNightvision = function (recipe, tier, optics)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, optics, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 5)
end

local modify = function ()
    local recipe = 'piercing-rounds-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunPowder, 5)
    
	local recipe = 'firearm-magazine'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunPowder, 5)

    local recipe = 'apm_ammonium_sulfate_chem'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_coal_saturated_wastewater', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'ammonia', 15)

	local recipe = 'shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunPowder, 5)
	local recipe = 'piercing-shotgun-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 3)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_gun_powder', 5)

	local recipe = 'artillery-shell'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungsten, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 50)
	local recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.explosives, 0)
	local recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.explosives, 1)

    local recipe = 'nuclear-generator-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'fusion-reactor-equipment-2', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'nuclear-reactor', 1)

	local recipe = 'capsule-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelBearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelGearWheel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.explosives, 0)

	local recipe = 'mech-leg-segment'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titaniumPipe, 10)

	local recipe = 'vehicle-solar-panel-5'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
	local recipe = 'vehicle-solar-panel-6'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)

	local recipe = 'vehicle-fusion-reactor-1'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 50)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_depleted_uranium_ingots', 10)

	local recipe = 'vehicle-big-turret-5'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
	local recipe = 'vehicle-big-turret-6'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)

	local recipe = 'vehicle-laser-defense-5'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
	local recipe = 'vehicle-laser-defense-6'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)

	local recipe = 'vehicle-roboport-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)



    buildLaserTurret()
    buildShotgunTurret()
    buildCanonTurret()
    buildRocketTurret()
    buildArtillery()
	buildGunTurrets()
	--
	buildSolarPanel('solar-panel-equipment', apm.bob_rework.lib.tier.monel, apm.bob_rework.lib.entities.glass, apm.bob_rework.lib.entities.copper)
	buildSolarPanel('solar-panel-equipment-2', apm.bob_rework.lib.tier.steel, apm.bob_rework.lib.entities.glass, apm.bob_rework.lib.entities.silver)
	buildSolarPanel('solar-panel-equipment-3', apm.bob_rework.lib.tier.aluminium, apm.bob_rework.lib.entities.siliconWafer, apm.bob_rework.lib.entities.gold)
	buildSolarPanel('solar-panel-equipment-4', apm.bob_rework.lib.tier.titanium, apm.bob_rework.lib.entities.siliconWafer, apm.bob_rework.lib.entities.gold)
	--
	buildEqBurnerGen()
	buildEqReactors()
	buildPersonalRoboportsControl()
	--
	buildPersonalLaser('personal-laser-defence-equipment', apm.bob_rework.lib.tier.monel, apm.bob_rework.lib.entities.glass)
	buildPersonalLaser('personal-laser-defence-equipment-2', apm.bob_rework.lib.tier.monel, 'ruby-5')
	buildPersonalLaser('personal-laser-defence-equipment-3', apm.bob_rework.lib.tier.steel, 'emerald-5')
	buildPersonalLaser('personal-laser-defence-equipment-4', apm.bob_rework.lib.tier.aluminium, 'amethyst-5')
	buildPersonalLaser('personal-laser-defence-equipment-5', apm.bob_rework.lib.tier.aluminium, 'topaz-5')
	buildPersonalLaser('personal-laser-defence-equipment-6', apm.bob_rework.lib.tier.titanium, 'diamond-5')
	--
	buildExoskeleton('exoskeleton-equipment', apm.bob_rework.lib.tier.monel)
	buildExoskeleton('exoskeleton-equipment-2', apm.bob_rework.lib.tier.aluminium)
	buildExoskeleton('exoskeleton-equipment-3', apm.bob_rework.lib.tier.titanium)
	--
	buildPersonalRoboport('personal-roboport-antenna-equipment', apm.bob_rework.lib.tier.monel, 1)
	buildPersonalRoboport('personal-roboport-antenna-equipment-2', apm.bob_rework.lib.tier.steel, 2)
	buildPersonalRoboport('personal-roboport-antenna-equipment-3', apm.bob_rework.lib.tier.aluminium, 3)
	buildPersonalRoboport('personal-roboport-antenna-equipment-4', apm.bob_rework.lib.tier.titanium, 4)
	--
	buildPersonalChargePad('personal-roboport-chargepad-equipment', 1)
	buildPersonalChargePad('personal-roboport-chargepad-equipment-2', 2)
	buildPersonalChargePad('personal-roboport-chargepad-equipment-3', 3)
	buildPersonalChargePad('personal-roboport-chargepad-equipment-4', 4)
	--
	buildPersonalRoboport('personal-roboport-equipment', apm.bob_rework.lib.tier.monel, 1)
	buildPersonalRoboport('personal-roboport-mk2-equipment', apm.bob_rework.lib.tier.steel, 2)
	buildPersonalRoboport('personal-roboport-mk3-equipment', apm.bob_rework.lib.tier.aluminium, 3)
	buildPersonalRoboport('personal-roboport-mk4-equipment', apm.bob_rework.lib.tier.titanium, 4)
	--
	buildNightvision('night-vision-equipment', apm.bob_rework.lib.tier.monel, apm.bob_rework.lib.entities.glass)
	buildNightvision('night-vision-equipment-2', apm.bob_rework.lib.tier.aluminium, 'topaz-5')
	buildNightvision('night-vision-equipment-3', apm.bob_rework.lib.tier.titanium, 'diamond-5')
	--

	-- -- disable tech
	-- apm.lib.utils.technology.delete('bob-fire-artillery-shells')
	-- apm.lib.utils.technology.delete('bob-posion-artillery-shells')
	-- apm.lib.utils.technology.delete('bob-explosive-artillery-shells')
	-- apm.lib.utils.technology.delete('bob-distractor-artillery-shells')
	-- apm.lib.utils.technology.delete('bob-plasma-bullets')
	-- apm.lib.utils.technology.delete('bob-plasma-rocket')
	-- apm.lib.utils.technology.delete('bob-electric-bullets')
	-- apm.lib.utils.technology.delete('bob-electric-rocket')
	-- apm.lib.utils.technology.delete('bob-shotgun-electric-shells')
	-- apm.lib.utils.technology.delete('bob-shotgun-plasma-shells')
	-- apm.lib.utils.technology.delete('bob-shotgun-plasma-shells')
	-- apm.lib.utils.technology.delete('bob-plasma-turrets-1')
    -- --
    
	-- genSniperTurrets()
end

apm.bob_rework.lib.override.combat = function ()
    drop()
    modify()
end

apm.bob_rework.lib.override.combat()