require('util')
local logic = require('lib.entities.logic')
local product = require('lib.entities.product')
local alloys  = require('lib.entities.alloys')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "kr-sentinel"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 20
recipe.normal.ingredients = {
    { type = "item", name = logic.circuit.low, amount = 2 },
    { type = "item", name = product.gearwheel.brass, amount = 2 },
    { type = "item", name = alloys.brass, amount = 2 },
    { type = "item", name = product.engine.electric, amount = 1 },
}
recipe.normal.results = {
    { type = 'item', name = 'kr-sentinel', amount = 1 }
}
recipe.normal.main_product = 'kr-sentinel'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = logic.circuit.low, amount = 3 },
    { type = "item", name = product.gearwheel.brass, amount = 6 },
    { type = "item", name = alloys.brass, amount = 5 },
    { type = "item", name = product.engine.electric, amount = 1 },
}
--recipe.expensive.results = {}
data:extend({recipe})