require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/coking_plants.lua'

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
recipe.name = "apm_coking_plant_0"

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "stone-furnace",       amount = 5 },
	{ type = "item", name = "apm_machine_frame_basic", amount = 6 },
	{ type = "item", name = "stone",               amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coking_plant_0', amount = 1 }
}
recipe.main_product = 'apm_coking_plant_0'
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
recipe.name = "apm_coking_plant_1"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	-- {type="item", name="apm_coking_plant_0", amount=1},
	{ type = "item", name = "stone-brick",         amount = 20 },
	{ type = "item", name = "apm_machine_frame_basic", amount = 3 },
	{ type = "item", name = "copper-plate",        amount = 5 },
	{ type = "item", name = "steel-plate",         amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coking_plant_1', amount = 1 }
}
recipe.main_product = 'apm_coking_plant_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if reusable then
	table.insert(recipe.ingredients, 'apm_coking_plant_0')
end

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_coking_plant_2"

recipe.enabled = false
recipe.energy_required = 6
recipe.ingredients = {
	{ type = "item", name = "concrete",               amount = 25 },
	{ type = "item", name = "pipe",                   amount = 25 },
	{ type = "item", name = "apm_machine_frame_advanced", amount = 3 },
	{ type = "item", name = "copper-plate",           amount = 25 },
	{ type = "item", name = "steel-plate",            amount = 25 }
}
recipe.results = {
	{ type = 'item', name = 'apm_coking_plant_2', amount = 1 }
}
recipe.main_product = 'apm_coking_plant_2'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if reusable then
	table.insert(recipe.ingredients, 'apm_coking_plant_1')
end

data:extend({ recipe })
