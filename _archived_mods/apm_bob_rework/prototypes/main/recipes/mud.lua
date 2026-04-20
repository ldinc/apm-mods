require('util')
local product = require('lib.entities.product')
local wires   = require('lib.entities.wires')
local plates  = require('lib.entities.plates')
local frames  = require('lib.entities.frames')
local t = require('lib.tier.base')

local apm_power_always_show_made_in = true

local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wet_mud')
local item_icon_b = apm.lib.utils.icon.get.from_fluid('water')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, {-8,8})
local item_icon_c = {apm.lib.icons.dynamics.recycling}
local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b, item_icon_c})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local recipe = data.raw.recipe['apm_machine_frame_steam']
-- recipe.localised_name.name = 'primitive-frames'

local recipe = {}
recipe.type = "recipe"
recipe.category = "crafting-with-fluid"
recipe.name = "apm_dry_to_wet_mud"
-- recipe.localised_name ={ "entity-name.primitive-frame", { "entity-name.primitive-frame" } }
recipe.icons = icons
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 1
recipe.normal.ingredients = {
    { type = "item", name = "apm_dry_mud", amount = 10 },
    { type = "fluid", name = "water", amount = 100 },
}
recipe.normal.results = {
    { type = 'item', name = "apm_wet_mud", amount = 20 }
}
recipe.normal.main_product = "apm_wet_mud"
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = "apm_dry_mud", amount = 15 },
    { type = "fluid", name = "water", amount = 200 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
