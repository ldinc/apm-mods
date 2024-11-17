require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_energy_addon/prototypes/main/generate.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_always_show_made_in = settings.startup["apm_energy_addon_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_energy_addon_always_show_made_in', apm_energy_addon_always_show_made_in)

-- Generators -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.lib.utils.batteries.generate(
	1,
	'battery',
	apm.energy_addon.constants.fuel_value.battery_vanilla,
	apm.energy_addon.icons.depleted_battery_overlay,
	0.85,
	'battery'
)

apm.energy_addon.generate_electric_powered('car')

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_electric_car"

recipe.enabled = false
recipe.energy_required = 0.5
recipe.ingredients = {
	{ type = "item", name = "car",                  amount = 1 },
	{ type = "item", name = "electric-engine-unit", amount = 8 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 20)
}
recipe.results = {
	{ type = 'item', name = 'apm_electric_car', amount = 1 }
}
recipe.main_product = 'apm_electric_car'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_energy_addon_always_show_made_in

data:extend({ recipe })

-- Technologie ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.TechnologyPrototype
local technology = {
	name = 'automobilism_electric-1'
}

technology.type = 'technology'
technology.icon = '__base__/graphics/technology/automobilism.png'
technology.icon_size = 256
technology.effects = {
	{ type = 'unlock-recipe', recipe = 'apm_electric_car' },
}
technology.prerequisites = { 'automobilism', 'electric-engine', 'battery' }

technology.unit = {
	ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 } },
	time = 30,
	count = 125,
}

technology.order = 'aa_a'
data:extend({ technology })

--
-- ==========================================================================================
--

apm.energy_addon.generate_electric_powered('tank')

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_electric_tank"

recipe.enabled = false
recipe.energy_required = 0.5
recipe.ingredients = {
	{ type = "item", name = "tank",                 amount = 1 },
	{ type = "item", name = "electric-engine-unit", amount = 32 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T4', 20)
}
recipe.results = {
	{ type = 'item', name = 'apm_electric_tank', amount = 1 }
}
recipe.main_product = 'apm_electric_tank'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_energy_addon_always_show_made_in

data:extend({ recipe })

-- Technologie ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.TechnologyPrototype
local technology = {
	name = 'tanks_electric-1'
}

technology.type = 'technology'
technology.icon = '__base__/graphics/technology/tank.png'
technology.icon_size = 256
technology.effects = {
	{ type = 'unlock-recipe', recipe = 'apm_electric_tank' },
}
-- technology.prerequisites = {'tanks', 'electric-engine', 'battery'}
technology.prerequisites = { 'tank', 'electric-engine', 'battery' }
technology.unit = {
	count = 275,
	ingredients = {
		{ "automation-science-pack", 1 },
		{ "logistic-science-pack",   1 },
		{ "military-science-pack",   1 },
		{ "chemical-science-pack",   1 },
	},
	time = 30,
}

technology.order = 'aa_a'
data:extend({ technology })


apm.energy_addon.generate_electric_powered_locomotive('locomotive')
-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.RecipePrototype
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_electric_locomotive"

recipe.enabled = false
recipe.energy_required = 0.5
recipe.ingredients = {
	{ type = "item", name = "locomotive",           amount = 1 },
	{ type = "item", name = "electric-engine-unit", amount = 8 },
	apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 20)
}
recipe.results = {
	{ type = 'item', name = 'apm_electric_locomotive', amount = 1 }
}
recipe.main_product = 'apm_electric_locomotive'
recipe.requester_paste_multiplier = 4
recipe.always_show_products = true
recipe.always_show_made_in = apm_energy_addon_always_show_made_in

data:extend({ recipe })

-- Technologie ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.TechnologyPrototype
local technology = {
	name = 'locomotive_electric'
}

technology.type = 'technology'
technology.icon = '__base__/graphics/technology/railway.png'
technology.icon_size = 256

technology.effects = {
	{ type = 'unlock-recipe', recipe = 'apm_electric_locomotive' },
}
technology.prerequisites = { 'railway', 'electric-engine', 'battery' }
technology.unit = {
	count = 125,
	ingredients = { { "automation-science-pack", 1 }, { "logistic-science-pack", 1 } },
	time = 30,
}

technology.order = 'aa_a'
data:extend({ technology })
