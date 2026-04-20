require('util')
local materials = require('lib.entities.materials')
local alloys    = require('lib.entities.alloys')
local logic     = require('lib.entities.logic')
local product   = require('lib.entities.product')
local energy    = require('lib.entities.buildings.energy')
local chemistry = require('lib.entities.buildings.chemistry')
local pumps     = require('lib.entities.pumps')
local modules   = require('lib.entities.modules')
local gems   = require('lib.entities.gems')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "kr-antimatter-reactor"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 300
recipe.normal.ingredients = {
    { type = "item", name = materials.refined.concrete, amount = 1000 },
    { type = "item", name = alloys.titanium, amount = 2500 },
    { type = "item", name = alloys.tungstenCarbide, amount = 2000 },
    { type = "item", name = alloys.copper.tungsten, amount = 2000 },
    { type = "item", name = logic.PU, amount = 1000 },
    { type = "item", name = logic.APU, amount = 1000 },
    { type = "item", name = product.egenerator, amount = 500 },
    { type = "item", name = product.magnet, amount = 600 },
    { type = "item", name = energy.heat.pipe.extra, amount = 500 },
    { type = "item", name = chemistry.compressor.advance, amount = 50 },
    { type = "item", name = pumps.blue, amount = 50 },
    { type = "item", name = energy.heat.pipe.extra, amount = 500 },
    { type = "item", name = modules.productivity.pure.VIII, amount = 100 },
    { type = "item", name = modules.speed.pure.VIII, amount = 100 },
    { type = "item", name = gems.diamond.polished, amount = 100 },
}
recipe.normal.results = {
    { type = 'item', name = 'kr-antimatter-reactor', amount = 1 }
}
recipe.normal.main_product = 'kr-antimatter-reactor'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = materials.refined.concrete, amount = 2000 },
    { type = "item", name = alloys.titanium, amount = 3500 },
    { type = "item", name = alloys.tungstenCarbide, amount = 3000 },
    { type = "item", name = alloys.copper.tungsten, amount = 3000 },
    { type = "item", name = logic.PU, amount = 2000 },
    { type = "item", name = logic.APU, amount = 1500 },
    { type = "item", name = product.egenerator, amount = 1000 },
    { type = "item", name = product.magnet, amount = 1200 },
    { type = "item", name = energy.heat.pipe.extra, amount = 1000 },
    { type = "item", name = chemistry.compressor.advance, amount = 50 },
    { type = "item", name = pumps.blue, amount = 50 },
    { type = "item", name = energy.heat.pipe.extra, amount = 500 },
    { type = "item", name = modules.productivity.pure.VIII, amount = 400 },
    { type = "item", name = modules.speed.pure.VIII, amount = 200 },
    { type = "item", name = gems.diamond.polished, amount = 300 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
