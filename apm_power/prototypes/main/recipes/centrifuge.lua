require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/centrifuge.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_fluid('apm_sea_water')
local item_icon_b = apm.lib.utils.icon.get.from_fluid('water')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, 8 })
local item_icon_c = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_seawater_centrifuging"
recipe.category = 'apm_centrifuge_0'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_fluid"
recipe.order = 'ad_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "fluid", name = "apm_sea_water", amount = 200 }
}
recipe.results = {
	{ type = "item",  name = "apm_wet_mud", amount_min = 1, amount_max = 1, probability = 0.5 },
	{ type = "fluid", name = "water",       amount = 195 },
	{ type = "item",  name = "raw-fish",    amount_min = 1, amount_max = 1, probability = 0.0001, show_details_in_recipe_tooltip = false }
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
local item_icon_a = apm.lib.utils.icon.get.from_fluid('apm_dirt_water')
local item_icon_b = apm.lib.utils.icon.get.from_fluid('water')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, 8 })
local item_icon_c = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dirty_water_purification"
recipe.category = 'apm_centrifuge_0'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_fluid"
recipe.order = 'ad_c'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 5.5
recipe.ingredients = {
	{ type = "fluid", name = "apm_dirt_water", amount = 200 }
}
recipe.results = {
	{ type = "fluid", name = "water", amount = 180 },
	apm.lib.utils.builder.recipe.item.simple('APM_SLAG', 2, 0, 5),
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
local item_icon_a = apm.lib.utils.icon.get.from_fluid('apm_coal_saturated_wastewater')
local item_icon_b = apm.lib.utils.icon.get.from_fluid('water')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, 8 })
local item_icon_c = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coal_saturated_wastewater_seperation"
recipe.category = 'apm_centrifuge_0'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_fluid"
recipe.order = 'ad_d'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 6.5
recipe.ingredients = {
	{ type = "fluid", name = "apm_coal_saturated_wastewater", amount = 100 }
}
recipe.results = {
	{ type = "fluid", name = "water", amount = 80 },
	{ type = "item",  name = "coal",  amount = 2, show_details_in_recipe_tooltip = false }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in
recipe.allow_decomposition = false
recipe.allow_as_intermediate = false
recipe.allow_intermediates = false

data:extend({ recipe })
