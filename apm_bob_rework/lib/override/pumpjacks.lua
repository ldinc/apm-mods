if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local pjacks = require "lib.entities.buildings.pumpjacks"
local product = require "lib.entities.product"
local t = require('lib.tier.base')

local buildPumpjack = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then 
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*2)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 6 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 6 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 20 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.engine.electric, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.stick, 12)
end

local next = function (target, next_upgrade)
    local itm = data.raw["mining-drill"][target]
    if itm then itm.next_upgrade = next_upgrade end
end

apm.bob_rework.lib.override.pumpjacks = function ()
    buildPumpjack(pjacks.basic, t.red)
    buildPumpjack(pjacks.advanced, t.blue)

    next(pjacks.burner, pjacks.basic)
    next(pjacks.basic, pjacks.advanced)
end