require('util')
local product = require('lib.entities.product')
local wires   = require('lib.entities.wires')
local alloys  = require('lib.entities.alloys')
local pipes   = require('lib.entities.pipes')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = pipes.sinkhole.small
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
        {type="item", name=pipes.base.iron, amount=50},
        {type="item", name=product.rubber, amount=10},
        {type="item", name="concrete", amount=20}
    }
recipe.normal.results = {
        {type='item', name=pipes.sinkhole.small, amount=1}
    }
recipe.normal.main_product = pipes.sinkhole.small
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    {type="item", name=pipes.base.iron, amount=80},
    {type="item", name=product.rubber, amount=20},
    {type="item", name="concrete", amount=40}
    }
--recipe.expensive.results = {}
data:extend({recipe})