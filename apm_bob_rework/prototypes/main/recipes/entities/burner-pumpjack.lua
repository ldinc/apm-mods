require('util')
local materials = require('lib.entities.materials')
local product   = require('lib.entities.product')
local logic     = require('lib.entities.logic')
local pumps     = require('lib.entities.pumps')
local pipes     = require('lib.entities.pipes')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "burner-pumpjack"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = materials.brick, amount = 10 },
    { type = "item", name = product.sieve.iron, amount = 20 },
    { type = "item", name = pumps.burner, amount = 4 },
    { type = "item", name = product.gearwheel.bronze, amount = 4 },
    { type = "item", name = product.bearing.bronze, amount = 2 },
    { type = "item", name = logic.mechanical, amount = 2 },
    { type = "item", name = pipes.base.iron, amount = 20 },
}
recipe.normal.results = {
    { type = 'item', name = 'burner-pumpjack', amount = 1 }
}
recipe.normal.main_product = 'burner-pumpjack'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = materials.brick, amount = 15 },
    { type = "item", name = product.sieve.iron, amount = 25 },
    { type = "item", name = pumps.burner, amount = 6 },
    { type = "item", name = product.gearwheel.bronze, amount = 4 },
    { type = "item", name = product.bearing.bronze, amount = 2 },
    { type = "item", name = logic.mechanical, amount = 2 },
    { type = "item", name = pipes.base.iron, amount = 30 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
