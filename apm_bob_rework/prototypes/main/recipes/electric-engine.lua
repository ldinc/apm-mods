require('util')
local product = require('lib.entities.product')
local wires   = require('lib.entities.wires')
local plates  = require('lib.entities.plates')

local apm_power_always_show_made_in = true


local base = apm.lib.utils.icon.get.from_item(product.engine.electric)
local item_icon_II = {apm.lib.icons.dynamics.t1}
local item_icon_III = {apm.lib.icons.dynamics.t2}


local iconsII = apm.lib.utils.icon.merge({base, item_icon_II})
local iconsIII = apm.lib.utils.icon.merge({base, item_icon_III})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "electric-engine-unit-2"
recipe.icons = iconsII
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = product.magnet, amount = 12 },
    { type = "item", name = product.stick, amount = 1 },
    { type = "item", name = wires.copper, amount = 12 },
    { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
    { type = "item", name = plates.iron, amount = 2 },
}
recipe.normal.results = {
    { type = 'item', name = product.engine.electric, amount = 1 }
}
recipe.normal.main_product = product.engine.electric
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = product.magnet, amount = 16 },
    { type = "item", name = product.stick, amount = 1 },
    { type = "item", name = wires.copper, amount = 24 },
    { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
    { type = "item", name = plates.iron, amount = 3 },
}
--recipe.expensive.results = {}
data:extend({ recipe })


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "electric-engine-unit-3"
recipe.icons = iconsIII
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = product.magnet, amount = 12 },
    { type = "item", name = product.stick, amount = 1 },
    { type = "item", name = wires.copper, amount = 12 },
    { type = "item", name = product.bearing.titanium, amount = 2 },
    { type = "item", name = plates.iron, amount = 2 },
}
recipe.normal.results = {
    { type = 'item', name = product.engine.electric, amount = 1 }
}
recipe.normal.main_product = product.engine.electric
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = product.magnet, amount = 16 },
    { type = "item", name = product.stick, amount = 1 },
    { type = "item", name = wires.copper, amount = 24 },
    { type = "item", name = product.bearing.titanium, amount = 2 },
    { type = "item", name = plates.iron, amount = 3 },
}
--recipe.expensive.results = {}
data:extend({ recipe })