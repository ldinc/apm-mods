require('util')
require('__apm_lib_ldinc__.lib.log')

local item_sounds = require("__base__.prototypes.item_sounds")

local self = 'apm_power/prototypes/main/items/ash.lua'

APM_LOG_HEADER(self)

local stack_size = apm.lib.features.stack_size.ash

if stack_size == nil or stack_size == 0 then
	stack_size = 2000
end

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = 'apm_generic_ash',
	icons = {
		apm.power.icons.generic_ash
	},
	stack_size = stack_size,
	subgroup = "apm_power_ash",
	order = 'aa_a',
	inventory_move_sound = item_sounds.resource_inventory_move,
	pick_sound = item_sounds.resource_inventory_pickup,
	drop_sound = item_sounds.resource_inventory_move,

	weight = apm.lib.utils.constants.value.weight.product.ash,
}

data:extend({ item })
