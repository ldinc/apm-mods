local product = require "lib.entities.product"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

require('lib.entities.fluids')
require('lib.entities.gearingAndBearings')

local alloy = require('lib.entities.alloys')
local fluids = require('lib.entities.fluids')

apm.bob_rework.lib.entities.genBearing = function (name, base, ball, tint)
    local ico = {
        icon = "__apm_bob_rework_resource_pack_ldinc__/graphics/icons/bearing.png",
        icon_size = 32,
        tint = tint,
    }

    local item = {}
    item.type = 'item'
    item.name = name
    item.icons = {ico}
    item.stack_size = 200
    item.group = "apm_power"
    item.subgroup = "apm_power_intermediates"
    item.order = 'ab_i'
    data:extend({item})

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = name
    recipe.category = 'crafting-with-fluid'
    recipe.normal = {}
    recipe.normal.enabled = true
    recipe.normal.energy_required = 0.5
    recipe.normal.ingredients = {
            {type="item", name=base, amount=1},
            {type="item", name=ball, amount=1},
            {type="fluid", name=fluids.lubricant, amount=10}
        }
    recipe.normal.results = { 
            {type='item', name=name, amount=2}
        }
    recipe.normal.main_product = name
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = true
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = {
        {type="item", name=base, amount=1},
        {type="item", name=ball, amount=2},
        {type="fluid", name=fluids.lubricant, amount=15}
    }

    data:extend({recipe})
end

apm.bob_rework.lib.entities.genBearing(
    product.bearing.bronze, alloy.bronze, product.bearing.balls.bronze,
    {r=151/255, g=115/255, b=81/255}
)
apm.bob_rework.lib.entities.genBearing(
    product.bearing.brass, alloy.brass, product.bearing.balls.brass,
    {r=235/255, g=244/255, b=181/255}
)