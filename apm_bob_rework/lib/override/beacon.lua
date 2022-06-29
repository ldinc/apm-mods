if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local b = require('lib.entities.buildings.beacons')
local tier = require('lib.tier.base')

local gen = function(name, t, count)
    apm.lib.utils.recipe.ingredient.remove_all(name)
    apm.lib.utils.recipe.ingredient.mod(name, t.frame, count)
    apm.lib.utils.recipe.ingredient.mod(name, t.wire, count * 4)
    apm.lib.utils.recipe.ingredient.mod(name, t.logic, 20)
    if t.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(name, t.extraLogic, 20)
    end
    apm.lib.utils.recipe.ingredient.mod(name, t.constructionAlloy, 5)
end

apm.bob_rework.lib.override.beacon = function()
    gen(b.basic, tier.red, 9)
    gen(b.extra, tier.blue, 16)
end
