local product = require "lib.entities.product"
local plates  = require "lib.entities.plates"
local alloys  = require "lib.entities.alloys"
local logic   = require "lib.entities.logic"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildBelts = function(tier)
    local recipe = ''
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function(itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end

    local isExpensive = tier ~= t.gray

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

local buildStacker = function(tier)
    local recipe = tier.stacker
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function(itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end
    clear()
    add(tier.constructionAlloy, 10)
    add(tier.gearWheel, 4)
    add(tier.belt, 2)
    add(tier.logic, 2)
end

local cloneYellow = function()
    local prefix = 'steam-'

    local target = t.steam.splitter
    local name = prefix .. target

    local recipe = table.deepcopy(data.raw.recipe[target])
    recipe.name = name
    data:extend({ recipe })

    apm.lib.utils.recipe.ingredient.remove_all(name)
    apm.lib.utils.recipe.ingredient.mod(name, t.steam.belt, 2)
    apm.lib.utils.recipe.ingredient.mod(name, product.gearwheel.brass, 2)
    apm.lib.utils.recipe.ingredient.mod(name, alloys.brass, 1)
    apm.lib.utils.recipe.ingredient.mod(name, logic.steam, 1)

    apm.lib.utils.technology.add.recipe_for_unlock('logistics', name)
    apm.lib.utils.technology.remove.recipe_from_unlock('logistics', target)
    apm.lib.utils.technology.add.recipe_for_unlock('electronics', target)

    -- target = t.steam.loader
    -- name = prefix .. target

    -- recipe = table.deepcopy(data.raw.recipe[target])
    -- recipe.name = name
    -- data:extend({ recipe })

    -- apm.lib.utils.recipe.ingredient.remove_all(name)
    -- apm.lib.utils.recipe.ingredient.mod(name, t.steam.belt, 1)
    -- apm.lib.utils.recipe.ingredient.mod(name, alloys.brass, 1)
    -- apm.lib.utils.recipe.ingredient.mod(name, logic.steam, 1)

    -- apm.lib.utils.technology.add.recipe_for_unlock('logistics', name)
    -- apm.lib.utils.technology.remove.recipe_from_unlock('logistics', target)
    -- apm.lib.utils.technology.add.recipe_for_unlock('electronics', target)

    -- target = 'transport-belt-beltbox'
    -- name = prefix .. target

    -- recipe = table.deepcopy(data.raw.recipe[target])
    -- recipe.name = name
    -- data:extend({ recipe })

    -- apm.lib.utils.recipe.ingredient.remove_all(name)
    -- apm.lib.utils.recipe.ingredient.mod(name, t.steam.belt, 2)
    -- apm.lib.utils.recipe.ingredient.mod(name, alloys.brass, 10)
    -- apm.lib.utils.recipe.ingredient.mod(name, logic.steam, 2)
    -- apm.lib.utils.recipe.ingredient.mod(name, product.gearwheel.brass, 4)



    -- apm.lib.utils.technology.add.recipe_for_unlock('logistics', name)
    -- apm.lib.utils.technology.remove.recipe_from_unlock('logistics', target)
    -- apm.lib.utils.technology.add.recipe_for_unlock('electronics', target)
end

local fix = function ()
    -- remove dupls
end

apm.bob_rework.lib.override.belts = function()
    buildBelts(t.gray)
    buildBelts(t.steam)
    buildBelts(t.red)
    buildBelts(t.blue)

    buildStacker(t.steam)
    buildStacker(t.red)
    buildStacker(t.blue)

    -- cloneYellow()

    fix()
end
