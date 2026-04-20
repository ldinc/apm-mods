local newClear = function (recipe)
    return function ()
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
    end
end

local newSet = function (recipe)
    return function (item, count)
        if count == nil then
            count = 1
        end
        
        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end
end

local newSingleResultCount = function (recipe)
    return function (count)
        if count == nil then
            count = 1
        end

        local result = apm.lib.utils.recipe.result.get_first_result(recipe)
        apm.lib.utils.recipe.result.mod(recipe, result, count)
    end
end

local newSetRequiredEnergy = function (recipe)
    return function (energy, energy_exp)
        if energy == nil then
            energy = 1
        end

        if energy_exp == nil then
            energy_exp = energy
        end

        apm.lib.utils.recipe.energy_required.mod(recipe, energy, energy_exp)
    end
end

return {
    newClear = newClear,
    newSet = newSet,
    newSetResultCount = newSingleResultCount,
    newSetRequiredEnergy = newSetRequiredEnergy,
}