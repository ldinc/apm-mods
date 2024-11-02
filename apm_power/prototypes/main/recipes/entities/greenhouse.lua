require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/greenhouse.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)
local reusable = apm.lib.utils.setting.get.starup('apm_power_machine_reusable_recipies')
APM_LOG_SETTINGS(self, 'apm_power_machine_reusable_recipies', reusable)


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_greenhouse_0"

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "stone-furnace",       amount = 1 },
	{ type = "item", name = "apm_machine_frame_basic", amount = 6 },
	{ type = "item", name = "stone-brick",         amount = 15 }
}
recipe.results = {
	{ type = 'item', name = 'apm_greenhouse_0', amount = 1 }
}
recipe.main_product = 'apm_greenhouse_0'
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
recipe.name = "apm_greenhouse_1"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	-- {type="item", name="apm_greenhouse_0", amount=1},
	{ type = "item", name = "stone-brick",         amount = 10 },
	{ type = "item", name = "apm_steam_engine",    amount = 2 },
	{ type = "item", name = "apm_machine_frame_steam", amount = 6 }
}
recipe.results = {
	{ type = 'item', name = 'apm_greenhouse_1', amount = 1 }
}
recipe.main_product = 'apm_greenhouse_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if reusable then
	table.insert(recipe.ingredients, 'apm_greenhouse_0')
end

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_greenhouse_2"

recipe.enabled = false
recipe.energy_required = 6
recipe.ingredients = {
	-- {type="item", name="apm_greenhouse_1", amount=1},
	{ type = "item", name = "stone-brick",            amount = 10 },
	{ type = "item", name = 'small-lamp',             amount = 10 },
	{ type = "item", name = "electric-engine-unit",   amount = 5 },
	{ type = "item", name = "electronic-circuit",     amount = 5 },
	{ type = "item", name = "apm_machine_frame_advanced", amount = 3 }
}
recipe.results = {
	{ type = 'item', name = 'apm_greenhouse_2', amount = 1 }
}
recipe.main_product = 'apm_greenhouse_2'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if reusable then
	table.insert(recipe.ingredients, 'apm_greenhouse_1')
end

data:extend({ recipe })
