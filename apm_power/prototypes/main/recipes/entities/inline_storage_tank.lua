require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes/entities/greenhouse.lua'

APM_LOG_HEADER(self)

local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)
local reusable =  apm.lib.utils.setting.get.starup('apm_power_machine_reusable_recipies')
APM_LOG_SETTINGS(self, 'apm_power_machine_reusable_recipies', reusable)


-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------
local target = 'apm_inline_storage_tank'

local recipe = {}
recipe.type = "recipe"
recipe.name = target
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 4
recipe.normal.ingredients = {
    { type = "item", name = 'iron-plate', amount = 4 },
    { type = "item", name = 'apm_rubber', amount = 4 },
    { type = "item", name = 'pipe', amount = 4 },
}
recipe.normal.results = {
    { type = 'item', name = target, amount = 1 }
}
recipe.normal.main_product = target
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_power_always_show_made_in
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required =
recipe.expensive.ingredients = {
    { type = "item", name = 'iron-plate', amount = 6 },
    { type = "item", name = 'apm_rubber', amount = 6 },
    { type = "item", name = 'pipe', amount = 6 },
}
--recipe.expensive.results = {}
data:extend({ recipe })
