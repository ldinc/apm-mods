require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/recipes/science.lua"

APM_LOG_HEADER(self)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_industrial_science_pack")
local icons       = apm.lib.utils.icon.merge({ item_icon_a })


---@type data.RecipePrototype
local recipe                      = {
	type = "recipe",
	name = "apm_industrial_science_pack_0"
}

recipe.categories                 = { "apm_handcrafting_only" }
recipe.subgroup                   = "apm_power_science"
recipe.order                      = "aa_a"
recipe.icons                      = icons
recipe.allow_as_intermediate      = true
recipe.allow_intermediates        = true

recipe.enabled                    = true
recipe.energy_required            = 10
recipe.ingredients                = {
	{ type = "item", name = "apm_mechanical_relay", amount = 2 },
	{ type = "item", name = "stone",                amount = 10 }
}

recipe.results                    = {
	{ type = "item", name = "apm_industrial_science_pack", amount = 1 }
}

recipe.main_product               = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in        = apm.lib.features.show.made_in

data:extend({ recipe })

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item("apm_industrial_science_pack")
local icons = apm.lib.utils.icon.merge({ item_icon_a })

---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_industrial_science_pack_1"
}
recipe.categories = { "crafting" }
recipe.subgroup = "apm_power_science"
recipe.order = "aa_b"
recipe.icons = icons

recipe.enabled = true
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item", name = "apm_mechanical_relay", amount = 1 },
	{ type = "item", name = "stone-brick",          amount = 1 }
}
recipe.results = {
	{ type = "item", name = "apm_industrial_science_pack", amount = 1 }
}
recipe.main_product = ""
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.RecipePrototype
local recipe = {
	type = "recipe",
	name = "apm_steam_science_pack"
}

recipe.categories = { "crafting-with-fluid" }
--recipe.icons = icons

recipe.enabled = true
recipe.energy_required = 5
recipe.ingredients = {
	{ type = "item",  name = "apm_steam_relay", amount = 1 },
	{ type = "item",  name = "apm_rubber",      amount = 1 },
	{ type = "fluid", name = "steam",           amount = 100 }
}
recipe.results = {
	{ type = "item", name = "apm_steam_science_pack", amount = 1 }
}
recipe.main_product = "apm_steam_science_pack"
recipe.requester_paste_multiplier = 4
recipe.always_show_made_in = apm.lib.features.show.made_in

data:extend({ recipe })
