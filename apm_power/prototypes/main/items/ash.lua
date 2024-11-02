require('util')
require('__apm_lib_ldinc__.lib.log')

local item_sounds = require("__base__.prototypes.item_sounds")

local self = 'apm_power/prototypes/main/items/ash.lua'

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local item = {}
item.type = 'item'
item.name = 'apm_generic_ash'
item.icons = {
	apm.power.icons.generic_ash
}
item.stack_size = 2000
item.group = "apm_power"
item.subgroup = "apm_power_ash"
item.order = 'aa_a'
item.inventory_move_sound = item_sounds.resource_inventory_move
item.pick_sound = item_sounds.resource_inventory_pickup
item.drop_sound = item_sounds.resource_inventory_move
data:extend({ item })
