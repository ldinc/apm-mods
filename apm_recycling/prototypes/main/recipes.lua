require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/recipes.lua'

APM_LOG_HEADER(self)

local apm_recycler_always_show_made_in = settings.startup["apm_recycler_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_recycler_always_show_made_in', apm_recycler_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_recycling_machine_0"

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T0', 5),
	{ type = "item", name = "copper-plate", amount = 10 },
	{ type = "item", name = "iron-plate",   amount = 10 },
	apm.lib.utils.builder.recipe.item.simple('APM_GEAR_T0', 3),
	{ type = "item", name = "stone-brick", amount = 25 }
}
recipe.results = {
	{ type = 'item', name = 'apm_recycling_machine_0', amount = 1 }
}
recipe.main_product = 'apm_recycling_machine_0'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_recycling_machine_1"

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "apm_recycling_machine_0", amount = 1 },
	{ type = "item", name = "storage-tank",            amount = 1 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 20),
	apm.lib.utils.builder.recipe.item.simple('APM_GEAR_T1', 5),
}
recipe.results = {
	{ type = 'item', name = 'apm_recycling_machine_1', amount = 1 }
}
recipe.main_product = 'apm_recycling_machine_1'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_recycling_machine_2"

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "apm_recycling_machine_1", amount = 1 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 20),
	apm.lib.utils.builder.recipe.item.simple('APM_GEAR_T2', 7),
	{ type = "item", name = "speed-module",            amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_recycling_machine_2', amount = 1 }
}
recipe.main_product = 'apm_recycling_machine_2'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_recycling_machine_3"

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "apm_recycling_machine_2", amount = 1 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T5', 20),
	apm.lib.utils.builder.recipe.item.simple('APM_GEAR_T3', 9),
	{ type = "item", name = "efficiency-module-2",    amount = 5 }
}
recipe.results = {
	{ type = 'item', name = 'apm_recycling_machine_3', amount = 1 }
}
recipe.main_product = 'apm_recycling_machine_3'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_cleaning_solution"
recipe.category = 'apm_recycling_1'

local fluid = data.raw.fluid['apm_cleaning_solution']
recipe.crafting_machine_tint = {
	primary    = fluid.base_color,
	secondary  = fluid.flow_color,
	tertiary   = fluid.base_color,
	quaternary = { r = 0.780, g = 0.780, b = 0.047 }
}

recipe.enabled = false
recipe.energy_required = 5
recipe.ingredients = {
	apm.lib.utils.builder.recipe.item.simple('APM_CLEANING_SOLUTION', 3),
	{ type = "fluid", name = "water", amount = 100 }
}
recipe.results = {
	{ type = "fluid", name = "apm_cleaning_solution", amount = 100 }
}
recipe.main_product = 'apm_cleaning_solution'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local fluid_icon = apm.lib.utils.icon.get.from_fluid('apm_dirty_cleaning_solution')
local item_icon = { apm.lib.icons.dynamics.recycling }
local icons = apm.lib.utils.icon.merge({ fluid_icon, item_icon })

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_dirty_cleaning_solution_reprocessing"
recipe.category = 'apm_recycling_1'
recipe.icons = icons

recipe.subgroup = "apm_recycling_fluid"
recipe.order = 'aa_c'

local fluid = data.raw.fluid['apm_cleaning_solution']
recipe.crafting_machine_tint = {
	primary    = fluid.base_color,
	secondary  = fluid.flow_color,
	tertiary   = fluid.base_color,
	quaternary = { r = 0.780, g = 0.780, b = 0.047 }
}

recipe.enabled = false
recipe.energy_required = 3
recipe.ingredients = {
	{ type = "fluid", name = "apm_dirty_cleaning_solution", amount = 100 }
}
recipe.results = {
	{ type = "fluid", name = "apm_cleaning_solution", amount = 50 },
	apm.lib.utils.builder.recipe.item.simple('APM_SLAG', 1)
}
recipe.main_product = ''
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.allow_decomposition = false
recipe.allow_as_intermediate = false
recipe.allow_intermediates = false
recipe.always_show_made_in = apm_recycler_always_show_made_in

data:extend({ recipe })
