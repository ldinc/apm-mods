if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildBelts = function(tier)
    local recipe = ''
    local clear = function () apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function (itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end

    recipe = tier.belt
    clear()
    add(tier.gearWheel, 1)
    add(tier.bearing, 2)
    add(tier.constructionAlloy, 1)
    add(p.rubber, 2)

    recipe = tier.underBelt
    clear()
    add(tier.belt, 5)
    add(tier.constructionAlloy, 2)

    recipe = tier.splitter
    clear()
    add(tier.belt, 2)
    add(tier.constructionAlloy, 1)
    add(tier.gearWheel, 2)
    add(tier.logic, 1)


    recipe = tier.loader
    if recipe then
        clear()
        add(tier.belt, 1)
        add(tier.constructionAlloy, 1)
        add(tier.logic, 1)
    end
end

local buildStacker = function (tier)
    local recipe = tier.stacker
    local clear = function () apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function (itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end
    clear()
    add(tier.constructionAlloy, 10)
    add(tier.gearWheel, 4)
    add(tier.belt, 2)
    add(tier.logic, 2)
end

apm.bob_rework.lib.override.belts = function()
    buildBelts(t.gray)
    buildBelts(t.yellow)
    buildBelts(t.red)
    buildBelts(t.blue)

    buildStacker(t.yellow)
    buildStacker(t.red)
    buildStacker(t.blue)
end
