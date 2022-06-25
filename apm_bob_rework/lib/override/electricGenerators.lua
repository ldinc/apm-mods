if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildBurnerEGen = function()
    local recipe = 'bob-burner-generator'
    local tier = apm.bob_rework.lib.tier.yellow

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 9)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 6)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.simpleEngineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 2)

    -- fix fuel_category
    local generator = data.raw['burner-generator'][recipe]
    generator.burner.fuel_categories = { 'chemical', 'apm_refined_chemical' }
    generator.burner.burnt_inventory_size = 1
end

local buildSteamGenerator = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steamEngineUnit, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 9 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 7 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4 + 3 * tier.level)
end

local buildFluidGenerator = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 6 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 6 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 12 + 2 * tier.level)
end

local buildBoiler = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 2 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 5 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
end

local buildFluidBoiler = function(recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 3 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 2 + 2 * tier.level)
end

local buildTurbine = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8 + 4 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20 + 10 * tier.level)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 20)
    end
end

apm.bob_rework.lib.override.electricGenerators = function()
    buildBurnerEGen()
    --
    buildSteamGenerator('steam-engine', apm.bob_rework.lib.tier.steam, 2)
    buildSteamGenerator('steam-engine-2', apm.bob_rework.lib.tier.red, 4)
    buildSteamGenerator('steam-engine-3', apm.bob_rework.lib.tier.blue, 5)
    --
    buildFluidGenerator('fluid-generator', apm.bob_rework.lib.tier.red, 5)
    buildFluidGenerator('hydrazine-generator', apm.bob_rework.lib.tier.blue, 12)
    --
    buildBoiler('boiler', apm.bob_rework.lib.tier.steam)
    buildBoiler('boiler-2', apm.bob_rework.lib.tier.yellow)
    buildBoiler('boiler-3', apm.bob_rework.lib.tier.red)
    --
    buildFluidBoiler('oil-boiler', 'boiler-2', apm.bob_rework.lib.tier.yellow)
    buildFluidBoiler('oil-boiler-2', 'boiler-3', apm.bob_rework.lib.tier.red)
    --
    buildTurbine('steam-turbine', apm.bob_rework.lib.tier.red, 14)
end
