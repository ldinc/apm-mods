if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildBurnerEGen = function ()
    local recipe = 'bob-burner-generator'
    local tier = apm.bob_rework.lib.tier.brass

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.copper, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.alloy, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.simpleEngineUnit, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 2)

    -- fix fuel_category
    local generator = data.raw['burner-generator'][recipe]
	local fc = apm.lib.utils.entity.get.fuel_categories('apm_steelworks_0')
	generator.burner.fuel_category = 'apm_refined_chemical'
	generator.burner.fuel_categories = fc
end

local buildSteamGenerator = function (recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steamEngineUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricGeneratorUnit, 1 *energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
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

apm.bob_rework.lib.override.electricGenerators = function ()
    buildBurnerEGen()
    --
    buildSteamGenerator('steam-engine', apm.bob_rework.lib.tier.brass, 2)
    buildSteamGenerator('steam-engine-2', apm.bob_rework.lib.tier.monel, 4)
    --
    buildFluidGenerator('fluid-generator', apm.bob_rework.lib.tier.monel, 5)
    --
    buildBoiler('boiler', apm.bob_rework.lib.tier.brass)
    --
    buildFluidBoiler('oil-boiler', 'boiler-2', apm.bob_rework.lib.tier.monel)
end