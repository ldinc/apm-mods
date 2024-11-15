require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/fuels.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_saturated_wastewater')
local item_icon_b = { apm.lib.icons.dynamics.lable_cr }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_saturated_wastewater"
recipe.category = 'apm_crusher'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'aa_a'
recipe.icons = icons


recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "coal",  amount = 1 },
	{ type = "fluid", name = "water", amount = 35 }
}
recipe.results = {
	{ type = 'fluid', name = 'apm_coal_saturated_wastewater', amount = 40 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_crushed')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_crushed_1"
recipe.category = 'apm_crusher'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'aa_a'
recipe.icons = icons


recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "coal", amount = 4 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coal_crushed', amount = 6 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 2
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_crushed')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_crushed_2"
recipe.category = 'apm_crusher_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'aa_b'
recipe.icons = icons


recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "coal",  amount = 4 },
	{ type = "fluid", name = "water", amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coal_crushed',              amount = 6 },
	{ type = 'item',  name = 'apm_coal_crushed',              amount_min = 1, amount_max = 2,      probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 20,    catalyst_amount = 20 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 2
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_crushed')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_crushed_3"
recipe.category = 'apm_crusher_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'aa_c'
recipe.icons = icons


recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "coal",              amount = 4 },
	{ type = "item",  name = "apm_crusher_drums", amount = 2 },
	{ type = "fluid", name = "water",             amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coal_crushed',              amount = 6 },
	{ type = 'item',  name = 'apm_crusher_drums_used',        amount = 2,  catalyst_amount = 1 },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 20, catalyst_amount = 20 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 2
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_briquette_pressed_1"
recipe.category = 'apm_press'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'ab_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "apm_coal_crushed", amount = 8 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coal_briquette', amount = 2 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 2
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_briquette_pressed_2"
recipe.category = 'apm_press_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'ab_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_crushed", amount = 8 },
	{ type = "fluid", name = "water",            amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coal_briquette',            amount = 4 },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 20, catalyst_amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coal_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_briquette_pressed_3"
recipe.category = 'apm_press_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coal"
recipe.order = 'ab_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_crushed", amount = 8 },
	{ type = "item",  name = "apm_press_plates", amount = 2 },
	{ type = "fluid", name = "water",            amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coal_briquette',            amount = 6 },
	{ type = "item",  name = "apm_press_plates_used",         amount = 2,  catalyst_amount = 1 },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 20, catalyst_amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coke')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_coke_1"
recipe.category = 'apm_coking'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coke"
recipe.order = 'aa_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "apm_coal_briquette", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coke',        amount = 2 },
	{ type = 'item', name = 'apm_generic_ash', amount = 3, show_details_in_recipe_tooltip = false }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coke')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_coke_2"
recipe.category = 'apm_coking'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coke"
recipe.order = 'aa_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_briquette", amount = 2 },
	{ type = "fluid", name = "steam",              amount = 50 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coke',        amount = 2 },
	{ type = 'item', name = 'apm_coke',        amount_min = 1, amount_max = 1,                        probability = 0.3, show_details_in_recipe_tooltip = false },
	{ type = 'item', name = 'sulfur',          amount_min = 1, amount_max = 1,                        probability = 0.35 },
	{ type = 'item', name = 'apm_generic_ash', amount = 2,     show_details_in_recipe_tooltip = false }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coke')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_coke_3"
recipe.category = 'apm_coking_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coke"
recipe.order = 'aa_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_briquette", amount = 3 },
	{ type = "fluid", name = "steam",              amount = 100 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coke',        amount = 3 },
	{ type = 'item',  name = 'apm_coke',        amount_min = 1, amount_max = 1,                        probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = 'item',  name = 'sulfur',          amount_min = 1, amount_max = 1,                        probability = 0.5 },
	{ type = 'fluid', name = 'apm_creosote',    amount = 15 },
	{ type = 'item',  name = 'apm_generic_ash', amount = 1,     show_details_in_recipe_tooltip = false }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coke')
local item_icon_b = { apm.lib.icons.dynamics.t4 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_coke_4"
recipe.category = 'apm_coking_3'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coke"
recipe.order = 'aa_d'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3.5
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_briquette", amount = 4 },
	{ type = "fluid", name = "steam",              amount = 150 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coke',          amount = 4 },
	{ type = 'item',  name = 'apm_coke',          amount_min = 1, amount_max = 1, probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = 'item',  name = 'sulfur',            amount_min = 1, amount_max = 1, probability = 0.7 },
	{ type = 'fluid', name = 'apm_creosote',      amount = 30 },
	{ type = 'fluid', name = 'apm_coke_oven_gas', amount = 30 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_coke')
local item_icon_b = { apm.lib.icons.dynamics.t5 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_coke_5"
recipe.category = 'apm_coking_3'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_coke"
recipe.order = 'aa_e'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item",  name = "apm_coal_briquette", amount = 4 },
	{ type = "fluid", name = "steam",              amount = 200 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_coke',          amount = 5 },
	{ type = 'item',  name = 'sulfur',            amount = 1 },
	{ type = 'fluid', name = 'apm_creosote',      amount = 35 },
	{ type = 'fluid', name = 'apm_coke_oven_gas', amount = 45 }
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
recipe.name = "apm_coke_crushed"
recipe.category = 'apm_crusher'

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "apm_coke", amount = 4 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coke_crushed', amount = 6 }
}
recipe.main_product = 'apm_coke_crushed'
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
recipe.name = "apm_coke_brick"
recipe.category = 'apm_press'

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "apm_coke", amount = 8 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coke_brick', amount = 2 }
}
recipe.main_product = 'apm_coke_brick'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_crushed_stone')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_stone_crushed_1"
recipe.category = 'apm_crusher'
recipe.group = "apm_power"
recipe.order = 'ac_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "stone-brick", amount = 4 }
}
recipe.results = {
	{ type = 'item', name = 'apm_crushed_stone', amount = 16 }
}
recipe.main_product = 'apm_crushed_stone'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_pellets_1"
recipe.category = 'apm_crusher'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ac_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "wood", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_wood_pellets', amount = 6 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_pellets_2"
recipe.category = 'apm_crusher_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ac_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "wood",  amount = 2 },
	{ type = "fluid", name = "water", amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_wood_pellets', amount = 6 },
	{ type = 'item',  name = 'apm_wood_pellets', amount_min = 1, amount_max = 2, probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = "fluid", name = "apm_dirt_water",   amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_pellets_3"
recipe.category = 'apm_crusher_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ac_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "wood",              amount = 2 },
	{ type = "item",  name = "apm_crusher_drums", amount = 2 },
	{ type = "fluid", name = "water",             amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_wood_pellets',       amount = 8 },
	--{type='item', name='apm_wood_pellets', amount_min=1, amount_max=1, probability=0.5, show_details_in_recipe_tooltip=false},
	{ type = "item",  name = "apm_crusher_drums_used", amount = 2, catalyst_amount = 1 },
	{ type = "fluid", name = "apm_dirt_water",         amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_briquette_1"
recipe.category = 'apm_press'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ad_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "apm_wood_pellets", amount = 8 }
}
recipe.results = {
	{ type = 'item', name = 'apm_wood_briquette', amount = 2 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_briquette_2"
recipe.category = 'apm_press_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ad_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "apm_wood_pellets", amount = 8 },
	{ type = "fluid", name = "water",            amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_wood_briquette', amount = 4 },
	{ type = "fluid", name = "apm_dirt_water",     amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_briquette')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_briquette_3"
recipe.category = 'apm_press_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_wood"
recipe.order = 'ad_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item",  name = "apm_wood_pellets", amount = 8 },
	{ type = "item",  name = "apm_press_plates", amount = 2 },
	{ type = "fluid", name = "water",            amount = 40 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_wood_briquette',    amount = 6 },
	{ type = "item",  name = "apm_press_plates_used", amount = 2, catalyst_amount = 1 },
	{ type = "fluid", name = "apm_dirt_water",        amount = 20 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_charcoal')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_charcoal_1"
recipe.category = 'apm_coking'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_charcoal"
recipe.order = 'aa_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_wood_briquette", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_charcoal',    amount = 2 },
	{ type = 'item', name = 'apm_charcoal',    amount_min = 1, amount_max = 1,                        probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = 'item', name = 'apm_generic_ash', amount = 3,     show_details_in_recipe_tooltip = false }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 5
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_charcoal')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_charcoal_2"
recipe.category = 'apm_coking_2'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_charcoal"
recipe.order = 'aa_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item",  name = "apm_wood_briquette", amount = 2 },
	{ type = "fluid", name = "steam",              amount = 100 }
}
recipe.results = {
	{ type = 'item', name = 'apm_charcoal',    amount = 3 },
	{ type = 'item', name = 'sulfur',          amount_min = 1, amount_max = 1,                        probability = 0.175 },
	{ type = 'item', name = 'apm_generic_ash', amount = 2,     show_details_in_recipe_tooltip = false },
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 3
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_charcoal')
local item_icon_b = { apm.lib.icons.dynamics.t3 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_charcoal_3"
recipe.category = 'apm_coking_3'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_charcoal"
recipe.order = 'aa_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item",  name = "apm_wood_briquette", amount = 3 },
	{ type = "fluid", name = "steam",              amount = 150 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_charcoal',    amount = 4 },
	{ type = 'item',  name = 'apm_charcoal',    amount_min = 1, amount_max = 1,                        probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = 'item',  name = 'sulfur',          amount_min = 1, amount_max = 1,                        probability = 0.25 },
	{ type = 'item',  name = 'apm_generic_ash', amount = 1,     show_details_in_recipe_tooltip = false },
	{ type = 'fluid', name = 'apm_creosote',    amount = 25 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_charcoal')
local item_icon_b = { apm.lib.icons.dynamics.t4 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_pyrolysis_charcoal_4"
recipe.category = 'apm_coking_3'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_charcoal"
recipe.order = 'aa_d'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2.5
recipe.ingredients = {
	{ type = "item",  name = "apm_wood_briquette", amount = 4 },
	{ type = "fluid", name = "steam",              amount = 200 }
}
recipe.results = {
	{ type = 'item',  name = 'apm_charcoal', amount = 5 },
	{ type = 'item',  name = 'apm_charcoal', amount_min = 1, amount_max = 1, probability = 0.5, show_details_in_recipe_tooltip = false },
	{ type = 'item',  name = 'sulfur',       amount_min = 1, amount_max = 1, probability = 0.35 },
	{ type = 'fluid', name = 'apm_creosote', amount = 50 }
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
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_charcoal_brick"
recipe.category = 'apm_press'


recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "apm_charcoal", amount = 8 }
}
recipe.results = {
	{ type = 'item', name = 'apm_charcoal_brick', amount = 2 }
}
recipe.main_product = 'apm_charcoal_brick'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
