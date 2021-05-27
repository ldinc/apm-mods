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
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicAdvanced, 25)
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
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.brass.logic, 5)
end

local buildCanonTurret = function ()
    local recipe = 'cannon-item-rampant-arsenal'
    local tier = apm.bob_rework.lib.tier.steel
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50)
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
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 15)
    
    local recipe = 'rapid-rocket-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 40)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.engineUnit, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 30)
end

local genArtillery = function (recipe, tier)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 100)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 50)
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

local buildGunTurret = function(recipe, tier, extraGlass)
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
	if extraGlass then
		apm.lib.utils.recipe.ingredient.mod(recipe, tier.glass, 10)	
	end
end

local buildGunTurrets = function ()
    buildGunTurret('gun-turret', apm.bob_rework.lib.tier.bronze, false)
    buildGunTurret('bob-gun-turret-2', apm.bob_rework.lib.tier.brass, false)
    buildGunTurret('bob-gun-turret-3', apm.bob_rework.lib.tier.monel, false)
    buildGunTurret('bob-gun-turret-4', apm.bob_rework.lib.tier.steel, false)
    buildGunTurret('bob-gun-turret-5', apm.bob_rework.lib.tier.aluminium, false)

    buildGunTurret('bob-sniper-turret-1', apm.bob_rework.lib.tier.monel, true)
    buildGunTurret('bob-sniper-turret-2', apm.bob_rework.lib.tier.steel, true)
    buildGunTurret('bob-sniper-turret-3', apm.bob_rework.lib.tier.titanium, true)
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
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.engineUnit, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.monel.logic, 8)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.monel.wire, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)

	local recipe = 'apm_equipment_burner_generator_advanced'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_equipment_burner_generator_basic', 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.monel.wire, 6)
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
	apm.lib.utils.recipe.ingredient.mod(recipe, optics, 1)
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

local changeIron2GM = function (recipe, count)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, count)
end

local updateWeapons = function ()
	local recipe = 'pistol'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tin, 6)

	local recipe = 'submachine-gun'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tin, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.wood, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironGearWheel, 5)

	local recipe = 'shotgun'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tin, 12)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.wood, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironGearWheel, 10)
end

local modify = function ()
	local recipe = 'cordite'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'gun-cotton', 6)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'nitroglycerin', 25)

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
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 25)
	local recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.explosives, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 4)

	local recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.explosives, 1)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 4)

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

	local recipe = 'firearm-magazine'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.lead, 5)

	local recipe = 'cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 2)

	local recipe = 'explosive-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)

	local recipe = 'scatter-cannon-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 2)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.plastic, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.cordite, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 1)

	local recipe = 'artillery-shell'
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunMetal, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 0)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungsten, 15)

	local recipe = 'atomic-bomb'
	apm.lib.utils.recipe.ingredient.mod(recipe, 'rocket-body', 1)

	local recipe = 'grenade'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunPowder, 40)

	local recipe = 'rifle-item-rampant-arsenal'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.bronze, 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tin, 15)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.wood, 5)
	apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.tier.bronze.logic, 2)




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
	changeIron2GM('bio-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('he-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('incendiary-cannon-shell-ammo-rampant-arsenal', 0)
	changeIron2GM('toxic-capsule-rampant-arsenal', 1)
	changeIron2GM('paralysis-capsule-rampant-arsenal', 3)

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
	buildPersonalLaser('personal-laser-defense-equipment', apm.bob_rework.lib.tier.monel, apm.bob_rework.lib.entities.glass)
	buildPersonalLaser('personal-laser-defense-equipment-2', apm.bob_rework.lib.tier.monel, 'ruby-5')
	buildPersonalLaser('personal-laser-defense-equipment-3', apm.bob_rework.lib.tier.steel, 'emerald-5')
	buildPersonalLaser('personal-laser-defense-equipment-4', apm.bob_rework.lib.tier.aluminium, 'amethyst-5')
	buildPersonalLaser('personal-laser-defense-equipment-5', apm.bob_rework.lib.tier.aluminium, 'topaz-5')
	buildPersonalLaser('personal-laser-defense-equipment-6', apm.bob_rework.lib.tier.titanium, 'diamond-5')
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

	updateWeapons()

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