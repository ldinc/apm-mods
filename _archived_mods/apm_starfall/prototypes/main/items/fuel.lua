require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/items/fuel.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_alien_fuel_mixture'
item.icons = {
    apm.starfall.icons.alien_fuel_mixture
}
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_fuel"
item.order = 'aa_a'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_alien_fuel_case'
item.icons = {
    apm.starfall.icons.alien_fuel_case
}
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_fuel"
item.order = 'aa_b'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_alien_fuel'
item.icons = {
    apm.starfall.icons.alien_fuel
}
item.localised_description={'item-description.apm_alien_fuel'}
item.stack_size = 200
item.fuel_emissions_multiplier = 0.01
item.fuel_category = 'apm_starfall_alien'
item.fuel_value = "1MJ"
item.burnt_result = 'apm_alien_fuel_burnted'
item.group = "apm_starfall"
item.subgroup = "apm_starfall_fuel"
item.order = 'aa_c'
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_alien_fuel_burnted'
item.icons = {
    apm.starfall.icons.alien_fuel_burnted
}
item.stack_size = 200
item.group = "apm_starfall"
item.subgroup = "apm_starfall_fuel"
item.order = 'aa_d'
data:extend({item})
