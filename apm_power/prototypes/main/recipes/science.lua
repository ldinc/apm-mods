require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/science.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_tool('apm_industrial_science_pack')
--local item_icon_b = {apm.lib.icons.dynamics.t1}
--local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
local icons = apm.lib.utils.icon.merge({ item_icon_a })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_industrial_science_pack_0"
recipe.category = 'apm_handcrafting_only'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_science"
recipe.order = 'aa_a'
recipe.icons = icons

recipe.enabled = true
recipe.energy_required = 10
recipe.ingredients = {
	{ type = "item", name = "apm_mechanical_relay", amount = 2 },
	{ type = "item", name = "stone",                amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_industrial_science_pack', amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_tool('apm_industrial_science_pack')
--local item_icon_b = {apm.lib.icons.dynamics.t2}
--local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
local icons = apm.lib.utils.icon.merge({ item_icon_a })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_industrial_science_pack_1"
recipe.category = 'basic-crafting'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_science"
recipe.order = 'aa_b'
recipe.icons = icons

recipe.enabled = true
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "apm_mechanical_relay", amount = 1 },
	{ type = "item", name = "stone-brick",          amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_industrial_science_pack', amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_steam_science_pack"
recipe.category = 'basic-crafting'
--recipe.icons = icons

recipe.enabled = true
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item",  name = "apm_steam_relay", amount = 1 },
	{ type = "item",  name = "apm_rubber",      amount = 1 },
	{ type = "fluid", name = "steam",           amount = 100 }
}
recipe.results = {
	{ type = 'item', name = 'apm_steam_science_pack', amount = 1 }
}
recipe.main_product = 'apm_steam_science_pack'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
