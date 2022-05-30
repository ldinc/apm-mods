require('util')

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
    { type = "item", name = "glass", amount = 2 },
    { type = "item", name = "iron-plate", amount = 5 },
    { type = "item", name = "copper-cable", amount = 2 }
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
    { type = "item", name = "glass", amount = 4 },
    { type = "item", name = "iron-plate", amount = 8 },
    { type = "item", name = "copper-cable", amount = 4 }
}
--recipe.expensive.results = {}
data:extend({ recipe })
