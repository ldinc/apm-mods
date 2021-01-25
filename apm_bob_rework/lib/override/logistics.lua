if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

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
end

modify()