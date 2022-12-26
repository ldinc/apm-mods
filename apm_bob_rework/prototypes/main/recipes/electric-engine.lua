require('util')
local product   = require('lib.entities.product')
local wires     = require('lib.entities.wires')
local plates    = require('lib.entities.plates')
local alloys    = require('lib.entities.alloys')
local materials = require('lib.entities.materials')

local apm_power_always_show_made_in = true

local dup = function(origin, new, normal, hard, level)
    local base = apm.lib.utils.icon.get.from_item(origin)
    local item_icon_II = { apm.lib.icons.dynamics.t1 }
    local item_icon_III = { apm.lib.icons.dynamics.t2 }

    local icons = apm.lib.utils.icon.merge({ base, item_icon_II })
    if level == 2 then
        icons = apm.lib.utils.icon.merge({ base, item_icon_III })
    end

    local recipe = {}
    recipe.type = "recipe"
    recipe.name = new
    recipe.icons = icons
    recipe.normal = {}
    recipe.normal.enabled = false
    recipe.normal.energy_required = 4
    recipe.normal.ingredients = normal
    recipe.normal.results = {
        { type = 'item', name = origin, amount = 1 }
    }
    recipe.normal.main_product = origin
    recipe.normal.requester_paste_multiplier = 4
    recipe.normal.always_show_products = true
    recipe.normal.always_show_made_in = apm_power_always_show_made_in
    recipe.expensive = table.deepcopy(recipe.normal)
    recipe.expensive.ingredients = hard
    data:extend({ recipe })
end

dup(product.engine.electric, 'electric-engine-unit-2',
    { { type = "item", name = product.magnet, amount = 12 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = wires.copper, amount = 12 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 2 }, },
    { { type = "item", name = product.magnet, amount = 16 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = wires.copper, amount = 24 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 3 }, },
    1
)

dup(product.engine.electric, 'electric-engine-unit-3',
    { { type = "item", name = product.magnet, amount = 12 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = wires.copper, amount = 12 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 2 }, },
    { { type = "item", name = product.magnet, amount = 16 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = wires.copper, amount = 24 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 3 }, },
    2
)

dup(product.egenerator, product.egenerator .. '-2',
    { { type = "item", name = product.magnet, amount = 10 },
        { type = "item", name = wires.copper, amount = 2 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 2 }, },
    { { type = "item", name = product.magnet, amount = 14 },
        { type = "item", name = wires.copper, amount = 4 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 3 }, },
    1
)

dup(product.egenerator, product.egenerator .. '-3',
    { { type = "item", name = product.magnet, amount = 10 },
        { type = "item", name = wires.copper, amount = 2 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 2 }, },
    { { type = "item", name = product.magnet, amount = 14 },
        { type = "item", name = wires.copper, amount = 4 },
        { type = "item", name = product.stick, amount = 1 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 3 }, },
    2
)

dup(product.engine.basic, product.engine.basic .. '-2',
    { { type = "item", name = product.pistions, amount = 8 },
        { type = "item", name = product.gearwheel.cobaltSteel, amount = 10 },
        { type = "item", name = product.stick, amount = 4 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 4 }, },
    { { type = "item", name = product.pistions, amount = 16 },
        { type = "item", name = product.gearwheel.cobaltSteel, amount = 20 },
        { type = "item", name = product.stick, amount = 4 },
        { type = "item", name = product.bearing.cobaltSteel, amount = 2 },
        { type = "item", name = plates.iron, amount = 5 }, },
    1
)

dup(product.engine.basic, product.engine.basic .. '-3',
    { { type = "item", name = product.pistions, amount = 8 },
        { type = "item", name = product.gearwheel.titanium, amount = 10 },
        { type = "item", name = product.stick, amount = 4 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 4 }, },
    { { type = "item", name = product.pistions, amount = 16 },
        { type = "item", name = product.gearwheel.titanium, amount = 20 },
        { type = "item", name = product.stick, amount = 4 },
        { type = "item", name = product.bearing.titanium, amount = 2 },
        { type = "item", name = plates.iron, amount = 5 }, },
    2
)


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "bronze-bearing-crashsite"
recipe.hide_from_player_crafting = true
-- recipe.hidden = true
recipe.enabled = true
recipe.hidden = true
recipe.category = 'apm_crashsite'
recipe.normal = {}
recipe.normal.enabled = true
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = alloys.bronze, amount = 3 },
    { type = "item", name = materials.wood, amount = 1 },
}
recipe.normal.results = {
    { type = 'item', name = product.bearing.bronze, amount = 1 }
}
recipe.normal.main_product = product.bearing.bronze
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = alloys.bronze, amount = 4 },
    { type = "item", name = materials.wood, amount = 2 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
