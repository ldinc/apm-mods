require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/assembling_machines.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_assembling_machine_0"

recipe.enabled = true
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "stone-furnace",           amount = 1 },
	{ type = "item", name = "apm_simple_engine",       amount = 2 },
	{ type = "item", name = "apm_machine_frame_basic", amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_assembling_machine_0', amount = 1 }
}
recipe.main_product = 'apm_assembling_machine_0'
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
recipe.name = "apm_assembling_machine_1"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	-- {type="item", name="apm_assembling_machine_0", amount=1},
	{ type = "item", name = "apm_steam_engine",        amount = 2 },
	{ type = "item", name = "apm_machine_frame_steam", amount = 3 },
	{ type = "item", name = "stone-brick",             amount = 15 }
}
recipe.results = {
	{ type = 'item', name = 'apm_assembling_machine_1', amount = 1 }
}
recipe.main_product = 'apm_assembling_machine_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, 'apm_assembling_machine_0', 1)
end

data:extend({ recipe })
