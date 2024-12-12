require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/air_cleaner.lua'
local item_sounds = require("__base__.prototypes.item_sounds")

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_air_cleaner_machine_0',
	stack_size = 50,
	subgroup = "apm_power_machines_3",
	order = 'ac_a',
	place_result = "apm_air_cleaner_machine_0",
	inventory_move_sound = item_sounds.mechanical_inventory_move,
	pick_sound = item_sounds.mechanical_inventory_pickup,
	drop_sound = item_sounds.mechanical_inventory_move,

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

item.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_ac,
}

data:extend({ item })

--- [electric aircleaner]
---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_air_cleaner_machine_1',
	icons = {
		apm.lib.icons.dynamics.machine.t2,
		apm.lib.icons.dynamics.lable_ac
	},
	stack_size = 50,
	subgroup = "apm_power_machines_4",
	order = 'ac_a',
	place_result = "apm_air_cleaner_machine_1",
	inventory_move_sound = item_sounds.mechanical_inventory_move,
	pick_sound = item_sounds.mechanical_inventory_pickup,
	drop_sound = item_sounds.mechanical_inventory_move,

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })
