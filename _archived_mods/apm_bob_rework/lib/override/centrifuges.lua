if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local b = require('lib.entities.buildings.centrifuges')
local nuclear = require('lib.entities.buildings.nuclear')
local t = require('lib.tier.base')
local p = require('lib.entities.product')
local plate = require('lib.entities.plates')

local buildCentrifugeRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3 * tier.level)
    if tier.extraConstructionAlloy then
        local count = 8
        if tier.level == 1 then
            count = 10
        end
        if tier.level > 1 then
            count = 12
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 5 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 4 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5)
end

local buildNuclearCentrifuge = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 9)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, plate.lead, tier.level * 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 100 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 50 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 100 + 10 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 40 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 50 + 20 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 100 + 10 * tier.level)
end

apm.bob_rework.lib.override.centrifuges = function()
    buildCentrifugeRecipe(b.burner, t.gray)
    buildCentrifugeRecipe(b.steam, t.steam)
    buildCentrifugeRecipe(b.basic, t.red)
    --
    buildNuclearCentrifuge(nuclear.centrifuge, t.red)
end
