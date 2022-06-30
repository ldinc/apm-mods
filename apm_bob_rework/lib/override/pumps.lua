if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local pipes = require "lib.entities.pipes"
local plates = require "lib.entities.plates"
local product = require "lib.entities.product"
local offshore  = require "lib.entities.buildings.offshore"
local t = require('lib.tier.base')

local buildPumpRecipe = function(tier)
    local recipe = tier.pump
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level * 2 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 3)
end

local buildOffshore = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local alloy = plates.iron
    local pipe = pipes.iron
    if tier.level == 0 then
        alloy = tier.constructionAlloy
        pipe = tier.pipe
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
end

apm.bob_rework.lib.override.pumps = function()
    buildPumpRecipe(t.yellow)
    buildPumpRecipe(t.red)
    buildPumpRecipe(t.blue)

    buildOffshore(offshore.burner, apm.bob_rework.lib.tier.gray)
    buildOffshore(offshore.basic, apm.bob_rework.lib.tier.yellow)
end
