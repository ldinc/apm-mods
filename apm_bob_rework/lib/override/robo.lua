local plates   = require "lib.entities.plates"
local storages = require "lib.entities.buildings.storages"
local alloys   = require "lib.entities.alloys"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

local modify = function(recipe, tier, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, storages.chest.steel, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.aluminium, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.titanium, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.siliconNitride, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, count)
end

local buildDoor = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 20)
end

local buildChargePad = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.battery, 2)
end

local buildToolCombat = function(recipe, tier)
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

local buildToolConstruction = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
end

local buildToolLogistic = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
end

local build = function()
    modify('roboport', t.red, 40)
    modify('bob-roboport-2', t.blue, 60)

    modify('bob-logistic-zone-expander', t.red, 5)
    modify('bob-logistic-zone-expander-2', t.blue, 5)

    modify('bob-robochest', t.red, 18)
    modify('bob-robochest-2', t.blue, 18)

    modify('bob-robo-charge-port', t.red, 10)
    modify('bob-robo-charge-port-2', t.blue, 10)

    modify('bob-robo-charge-port-large', t.red, 15)
    modify('bob-robo-charge-port-large-2', t.blue, 15)

    modify('flying-robot-frame', t.red, 1)
    modify('flying-robot-frame-2', t.blue, 1)

    buildDoor('roboport-door-1', t.red)
    buildDoor('roboport-door-2', t.blue)

    buildChargePad('roboport-chargepad-1', t.red)
    buildChargePad('roboport-chargepad-2', t.blue)

    buildToolCombat('robot-tool-combat', t.red)
    buildToolCombat('robot-tool-combat-2', t.blue)

    buildToolConstruction('robot-tool-construction', t.red)
    buildToolConstruction('robot-tool-construction-2', t.blue)

    buildToolLogistic('robot-tool-logistic', t.red)
    buildToolLogistic('robot-tool-logistic-2', t.blue)

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
