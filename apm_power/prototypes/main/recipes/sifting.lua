require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/sifting.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dry_mud"
recipe.category = 'apm_coking'

recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item", name = "apm_wet_mud", amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_dry_mud', amount = 5 },
	{ type = 'fluid', name = 'steam',   amount = 50, temperature = 120 }
}
recipe.main_product = 'apm_dry_mud'
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
recipe.name = "apm_sieve_iron"

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "iron-plate", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_sieve_iron', amount = 1 }
}
recipe.main_product = 'apm_sieve_iron'
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
recipe.name = "apm_sieve_copper"

recipe.enabled = false
recipe.energy_required = 1
recipe.ingredients = {
	{ type = "item", name = "copper-plate", amount = 2 }
}
recipe.results = {
	{ type = 'item', name = 'apm_sieve_copper', amount = 1 }
}
recipe.main_product = 'apm_sieve_copper'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = { apm.lib.icons.dynamics.empty_64 } -- workaround
local item_icon_b = apm.lib.utils.icon.get.from_item('iron-ore')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.8, { 4, 0 })
local item_icon_c = apm.lib.utils.icon.get.from_item('apm_sieve_iron')
item_icon_c = apm.lib.utils.icons.mod(item_icon_c, 0.5, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dry_mud_sifting_iron"
recipe.category = 'apm_sifting_0'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_sifting"
recipe.order = 'ac_a'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item", name = "apm_dry_mud", amount = 8 },
	{ type = "item", name = "apm_sieve_iron", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'iron-ore',   amount_min = 1, amount_max = 1, probability = 0.25 },
	{ type = 'item', name = 'apm_sieve_iron', amount_min = 1, amount_max = 1, probability = 0.95, catalyst_amount = 1 }
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
local item_icon_a = { apm.lib.icons.dynamics.empty_64 } -- workaround
local item_icon_b = apm.lib.utils.icon.get.from_item('copper-ore')
item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.8, { 4, 0 })
local item_icon_c = apm.lib.utils.icon.get.from_item('apm_sieve_copper')
item_icon_c = apm.lib.utils.icons.mod(item_icon_c, 0.5, { -8, -8 })
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dry_mud_sifting_copper"
recipe.category = 'apm_sifting_0'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_sifting"
recipe.order = 'ac_b'
recipe.icons = icons

recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "item", name = "apm_dry_mud",  amount = 8 },
	{ type = "item", name = "apm_sieve_copper", amount = 1 }
}
recipe.results = {
	{ type = 'item', name = 'copper-ore',   amount_min = 1, amount_max = 1, probability = 0.25 },
	{ type = 'item', name = 'apm_sieve_copper', amount_min = 1, amount_max = 1, probability = 0.95, catalyst_amount = 1 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
