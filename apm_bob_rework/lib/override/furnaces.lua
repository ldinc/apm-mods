if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local fix = function(recipe)
    local item = data.raw['assembling-machine'][recipe]
    item.energy_source.burnt_inventory_size = 1
end

local bob_update = function ()
    local name = 'electric-chemical-mixing-furnace'
    local furnace = data.raw['assembling-machine'][name]
    if furnace == nil or furnace.animation == nil then
        return
    end

    furnace.animation.filename = '__apm_bob_rework_ldinc__/graphics/entities/bob/electric-chemical-mixing-furnace.png'
end

apm.bob_rework.lib.override.furnaces = function()
    local recipe = 'electric-mixing-furnace'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.stoneBrick, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steelPipe, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.logicAdvanced, 8)

    local recipe = 'electric-chemical-mixing-furnace'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.advancedMachineFrame, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-chemical-furnace', 0)
    local recipe = 'electric-chemical-mixing-furnace-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.advancedMachineFrame, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-chemical-mixing-furnace', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.invar, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.steel, 20)

    -- fix ash
    fix('stone-mixing-furnace')
    fix('stone-chemical-furnace')
    fix('steel-mixing-furnace')
    fix('steel-chemical-furnace')

    -- change color for bob furnace
    bob_update()
end
