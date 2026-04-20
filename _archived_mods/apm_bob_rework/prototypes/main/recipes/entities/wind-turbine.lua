require('util')
local product = require('lib.entities.product')
local wires   = require('lib.entities.wires')
local alloys  = require('lib.entities.alloys')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "kr-wind-turbine"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 5
recipe.normal.ingredients = {
    { type = "item", name = product.egenerator, amount = 1 },
    { type = "item", name = wires.copper, amount = 5 },
    { type = "item", name = product.gearwheel.brass, amount = 2 },
    { type = "item", name = product.bearing.brass, amount = 1 },
    { type = "item", name = alloys.brass, amount = 3 },
}
recipe.normal.results = {
    { type = 'item', name = 'kr-wind-turbine', amount = 1 }
}
recipe.normal.main_product = 'kr-wind-turbine'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = product.egenerator, amount = 1 },
    { type = "item", name = wires.copper, amount = 10 },
    { type = "item", name = product.gearwheel.brass, amount = 4 },
    { type = "item", name = product.bearing.brass, amount = 2 },
    { type = "item", name = alloys.brass, amount = 6 },
}
--recipe.expensive.results = {}
data:extend({recipe})