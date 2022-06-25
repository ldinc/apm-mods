if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildStorageTank = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 20 + 10* tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 25 + 10* tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 20 * tier.basementK)
end

local buildAllCornersStorageTank = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 4)
end


apm.bob_rework.lib.override.storageTanks = function ()
    -- apm.lib.utils.recipe.ingredient.remove_all(recipe)
    local recipe = 'bob-small-inline-storage-tank'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5)
    local recipe = 'bob-small-storage-tank'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5)

    local gen = function (base, extra, tier)
        buildStorageTank(base, tier)
        buildAllCornersStorageTank(extra, base, tier)
    end

    gen('storage-tank', 'bob-storage-tank-all-corners', apm.bob_rework.lib.tier.gray)
    gen('storage-tank-2', 'bob-storage-tank-all-corners-2', apm.bob_rework.lib.tier.red)
    -- gen('storage-tank-3', 'bob-storage-tank-all-corners-3', apm.bob_rework.lib.tier.aluminium)
    -- gen('storage-tank-4', 'bob-storage-tank-all-corners-4', apm.bob_rework.lib.tier.titanium)
end