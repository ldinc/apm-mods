if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local l = require('lib.entities.buildings.labs')
local t = require('lib.tier.base')
local m = require('lib.entities.materials')

local buildLaboratoryRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    if tier.level > 0 then
        local inserter = tier.inserter
        apm.lib.utils.recipe.ingredient.mod(recipe, inserter, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    if tier.extraConstructionAlloy then
        local count = 20
        if tier.level == 1 then
            count = 15
        end
        if tier.level > 1 then
            count = 20
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 15 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level * 2 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, m.glass, 20)
end

apm.bob_rework.lib.override.laboratories = function()
    buildLaboratoryRecipe(l.burner, t.gray)
    buildLaboratoryRecipe(l.steam, t.steam)
    buildLaboratoryRecipe(l.basic, t.red)
    buildLaboratoryRecipe(l.advanced, t.blue)
end
