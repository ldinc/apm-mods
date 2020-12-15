require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/recipes/entities.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_always_show_made_in = settings.startup["apm_energy_addon_always_show_made_in"].value
APM_LOG_SETTINGS(self, 'apm_energy_addon_always_show_made_in', apm_energy_addon_always_show_made_in)

-- Recipe ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local recipe = {}
recipe.type = "recipe"
recipe.name = "apm_battery_charging_station"
recipe.normal = {}
recipe.normal.enabled = false
recipe.normal.energy_required = 0.5
recipe.normal.ingredients = {
        {type="item", name="assembling-machine-2", amount=1},
        {type="item", name="copper-cable", amount=20},
        {type="item", name="steel-plate", amount=6},
        apm.lib.utils.builder.recipe.item.simple('APM_CIRCUIT_T3', 15)
    }
recipe.normal.results = { 
        {type='item', name='apm_battery_charging_station', amount=1}
    }
recipe.normal.main_product = 'apm_battery_charging_station'
recipe.normal.requester_paste_multiplier = 4
recipe.normal.always_show_products = true
recipe.normal.always_show_made_in = apm_energy_addon_always_show_made_in
--recipe.normal.allow_decomposition = false
--recipe.normal.allow_as_intermediate = false
--recipe.normal.allow_intermediates = false
recipe.expensive = table.deepcopy(recipe.normal)
--recipe.expensive.energy_required = 
--recipe.expensive.ingredients = {}
--recipe.expensive.results = {}
data:extend({recipe})
