require('util')
local materials = require('lib.entities.materials')
local product   = require('lib.entities.product')
local logic     = require('lib.entities.logic')
local plates     = require('lib.entities.plates')
local pipes      = require('lib.entities.pipes')

local apm_power_always_show_made_in = true

local target = 'minibuffer-allcorners'

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = target
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = plates.iron, amount = 4 },
    { type = "item", name = product.rubber, amount = 4 },
    { type = "item", name = pipes.base.iron, amount = 4 },
}
recipe.normal.results = {
    { type = 'item', name = target, amount = 1 }
}
recipe.normal.main_product = target
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = plates.iron, amount = 8 },
    { type = "item", name = product.rubber, amount = 8 },
    { type = "item", name = pipes.base.iron, amount = 8 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
