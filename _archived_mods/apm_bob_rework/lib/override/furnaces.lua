if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local f = require('lib.entities.buildings.furnaces')
local w = require('lib.entities.wires')

local fix = function(recipe)
    local item = data.raw['assembling-machine'][recipe]
    item.energy_source.burnt_inventory_size = 1
end

local bob_update = function()
    local furnace = data.raw['assembling-machine'][f.multipurpose]
    if furnace == nil or furnace.animation == nil then
        return
    end

    furnace.animation.filename = '__apm_bob_rework_resource_pack_ldinc__/graphics/entities/bob/electric-chemical-mixing-furnace.png'
end

apm.bob_rework.lib.override.furnaces = function()

    local tier = t.red

    local recipe = f.mixing.electric
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, w.copper, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 9)

    local recipe = f.chemical.electric
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, w.copper, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 9)


    tier = t.blue
    local recipe = f.multipurpose
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 25)
    apm.lib.utils.recipe.ingredient.mod(recipe, w.copper, 120)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 9)

    -- fix ash
    fix('stone-mixing-furnace')
    fix('stone-chemical-furnace')
    fix('steel-mixing-furnace')
    fix('steel-chemical-furnace')

    -- change color for bob furnace
    bob_update()
end
