require('util')

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
    { type = "item", name = "apm_machine_frame_steam", amount = 2 },
    { type = "item", name = "iron-stick", amount = 20 },
    { type = "item", name = "copper-cable", amount = 100 }
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
    { type = "item", name = "apm_machine_frame_steam", amount = 4 },
    { type = "item", name = "iron-stick", amount = 30 },
    { type = "item", name = "copper-cable", amount = 140 }
}
--recipe.expensive.results = {}
data:extend({recipe})