if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')
-- require('lib.utils.debug')

local buildBurnerReactor = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10*tier.basementK)
end

local buildFluidBurnerReactor = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatProvider, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10*tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 5 + 3*tier.level)
end

local fixFuelForHeatExhanger = function (recipe)
    local exchanger = data.raw['reactor'][recipe]
    -- local fc = apm.lib.utils.entity.get.fuel_categories('apm_steelworks_0')
    -- apm.bob_rework.lib.utils.debug.object(exchanger)  
    -- exchanger.energy_source.fuel_category = 'apm_refined_chemical'
    -- exchanger.energy_source.fuel_categories = fc
    exchanger.energy_source.burnt_inventory_size = 1
end


apm.bob_rework.lib.override.burnerReactors = function ()
    buildBurnerReactor('burner-reactor', apm.bob_rework.lib.tier.yellow)
    -- buildBurnerReactor('burner-reactor-2', apm.bob_rework.lib.tier.aluminium)
    -- buildBurnerReactor('burner-reactor-3', apm.bob_rework.lib.tier.titanium)

    buildFluidBurnerReactor('fluid-reactor', apm.bob_rework.lib.tier.yellow)
    -- buildFluidBurnerReactor('fluid-reactor-2', apm.bob_rework.lib.tier.aluminium)
    -- buildFluidBurnerReactor('fluid-reactor-3', apm.bob_rework.lib.tier.titanium)    

    fixFuelForHeatExhanger('burner-reactor')
    -- fixFuelForHeatExhanger('burner-reactor-2')
    -- fixFuelForHeatExhanger('burner-reactor-3')
end