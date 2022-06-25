if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local change2Tier = function ()
    local items = {
        'logistic-chest-active-provider-2',
        'logistic-chest-buffer-2',
        'logistic-chest-passive-provider-2',
        'logistic-chest-requester-2',
        'logistic-chest-storage-2',
    }
    for _, key in pairs(items) do
        data.raw['logistic-container'][key].inventory_size = 96 -- x2 from 1 tier
    end

    local key = 'bob-roboport-2'
    local port = data.raw['roboport'][key]
    port.construction_radius=90
    port.logistics_radius=90
    local key = 'bob-roboport-2'
    local port = data.raw['roboport'][key]
    port.construction_radius=90
    port.logistics_radius=90
end

local modify = function ()
    local recipies = {
        'logistic-chest-active-provider',
        'logistic-chest-buffer',
        'logistic-chest-passive-provider',
        'logistic-chest-requester',
        'logistic-chest-storage',
        'storehouse-active-provider',
        'storehouse-passive-provider',
        'storehouse-storage',
        'storehouse-buffer',
        'storehouse-requester',
        'warehouse-active-provider',
        'warehouse-passive-provider',
        'warehouse-storage',
        'warehouse-buffer',
        'warehouse-requester',
    }
    for _, recipe in pairs(recipies) do
        apm.lib.utils.recipe.ingredient.mod(recipe, 'roboport-antenna-1', 1)
    end
    local recipies = {
        'logistic-chest-active-provider-3',
        'logistic-chest-buffer-3',
        'logistic-chest-passive-provider-3',
        'logistic-chest-requester-3',
        'logistic-chest-storage-3',
    }
    for _, recipe in pairs(recipies) do
        apm.lib.utils.recipe.ingredient.mod(recipe, 'roboport-antenna-4', 1)
    end

    local recipe = 'cliff-explosives'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'explosives', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.gunPowder, 160)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.iron, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'empty-barrel', 0)

    --change bots
    local recipe = 'bob-construction-robot-5'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'bob-construction-robot-3', 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rtg', 1)
    local recipe = 'bob-logistic-robot-5'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'bob-logistic-robot-3', 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rtg', 1)

    change2Tier()
end

modify()