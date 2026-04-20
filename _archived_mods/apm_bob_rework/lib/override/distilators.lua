if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.chemistry')
local p = require('lib.entities.product')
local m = require('lib.entities.materials')

local buildDistilator = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 3 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 6 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, m.glass, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.filter, 9)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1 + tier.level)
end

apm.bob_rework.lib.override.distilators = function()
    buildDistilator(b.distillery.yellow, t.yellow)
    buildDistilator(b.distillery.red, t.red)
    buildDistilator(b.distillery.blue, t.blue)
end
