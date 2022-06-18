require('util')

local apm_power_always_show_made_in = true

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "wide-beacon"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = "apm_machine_frame_steam", amount = 3 },
    { type = "item", name = "iron-stick", amount = 30 },
    { type = "item", name = "stone-brick", amount = 10 }
}
recipe.normal.results = {
    { type = 'item', name = 'wide-beacon', amount = 1 }
}
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
recipe.expensive.ingredients = {
    { type = "item", name = "apm_machine_frame_steam", amount = 6 },
    { type = "item", name = "iron-stick", amount = 60 },
    { type = "item", name = "stone-brick", amount = 20 }
}
data:extend({ recipe })
