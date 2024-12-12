require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_energy_addon/prototypes/main/items/entities.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('car')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
local item_car = data.raw['item-with-entity-data']['car']

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_electric_car",
	stack_size = item_car.stack_size,
	icons = icons,
	subgroup = item_car.subgroup,
	order = item_car.order .. "z",
	place_result = "apm_electric_car",

	weight = item_car.weight,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('tank')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
local item_tank = data.raw['item-with-entity-data']['tank']

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_electric_tank",
	icons = icons,
	subgroup = item_tank.subgroup,
	order = item_tank.order .. "z",
	place_result = "apm_electric_tank",
	stack_size = item_tank.stack_size,

	weight = item_tank.weight,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item_icon_a = apm.lib.utils.icon.get.from_item('locomotive')
local item_icon_b = { apm.lib.icons.dynamics.t2 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
local item_locomotive = data.raw['item-with-entity-data']['locomotive']

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_electric_locomotive",
	icons = icons,
	stack_size = item_locomotive.stack_size,
	subgroup = item_locomotive.subgroup,
	order = item_locomotive.order .. "z",
	place_result = "apm_electric_locomotive",

	weight = item_locomotive.weight,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_battery_charging_station",
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_lightning,
		apm.lib.icons.dynamics.recycling
	},
	stack_size = 10,
	subgroup = "production-machine",
	order = "d[apm_battery_charging_station]",
	place_result = "apm_battery_charging_station",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_battery_discharging_station",
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_lightning
	},
	stack_size = 10,
	subgroup = "production-machine",
	order = "d[apm_battery_discharging_station]",
	place_result = "apm_battery_discharging_station",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_equipment_energy_transmitter",
	icons = {
		apm.power.icons.apm_equipment_energy_transmitter
	},
	stack_size = 20,
	subgroup = "equipment",
	order = "a[energy-source]-b[apm-a]",
	place_as_equipment_result = "apm_equipment_energy_transmitter",

	weight = apm.lib.utils.constants.value.weight.equipment.light,
}

data:extend({ item })

-- Equipment ------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

---@type data.GeneratorEquipmentPrototype
local equipment = {
	type = "generator-equipment",
	name = "apm_equipment_energy_transmitter",
	sprite = {
		filename = apm.power.icons.item_equipment_energy_transmitter.icon,
		width = apm.power.icons.item_equipment_energy_transmitter.icon_size,
		height = apm.power.icons.item_equipment_energy_transmitter.icon_size,
		priority = "medium",
	},
	shape = {
		width = 1,
		height = 1,
		type = "full",
	},
	energy_source = {
		type = "electric",
		usage_priority = "secondary-output",
	},
	power = "200kW",
	categories = { "armor" },
	burner = {
		type = "burner",
		fuel_categories = { 'apm_electrical' },
		fuel_inventory_size = 2,
		burnt_inventory_size = 2,
	},
}

data:extend({ equipment })
