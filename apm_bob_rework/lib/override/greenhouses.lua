if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local g = require('lib.entities.buildings.greenhouses')
local t = require('lib.tier.base')
local m = require('lib.entities.materials')
local p = require('lib.entities.product')

local buildGreenhousesRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 6)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    if tier.extraConstructionAlloy then
        local count = 20
        if tier.level == 1 then
            count = 8
        end
        if tier.level > 1 then
            count = 12
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, m.glass, 25 + 5 * tier.level)
    if tier.level >= 2 then
        apm.lib.utils.recipe.ingredient.mod(recipe, p.lamp, 14)
    end
end

apm.bob_rework.lib.override.greenhouses = function()
    buildGreenhousesRecipe(g.burner, t.gray)
    buildGreenhousesRecipe(g.steam, t.steam)
    buildGreenhousesRecipe(g.basic, t.red)
end
