local product = require "lib.entities.product"
local ores    = require "lib.entities.ores"
local recipies= require "lib.entities.recipies"
local fluids  = require "lib.entities.fluids"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.genOldscoolPlastics = function ()

    local item_icon_a = apm.lib.utils.icon.get.from_item(product.chemistry.plastic)
    local item_icon_b = {apm.lib.icons.dynamics.chemical_flame_2}
    local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})

    local recipe = {}
    recipe.icons = icons
    recipe.type = "recipe"
    recipe.name = recipies.chemistry.plastic.old
    recipe.normal = {}
    recipe.category = 'chemistry'
    recipe.normal.enabled = true
    recipe.normal.energy_required = 1
    recipe.normal.ingredients = {
            {type="fluid", name=fluids.oil.crude, amount=20},
            {type="fluid", name=fluids.chlorine, amount=20}
        }
    recipe.normal.results = {
            {type='item', name=product.chemistry.plastic, amount=1}
        }
    recipe.normal.main_product = name
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name=ores.coal, amount=3},
        {type="fluid", name=fluids.chlorine, amount=25}
        }

    data:extend({recipe})
end

apm.bob_rework.lib.entities.genOldscoolPlastics()