require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/greenhouse.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
local target = 'apm_inline_storage_tank'

local recipe = {}
recipe.type = "recipe"
recipe.name = target

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = 'iron-plate', amount = 4 },
	{ type = "item", name = 'apm_rubber', amount = 4 },
	{ type = "item", name = 'pipe',       amount = 4 },
}
recipe.results = {
	{ type = 'item', name = target, amount = 1 }
}
recipe.main_product = target
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

data:extend({ recipe })
