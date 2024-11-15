require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/furnaces.lua'

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
recipe.name = "apm_puddling_furnace_0"

recipe.enabled = false
recipe.energy_required = 2
recipe.ingredients = {
	{ type = "item", name = "stone-furnace",           amount = 3 },
	{ type = "item", name = "apm_machine_frame_basic", amount = 10 },
	{ type = "item", name = "stone-brick",             amount = 25 }
}
recipe.results = {
	{ type = 'item', name = 'apm_puddling_furnace_0', amount = 1 }
}
recipe.main_product = 'apm_puddling_furnace_0'
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
recipe.name = "apm_steelworks_0"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "stone-brick",                amount = 25 },
	{ type = "item", name = "stone-furnace",              amount = 10 },
	{ type = "item", name = "electronic-circuit",         amount = 25 },
	{ type = "item", name = "copper-plate",               amount = 30 },
	{ type = "item", name = "apm_machine_frame_advanced", amount = 10 }
}
recipe.results = {
	{ type = 'item', name = 'apm_steelworks_0', amount = 1 }
}
recipe.main_product = 'apm_steelworks_0'
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
recipe.name = "apm_steelworks_1"

recipe.enabled = false
recipe.energy_required = 4
recipe.ingredients = {
	{ type = "item", name = "refined-concrete",           amount = 10 },
	-- {type="item", name="apm_steelworks_0", amount=1},
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 10),
	{ type = "item", name = "low-density-structure",      amount = 20 },
	{ type = "item", name = "apm_machine_frame_advanced", amount = 10 },
	{ type = "item", name = "electric-furnace",           amount = 6 },
}
recipe.results = {
	{ type = 'item', name = 'apm_steelworks_1', amount = 1 }
}
recipe.main_product = 'apm_steelworks_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_power_always_show_made_in

if reusable then
	table.insert(recipe.ingredients, 'apm_steelworks_0')
end

data:extend({ recipe })
