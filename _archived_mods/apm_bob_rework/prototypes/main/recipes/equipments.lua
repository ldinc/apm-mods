require('util')

local apm_power_always_show_made_in = true


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "energy-absorber"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 3.5
recipe.normal.ingredients = {
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 5),
	{ type = "item", name = "electric-engine-unit", amount = 5 },
	{ type = "item", name = "copper-plate",     amount = 10 },
	{ type = "item", name = "steel-plate",      amount = 5 }
}
recipe.normal.results = {
	{ type = 'item', name = 'energy-absorber', amount = 1 }
}
recipe.normal.main_product = 'energy-absorber'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
--recipe.expensive.ingredients = {}
--recipe.expensive.results = {}
data:extend({ recipe })
