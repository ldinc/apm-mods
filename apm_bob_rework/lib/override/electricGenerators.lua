if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildBurnerEGen = function ()
    local recipe = 'bob-burner-generator'
    local tier = apm.bob_rework.lib.tier.brass

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 5)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.simpleEngineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 2)

    -- fix fuel_category
    local generator = data.raw['burner-generator'][recipe]
	generator.burner.fuel_categories = {'chemical','apm_refined_chemical'}
	generator.burner.burnt_inventory_size = 1
end

local buildSteamGenerator = function (recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steamEngineUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
end

local buildFluidGenerator = function (recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
end

local buildBoiler = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10*tier.basementK)
end

local buildFluidBoiler = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 4)
end

local buildTurbine = function (recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 16 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 10 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 40)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 20)
    end
end

apm.bob_rework.lib.override.electricGenerators = function ()
    buildBurnerEGen()
    --
    buildSteamGenerator('steam-engine', apm.bob_rework.lib.tier.brass, 2)
    buildSteamGenerator('steam-engine-2', apm.bob_rework.lib.tier.monel, 4)
    buildSteamGenerator('steam-engine-3', apm.bob_rework.lib.tier.steel, 5)
    buildSteamGenerator('steam-engine-4', apm.bob_rework.lib.tier.aluminium, 7)
    buildSteamGenerator('steam-engine-5', apm.bob_rework.lib.tier.titanium, 8)
    --
    buildFluidGenerator('fluid-generator', apm.bob_rework.lib.tier.monel, 5)
    buildFluidGenerator('fluid-generator-2', apm.bob_rework.lib.tier.steel, 7)
    buildFluidGenerator('fluid-generator-3', apm.bob_rework.lib.tier.aluminium, 9)
    buildFluidGenerator('hydrazine-generator', apm.bob_rework.lib.tier.titanium, 12)
    --
    buildBoiler('boiler', apm.bob_rework.lib.tier.brass)
    buildBoiler('boiler-2', apm.bob_rework.lib.tier.monel)
    buildBoiler('boiler-3', apm.bob_rework.lib.tier.steel)
    buildBoiler('boiler-4', apm.bob_rework.lib.tier.aluminium)
    buildBoiler('boiler-5', apm.bob_rework.lib.tier.titanium)
    --
    buildFluidBoiler('oil-boiler', 'boiler-2', apm.bob_rework.lib.tier.monel)
    buildFluidBoiler('oil-boiler-2', 'boiler-3', apm.bob_rework.lib.tier.steel)
    buildFluidBoiler('oil-boiler-3', 'boiler-4', apm.bob_rework.lib.tier.aluminium)
    buildFluidBoiler('oil-boiler-4', 'boiler-5', apm.bob_rework.lib.tier.titanium)
    --
    buildTurbine('steam-turbine', apm.bob_rework.lib.tier.steel, 14)
    buildTurbine('steam-turbine-2', apm.bob_rework.lib.tier.aluminium, 18)
    buildTurbine('steam-turbine-3', apm.bob_rework.lib.tier.titanium, 23)
end