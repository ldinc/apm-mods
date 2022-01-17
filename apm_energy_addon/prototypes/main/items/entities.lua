require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/items/entities.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('car')
local item_icon_b = {apm.lib.icons.dynamics.t2}
local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
local item_car = data.raw['item-with-entity-data']['car']
local item = {}
item.type = 'item'
item.name = 'apm_electric_car'
item.icons = icons
item.stack_size = item_car.stack_size
item.group = item_car.group
item.subgroup = item_car.subgroup
item.order = item_car.order .. 'z'
item.place_result = "apm_electric_car"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('tank')
local item_icon_b = {apm.lib.icons.dynamics.t2}
local icons = apm.lib.utils.icon.merge({item_icon_a, item_icon_b})
local item_tank = data.raw['item-with-entity-data']['tank']
local item = {}
item.type = 'item'
item.name = 'apm_electric_tank'
item.icons = icons
item.stack_size = item_tank.stack_size
item.group = item_tank.group
item.subgroup = item_tank.subgroup
item.order = item_tank.order .. 'z'
item.place_result = "apm_electric_tank"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_battery_charging_station'
item.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_lightning,
	apm.lib.icons.dynamics.recycling
    }
item.stack_size = 10
item.subgroup = "production-machine"
item.order = "d[apm_battery_charging_station]"
item.place_result = "apm_battery_charging_station"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_battery_discharging_station'
item.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_lightning
    }
item.stack_size = 10
item.subgroup = "production-machine"
item.order = "d[apm_battery_discharging_station]"
item.place_result = "apm_battery_discharging_station"
data:extend({item})

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_equipment_energy_transmitter'
item.icons = {
    apm.power.icons.apm_equipment_energy_transmitter
}
item.stack_size = 20
--item.group = "apm_other"
item.subgroup = "equipment"
item.order = "a[energy-source]-b[apm-a]"
item.placed_as_equipment_result = "apm_equipment_energy_transmitter"
data:extend({item})

-- Equipment ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local equipment = {}
equipment.type = "generator-equipment"
equipment.name = "apm_equipment_energy_transmitter"
equipment.sprite = {}
equipment.sprite.filename = apm.power.icons.item_equipment_energy_transmitter.icon
equipment.sprite.width = apm.power.icons.item_equipment_energy_transmitter.icon_size
equipment.sprite.height = apm.power.icons.item_equipment_energy_transmitter.icon_size
equipment.sprite.priority = "medium"
equipment.shape = {}
equipment.shape.width = 1
equipment.shape.height = 1
equipment.shape.type = "full"
equipment.energy_source = {}
equipment.energy_source.type = "electric"
equipment.energy_source.usage_priority = "secondary-output"
equipment.power = "200kW"
equipment.categories = {"armor"}
equipment.burner = {}
equipment.burner.fuel_categories = {'apm_electrical'}
equipment.burner.fuel_inventory_size = 2
equipment.burner.burnt_inventory_size = 2
equipment.burner.emissions_per_minute = 0
equipment.burner.type = "burner"
data:extend({equipment})
