require('util')
local materials = require('lib.entities.materials')
local product   = require('lib.entities.product')
local logic     = require('lib.entities.logic')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_burner_sieve"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = materials.stone, amount = 20 },
    { type = "item", name = materials.wood, amount = 10 },
    { type = "item", name = product.sieve.iron, amount = 5 },
    { type = "item", name = product.engine.burner, amount = 1 },
    { type = "item", name = product.gearwheel.bronze, amount = 4 },
    { type = "item", name = product.bearing.bronze, amount = 2 },
    { type = "item", name = logic.mechanical, amount = 2 },
}
recipe.normal.results = {
    { type = 'item', name = 'apm_burner_sieve', amount = 1 }
}
recipe.normal.main_product = 'apm_burner_sieve'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = materials.stone, amount = 30 },
    { type = "item", name = materials.wood, amount = 15 },
    { type = "item", name = product.sieve.iron, amount = 15 },
    { type = "item", name = product.engine.burner, amount = 2 },
    { type = "item", name = product.gearwheel.bronze, amount = 4 },
    { type = "item", name = product.bearing.bronze, amount = 2 },
    { type = "item", name = logic.mechanical, amount = 5 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
