require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/smelting.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_stone_crucible_raw')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_stone_brick_raw')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, 8 })
--local item_icon_c = {apm.lib.icons.dynamics.t1}
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_raw_crucible_0"
--recipe.category = ''
recipe.group = "apm_power"
recipe.subgroup = "apm_power_smelting"
recipe.order = 'aa_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "apm_stone_brick_raw", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_stone_crucible_raw', amount = 1 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_stone_crucible_raw')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_wet_mud')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, 8 })
--local item_icon_c = {apm.lib.icons.dynamics.t1}
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_raw_crucible_1"
recipe.category = "apm_press"
recipe.group = "apm_power"
recipe.subgroup = "apm_power_smelting"
recipe.order = 'aa_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "apm_wet_mud", amount = 5 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_stone_crucible_raw', amount = 1 },
	{ type = 'fluid', name = 'apm_dirt_water',         amount = 25, catalyst_amount = 25 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_stone_crucible')
local item_icon_b = { apm.lib.icons.dynamics.smelting }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_stone_crucible"
recipe.category = 'smelting'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_smelting"
recipe.order = 'aa_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	{ type = "item", name = "apm_stone_crucible_raw", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'apm_stone_crucible', amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
