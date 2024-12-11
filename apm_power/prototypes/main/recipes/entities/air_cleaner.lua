require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/air_cleaner.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_air_cleaner_machine_0"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "apm_steam_engine",        amount = 5 },
	{ type = "item", name = "apm_machine_frame_steam", amount = 6 },
	{ type = "item", name = "stone-brick",             amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_air_cleaner_machine_0', amount = 1 }
}
recipe.main_product = 'apm_air_cleaner_machine_0'
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
recipe.name = "apm_air_cleaner_machine_1"
recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "stone-brick",                amount = 20 },
	{ type = "item", name = "apm_steam_engine",           amount = 5 },
	{ type = "item", name = "electronic-circuit",         amount = 5 },
	{ type = "item", name = "apm_machine_frame_advanced", amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_air_cleaner_machine_1', amount = 1 }
}
recipe.main_product = 'apm_air_cleaner_machine_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, 'apm_air_cleaner_machine_0', 1)
end

data:extend({ recipe })
