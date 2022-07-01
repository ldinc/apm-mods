require('util')
local product = require('lib.entities.product')
local wires   = require('lib.entities.wires')
local plates  = require('lib.entities.plates')
local frames  = require('lib.entities.frames')
local t = require('lib.tier.base')

local apm_power_always_show_made_in = true


local base = apm.lib.utils.icon.get.from_item(frames.steam)
local item_icon_II = {apm.lib.icons.dynamics.t1}

local iconsII = apm.lib.utils.icon.merge({base, item_icon_II})

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local recipe = data.raw.recipe['apm_machine_frame_steam']
-- recipe.localised_name.name = 'primitive-frames'

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_machine_frame_steam-2"
recipe.localised_name ={ "entity-name.primitive-frame", { "entity-name.primitive-frame" } }
recipe.icons = iconsII
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = t.yellow.constructionAlloy, amount = 2 },
    { type = "item", name = t.yellow.pipe, amount = 2 },
    { type = "item", name = t.yellow.logic, amount = 2 },
}
recipe.normal.results = {
    { type = 'item', name = frames.steam, amount = 1 }
}
recipe.normal.main_product = frames.steam
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = t.yellow.constructionAlloy, amount = 4 },
    { type = "item", name = t.yellow.pipe, amount = 4 },
    { type = "item", name = t.yellow.logic, amount = 4 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
