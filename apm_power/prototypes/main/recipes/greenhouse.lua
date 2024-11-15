require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/greenhouse.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_tree_seeds"
recipe.category = 'basic-crafting'

recipe.enabled = false
recipe.energy_required = 2.5
recipe.ingredients = {
	{ type = "item", name = "wood", amount = 4 }
}
recipe.results = {
	{ type = 'item', name = 'apm_tree_seeds', amount = 1 }
}
recipe.main_product = 'apm_tree_seeds'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_fertiliser_1')
--local item_icon_b = {apm.lib.icons.dynamics.t1}
local icons = apm.lib.utils.icon.merge({ item_icon_a })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_fertiliser_1"
recipe.category = 'basic-crafting'
recipe.group = "apm_power"
recipe.subgroup = "apm_greenhouse"
recipe.order = 'ab_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "sulfur",           amount = 1 },
	{ type = "item", name = "apm_wood_pellets", amount = 2 },
	{ type = "item", name = "apm_wet_mud",      amount = 5 },
	{ type = "item", name = 'apm_generic_ash',  amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_fertiliser_1', amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 8
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_fertiliser_2')
--local item_icon_b = {apm.lib.icons.dynamics.t2}
local icons = apm.lib.utils.icon.merge({ item_icon_a })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_fertiliser_2"
recipe.category = 'advanced-crafting'
recipe.group = "apm_power"
recipe.subgroup = "apm_greenhouse"
recipe.order = 'ab_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = 'item', name = 'apm_fertiliser_1',     amount = 1 },
	{ type = 'item', name = 'apm_ammonium_sulfate', amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_fertiliser_2', amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 8
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_0"
recipe.category = 'apm_greenhouse'
recipe.group = "apm_power"
recipe.subgroup = "apm_greenhouse"
recipe.order = 'ac_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 100
recipe.ingredients = {
	{ type = "item",  name = "apm_tree_seeds", amount = 2 },
	{ type = "item",  name = "apm_wet_mud",    amount = 2 },
	{ type = "fluid", name = "water",          amount = 200 }
}
recipe.results = {
	{ type = 'item', name = 'wood', amount_min = 15, amount_max = 20, show_details_in_recipe_tooltip = false }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 8
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_1"
recipe.category = 'apm_greenhouse'
recipe.group = "apm_power"
recipe.subgroup = "apm_greenhouse"
recipe.order = 'ac_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 250
recipe.ingredients = {
	{ type = "item",  name = "apm_tree_seeds",   amount = 4 },
	{ type = "item",  name = "apm_fertiliser_1", amount = 3 },
	{ type = "fluid", name = "water",            amount = 200 }
}
recipe.results = {
	{ type = 'item', name = 'wood', amount = 60 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 8
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_2"
recipe.category = 'apm_greenhouse'
recipe.group = "apm_power"
recipe.subgroup = "apm_greenhouse"
recipe.order = 'ac_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 175
recipe.ingredients = {
	{ type = "item",  name = "apm_tree_seeds",   amount = 4 },
	{ type = "item",  name = "apm_fertiliser_2", amount = 4 },
	{ type = "fluid", name = "water",            amount = 200 }
}
recipe.results = {
	{ type = 'item', name = 'wood', amount = 75 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 8
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
