if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildOverdriveMotor = function (recipe, tier, k)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 15*k)

end

local buildCar = function (recipe, tier, engine, count)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, count)
end

local buildTank = function (recipe, tier, engine, count)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, count)
end

local update = function ()
    buildOverdriveMotor('vehicle-motor', apm.bob_rework.lib.tier.red, 1)
    buildOverdriveMotor('vehicle-engine', apm.bob_rework.lib.tier.blue, 2)
    buildCar('car', apm.bob_rework.lib.tier.yellow, apm.bob_rework.lib.entities.engineUnit, 1)
    buildCar('apm_electric_car', apm.bob_rework.lib.tier.red, apm.bob_rework.lib.entities.electricEngineUnit, 4)
    --
    buildTank('tank', apm.bob_rework.lib.tier.red, apm.bob_rework.lib.entities.engineUnit, 32)
    buildTank('apm_electric_tank', apm.bob_rework.lib.tier.red, apm.bob_rework.lib.entities.electricEngineUnit, 32)
    -- buildTank('bob-tank-2', apm.bob_rework.lib.tier.aluminium, apm.bob_rework.lib.entities.engineUnit, 42)
    -- buildTank('apm_electric_bob-tank-2', apm.bob_rework.lib.tier.aluminium, apm.bob_rework.lib.entities.electricEngineUnit, 42)
    -- buildTank('bob-tank-3', apm.bob_rework.lib.tier.titanium, apm.bob_rework.lib.entities.engineUnit, 50)
    -- buildTank('apm_electric_bob-tank-3', apm.bob_rework.lib.tier.titanium, apm.bob_rework.lib.entities.electricEngineUnit, 50)
end

update()