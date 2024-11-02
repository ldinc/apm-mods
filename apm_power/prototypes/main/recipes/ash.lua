require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/ash.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_stone_brick_raw')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_generic_ash')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -9, -9 })
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_stone_brick_raw_with_ash"
recipe.category = 'apm_press'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_intermediates"
recipe.order = 'ak_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1.5
recipe.ingredients = {
	{ type = "item", name = "apm_crushed_stone", amount = 2 },
	{ type = "item", name = 'apm_generic_ash', amount = 2 },
	{ type = "fluid", name = "water",         amount = 40 }
}
recipe.results = {
	{ type = 'item', name = 'apm_stone_brick_raw', amount = 1 }
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
local item_icon_a = apm.lib.utils.icon.get.from_item('landfill')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_generic_ash')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -9, -9 })
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_landfill"
recipe.category = 'advanced-crafting'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_ash"
recipe.order = 'bc_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "stone",       amount = 15 },
	{ type = "item", name = 'apm_generic_ash', amount = 15 }
}
recipe.results = {
	{ type = 'item', name = 'landfill', amount = 2 }
}
recipe.main_product = 'landfill'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('uranium-ore')
local item_icon_b = apm.lib.utils.icon.get.from_item('apm_generic_ash')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -9, -9 })
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_ash_washing"
recipe.category = 'apm_centrifuge_1'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_ash"
recipe.order = 'bd_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 10
recipe.ingredients = {
	{ type = "item", name = 'apm_generic_ash', amount = 100 },
	{ type = "fluid", name = "sulfuric-acid", amount = 50 }
}
recipe.results = {
	{ type = 'item', name = 'uranium-ore',                amount_min = 1, amount_max = 1, probability = 0.02, show_details_in_recipe_tooltip = false },
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 50 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in
recipe.allow_decomposition = false
recipe.allow_as_intermediate = false
recipe.allow_intermediates = false

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_generic_ash')
local item_icon_b = apm.lib.utils.icon.get.from_item('coal')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -9, -9 })
local item_icon_c = { apm.lib.icons.dynamics.smelting }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_ash_production"
recipe.category = 'apm_coking'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_ash"
recipe.order = 'aa_a'
recipe.icons = icons

recipe.emissions_multiplier = 2.0
recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item", name = "apm_coal_crushed", amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_generic_ash', amount = 8 }
}
recipe.main_product = 'apm_generic_ash'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('apm_generic_ash')
local item_icon_b = apm.lib.utils.icon.get.from_item('wood')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -9, -9 })
local item_icon_c = { apm.lib.icons.dynamics.smelting }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_wood_ash_production"
recipe.category = 'apm_coking'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_ash"
recipe.order = 'aa_b'
recipe.icons = icons

recipe.emissions_multiplier = 2.0
recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item", name = "apm_wood_pellets", amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_generic_ash', amount = 8 }
}
recipe.main_product = 'apm_generic_ash'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
