if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local modify = function (recipe, tier, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'steel-chest', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.aluminium, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, count)
end

local buildDoor = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
end

local buildChargePad = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 2)
end

local build = function ()
    modify('roboport', apm.bob_rework.lib.tier.monel, 15)
    modify('bob-roboport-2', apm.bob_rework.lib.tier.steel, 15)
    modify('bob-roboport-3', apm.bob_rework.lib.tier.aluminium, 15)
    modify('bob-roboport-4', apm.bob_rework.lib.tier.titanium, 15)

    modify('bob-logistic-zone-expander', apm.bob_rework.lib.tier.monel, 5)
    modify('bob-logistic-zone-expander-2', apm.bob_rework.lib.tier.steel, 5)
    modify('bob-logistic-zone-expander-3', apm.bob_rework.lib.tier.aluminium, 5)
    modify('bob-logistic-zone-expander-4', apm.bob_rework.lib.tier.titanium, 5)

    modify('bob-robochest', apm.bob_rework.lib.tier.monel, 18)
    modify('bob-robochest-2', apm.bob_rework.lib.tier.steel, 18)
    modify('bob-robochest-3', apm.bob_rework.lib.tier.aluminium, 18)
    modify('bob-robochest-4', apm.bob_rework.lib.tier.titanium, 18)

    modify('bob-robo-charge-port', apm.bob_rework.lib.tier.monel, 10)
    modify('bob-robo-charge-port-2', apm.bob_rework.lib.tier.steel, 10)
    modify('bob-robo-charge-port-3', apm.bob_rework.lib.tier.aluminium, 10)
    modify('bob-robo-charge-port-4', apm.bob_rework.lib.tier.titanium, 10)

    modify('bob-robo-charge-port-large', apm.bob_rework.lib.tier.monel, 15)
    modify('bob-robo-charge-port-large-2', apm.bob_rework.lib.tier.steel, 15)
    modify('bob-robo-charge-port-large-3', apm.bob_rework.lib.tier.aluminium, 15)
    modify('bob-robo-charge-port-large-4', apm.bob_rework.lib.tier.titanium, 15)

    buildDoor('roboport-door-1', apm.bob_rework.lib.tier.monel)
    buildDoor('roboport-door-2', apm.bob_rework.lib.tier.steel)
    buildDoor('roboport-door-3', apm.bob_rework.lib.tier.aluminium)
    buildDoor('roboport-door-4', apm.bob_rework.lib.tier.titanium)

    buildChargePad('roboport-chargepad-1', apm.bob_rework.lib.tier.monel)
    buildChargePad('roboport-chargepad-2', apm.bob_rework.lib.tier.steel)
    buildChargePad('roboport-chargepad-3', apm.bob_rework.lib.tier.aluminium)
    buildChargePad('roboport-chargepad-4', apm.bob_rework.lib.tier.titanium)

    local prev, recipe = 'roboport', 'bob-roboport-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-roboport-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-roboport-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-logistic-zone-expander', 'bob-logistic-zone-expander-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-logistic-zone-expander-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-logistic-zone-expander-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robochest', 'bob-robochest-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robochest-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robochest-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robo-charge-port', 'bob-robo-charge-port-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	--
	prev, recipe = 'bob-robo-charge-port-large', 'bob-robo-charge-port-large-2'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-large-3'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
	prev = recipe
	recipe = 'bob-robo-charge-port-large-4'
	apm.lib.utils.recipe.ingredient.mod(recipe, prev, 0)
end

build()