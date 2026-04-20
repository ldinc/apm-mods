if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.deuterium = function()
    local recipe = ''
    local mod = function(item, amount) apm.lib.utils.recipe.ingredient.mod(recipe, item, amount) end
    local clearall = function () apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local clear = function (item) mod(item, 0) end
    local product = function (item, count) apm.lib.utils.recipe.result.mod(recipe, item, count)  end
    local energy = function (e, exp)
        if exp == nil then
            exp = e
        end
        apm.lib.utils.recipe.energy_required.mod(e, exp)
    end
    
    recipe = 'deuterium-fuel-reprocessing'
    product('lithium', 0)
    product('fusion-catalyst', 100)

    local single = function (item)
        if item == nil then
            item = recipe
        end

        product(item, 1)
    end
        
    recipe = 'plasma-rocket-warhead'
    single()

    recipe = 'plasma-bullet-projectile'
    product(recipe, 2)
end
