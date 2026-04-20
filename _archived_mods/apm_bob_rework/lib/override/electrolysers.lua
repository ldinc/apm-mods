if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local p = require('lib.entities.product')
local plate = require('lib.entities.plates')
local b = require('lib.entities.buildings.chemistry')

local buildElectrolyser = function(recipe, tier)
    local logic = tier.logic
    local silverCount = 6 + tier.level - 1

    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 9 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 4 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, plate.silver, silverCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, plate.copper, silverCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 2)

end

apm.bob_rework.lib.override.electrolysers = function()
    buildElectrolyser(b.electrolyser.yellow, t.yellow)
    buildElectrolyser(b.electrolyser.red, t.red)
    buildElectrolyser(b.electrolyser.blue, t.blue)
end
