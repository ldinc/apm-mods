require('util')
require('__apm_lib_ldinc__.lib.log')

local item_sounds = require("__base__.prototypes.item_sounds")

local self = 'apm_power/prototypes/main/items/air_cleaner.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_filter_charcoal'
item.icons = {
	apm.power.icons.filter_charcoal
}
item.stack_size = 200
item.group = "apm_power"
item.subgroup = "apm_power_tools"
item.order = 'ab_a'
item.inventory_move_sound = item_sounds.metal_small_inventory_move
item.pick_sound = item_sounds.metal_small_inventory_pickup
item.drop_sound = item_sounds.metal_small_inventory_move
data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_filter_charcoal_used'
item.icons = {
	apm.power.icons.filter_charcoal_used
}
item.stack_size = 200
item.group = "apm_power"
item.subgroup = "apm_power_tools"
item.order = 'ab_b'
item.inventory_move_sound = item_sounds.metal_small_inventory_move
item.pick_sound = item_sounds.metal_small_inventory_pickup
item.drop_sound = item_sounds.metal_small_inventory_move
data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_ammonium_sulfate'
item.icons = {
	apm.power.icons.ammonium_sulfate
}
item.stack_size = 200
item.group = "apm_power"
item.subgroup = "apm_greenhouse"
item.order = 'ab_c'
item.inventory_move_sound = item_sounds.resource_inventory_move
item.pick_sound = item_sounds.resource_inventory_pickup
item.drop_sound = item_sounds.resource_inventory_move
data:extend({ item })
