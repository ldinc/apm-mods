require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/puddling_furnace.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('steel-plate')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local item_icon_c = { apm.lib.icons.dynamics.smelting }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_steel_0"
recipe.category = 'apm_puddling_furnace'
recipe.group = "apm_power"
recipe.subgroup = "apm_power_smelting"
recipe.order = 'ab_b'
recipe.icons = icons
recipe.crafting_machine_tint = {
	primary = { r = 0.720, g = 0.720, b = 0.720, a = 1.000 },
	secondary = { r = 0.720, g = 0.720, b = 0.720, a = 1.000 },
	tertiary = { r = 0.720, g = 0.720, b = 0.720, a = 1.000 },
	quaternary = { r = 0.720, g = 0.720, b = 0.720, a = 1.000 },
}

recipe.enabled = false
recipe.energy_required = 35
recipe.ingredients = {
	{ type = "item", name = "apm_stone_crucible", amount = 4 },
	{ type = "item", name = "apm_coke_crushed", amount = 10 },
	{ type = "item", name = "iron-ore",        amount = 20 },
	{ type = "fluid", name = "water",          amount = 50, fluidbox_index = 1 }
}
recipe.results = {
	{ type = 'item', name = 'steel-plate', amount = 4 }
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
