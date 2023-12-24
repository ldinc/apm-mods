local materials = require "lib.entities.materials"
local product   = require "lib.entities.product"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local clone = function(name, ingredient, count, energy, subicon)
    local ico = apm.lib.utils.icon.get.from_item(product.gun.powder)
    local icons = apm.lib.utils.icon.merge({
        ico,
        {subicon},
    })
    local suffix = 'apm_gun_powder_'
    local recipename = suffix .. name

    local recipe = {}
    recipe.icons = icons
    recipe.type = "recipe"
    recipe.name = recipename
    recipe.category = "crafting"
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.energy_required = energy
    recipe.normal.ingredients = {
        { type = "item", name = 'sulfur', amount = 4 },
        { type = "item", name = ingredient, amount = count },
    }
    recipe.normal.results = {
        { type = 'item', name = product.gun.powder, amount = 10 }
    }
    recipe.normal.main_product = product.gun.powder
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        { type = "item", name = 'sulfur', amount = 10 },
        { type = "item", name = ingredient, amount = count },
    }
    recipe.allow_decomposition = false
    data:extend({ recipe })
end

apm.bob_rework.lib.override.gunpowder = function()
    local recipe = ''
    local set = function(item, count)
        if count == nil then count = 1 end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end
    local result = function(item, count)
        if count == nil then count = 1 end

        apm.lib.utils.recipe.result.mod(recipe, item, count)
    end
    local energy = function(normal, expensive)
        if normal == nil then normal = 1 end
        if expensive == nil then expensive = normal end

        apm.lib.utils.recipe.energy_required.mod(recipe, normal, expensive)
    end

    recipe = product.gun.powder
    set('sulfur', 4)
    set('apm_coal_crushed', 10)
    result(recipe, 10)
    energy(2)

    recipe = 'piercing-rounds-magazine'
    energy(2)

    recipe = 'firearm-magazine'
    energy(1)

    -- TODO: clone

    clone('from_crhushed_coke', 'apm_coke_crushed', 5, 2, apm.lib.icons.dynamics.t2)
    clone('from_charcoal', 'apm_charcoal', 4, 1, apm.lib.icons.dynamics.t3)
end
