local item_sounds = require("__base__.prototypes.item_sounds")

require("lib.const")

local name = rampant_heavy_wall.lib.const.wall.name
local tint = rampant_heavy_wall.lib.const.wall.tint

---@type data.ItemPrototype
local item = {
	type = 'item',
	name = name,
	icons = {
		{
			icon = "__base__/graphics/icons/wall.png",
			tint = tint,
		},
	},
	stack_size = 100,
	subgroup = "defensive-structure",
	place_result = name,
	order = "a[heavy-wall]-a[heavy-wall]",
	inventory_move_sound = item_sounds.concrete_inventory_move,
	pick_sound = item_sounds.concrete_inventory_pickup,
	drop_sound = item_sounds.concrete_inventory_move,

	weight = 10000,
}

data:extend({ item })
