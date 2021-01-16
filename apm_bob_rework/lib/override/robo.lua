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

local buildToolCombat = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
    if tier.level == 2 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'ruby-5', 1)
    end
    if tier.level == 3 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'emerald-5', 1)
    end
    if tier.level == 4 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'topaz-5', 1)
    end
    if tier.level == 5 then
        apm.lib.utils.recipe.ingredient.mod(recipe, 'diamond-5', 1)
    end
end

local buildToolConstruction = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
end

local buildToolLogistic= function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
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

    buildToolCombat('robot-tool-combat', apm.bob_rework.lib.tier.monel)
    buildToolCombat('robot-tool-combat-2', apm.bob_rework.lib.tier.steel)
    buildToolCombat('robot-tool-combat-3', apm.bob_rework.lib.tier.aluminium)
    buildToolCombat('robot-tool-combat-4', apm.bob_rework.lib.tier.titanium)

    buildToolConstruction('robot-tool-construction', apm.bob_rework.lib.tier.monel)
    buildToolConstruction('robot-tool-construction-2', apm.bob_rework.lib.tier.steel)
    buildToolConstruction('robot-tool-construction-3', apm.bob_rework.lib.tier.aluminium)
    buildToolConstruction('robot-tool-construction-4', apm.bob_rework.lib.tier.titanium)

    buildToolLogistic('robot-tool-logistic', apm.bob_rework.lib.tier.monel)
    buildToolLogistic('robot-tool-logistic-2', apm.bob_rework.lib.tier.steel)
    buildToolLogistic('robot-tool-logistic-3', apm.bob_rework.lib.tier.aluminium)
    buildToolLogistic('robot-tool-logistic-4', apm.bob_rework.lib.tier.titanium)

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