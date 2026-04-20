local energy = require "lib.entities.energy"
local alloys = require "lib.entities.alloys"
local pipes  = require "lib.entities.pipes"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

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
    exchanger.energy_source.burnt_inventory_size = 1
end


apm.bob_rework.lib.override.burnerReactors = function()
    buildBurnerReactor(energy.heat.source.burner, t.yellow)
    buildFluidBurnerReactor(energy.heat.source.fluid, t.yellow)
    fixFuelForHeatExhanger(energy.heat.source.burner)

    local recipe = ''
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function(itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end

    recipe = energy.heat.exchanger
    clear()
    add(energy.boiler.advance, 1)
    add(alloys.monel, 10)
    add(energy.heat.pipe.basic, 10)
    add(pipes.base.copper, 8)
end
