if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

require('lib.utils.debug')

apm.bob_rework.lib.entities.bronzeGearWheel = 'bronze-gear-wheel'

-- construct
local gearIcon = apm.lib.utils.icon.get.from_recipe('brass-gear-wheel')
local ico = {
    icon = "__apm_bob_rework_ldinc__/graphics/icons/gear-wheel.png",
    icon_size = 32,
    tint = {r=0.85, g=0.8, b=0.1}
}

local item = {}
item.type = 'item'
item.name = apm.bob_rework.lib.entities.bronzeGearWheel
item.icons = {ico}
item.stack_size = 200
item.group = "apm_power"
item.subgroup = "apm_power_intermediates"
item.order = 'ab_i'
data:extend({item})

local recipe = {}
recipe.type = "recipe"
recipe.name = apm.bob_rework.lib.entities.bronzeGearWheel
recipe.normal = {}
recipe.normal.enabled = true
recipe.normal.energy_required = 0.5
recipe.normal.ingredients = {
        {type="item", name=apm.bob_rework.lib.entities.bronze, amount=1}
    }
recipe.normal.results = { 
        {type='item', name=apm.bob_rework.lib.entities.bronzeGearWheel, amount=1}
    }
recipe.normal.main_product = apm.bob_rework.lib.entities.bronzeGearWheel
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = true
recipe.expensive = table.deepcopy(recipe.normal)
recipe.expensive.ingredients = {
        {type="item", name="iron-plate", amount=1}
    }

data:extend({recipe})
