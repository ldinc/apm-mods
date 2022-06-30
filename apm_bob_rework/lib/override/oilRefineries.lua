if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.chemistry')

local buildOilRefinery = function (recipe, tier, compressor)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 3 + tier.level*2)
    apm.lib.utils.recipe.ingredient.mod(recipe, compressor, tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level * 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20 + 10*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 8 + 4*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 10 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10 + 4*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 10)
end

apm.bob_rework.lib.override.oilRefineries = function ()
    buildOilRefinery(b.oil.refinery.basic, t.red, b.compressor.basic)
    buildOilRefinery(b.oil.refinery.advanced, t.blue, b.compressor.advance)
end