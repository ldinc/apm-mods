require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/items/entities/air_cleaner.lua'
local item_sounds = require("__base__.prototypes.item_sounds")

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_air_cleaner_machine_0'
item.icons = {
	apm.lib.icons.dynamics.machine.t1,
	apm.lib.icons.dynamics.lable_ac
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_3"
item.order = 'ac_a'
item.place_result = "apm_air_cleaner_machine_0"
item.inventory_move_sound = item_sounds.mechanical_inventory_move
item.pick_sound = item_sounds.mechanical_inventory_pickup
item.drop_sound = item_sounds.mechanical_inventory_move
data:extend({ item })

------
local item = {}
item.type = 'item'
item.name = 'apm_air_cleaner_machine_1'
item.icons = {
	apm.lib.icons.dynamics.machine.t2,
	apm.lib.icons.dynamics.lable_ac
}
item.stack_size = 50
item.group = "apm_power"
item.subgroup = "apm_power_machines_4"
item.order = 'ac_a'
item.place_result = "apm_air_cleaner_machine_1"
item.inventory_move_sound = item_sounds.mechanical_inventory_move
item.pick_sound = item_sounds.mechanical_inventory_pickup
item.drop_sound = item_sounds.mechanical_inventory_move
data:extend({ item })
