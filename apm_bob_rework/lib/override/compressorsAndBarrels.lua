if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local b = require('lib.entities.buildings.chemistry')
local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildCompressor = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.filter, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 2)
end

local buildBarrelling = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 2 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 2)

end

apm.bob_rework.lib.override.compressorsAndBarrels = function ()
    buildCompressor(b.compressor.basic, t.red)
    buildCompressor(b.compressor.advance, t.blue)

    buildBarrelling(b.pump.basic, t.red)
    buildBarrelling(b.pump.advance, t.blue)
end