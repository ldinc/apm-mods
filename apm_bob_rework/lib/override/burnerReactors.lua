if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.energy')

local buildBurnerReactor = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
end

local buildFluidBurnerReactor = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 5 + 3 * tier.level)
end

local fixFuelForHeatExhanger = function(recipe)
    local exchanger = data.raw['reactor'][recipe]
    -- local fc = apm.lib.utils.entity.get.fuel_categories('apm_steelworks_0')
    -- apm.bob_rework.lib.utils.debug.object(exchanger)
    -- exchanger.energy_source.fuel_category = 'apm_refined_chemical'
    -- exchanger.energy_source.fuel_categories = fc
    exchanger.energy_source.burnt_inventory_size = 1
end


apm.bob_rework.lib.override.burnerReactors = function()
    buildBurnerReactor(b.heat.source.burner, t.yellow)
    buildFluidBurnerReactor(b.heat.source.fluid, t.yellow)
    fixFuelForHeatExhanger(b.heat.source.burner)
end
