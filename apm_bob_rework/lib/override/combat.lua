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

    buildLaserTurret()
    buildShotgunTurret()
    buildCanonTurret()
    buildRocketTurret()

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

	-- --
	-- -- genGunTurrets()
	-- --
	-- -- genLasers()
	-- --

	-- --
	-- genSniperTurrets()
	-- recipe = 'suppression-cannon-item-rampant-arsenal'
	-- apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 20)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 20)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, logic2, 0)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, logic3, 30)
	-- recipe = 'capsule-item-rampant-arsenal'
	-- apm.lib.utils.recipe.ingredient.mod(recipe, steelB, 10)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, steelG, 10)
	-- apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
end

apm.bob_rework.lib.override.combat = function ()
    drop()
    modify()
end

apm.bob_rework.lib.override.combat()