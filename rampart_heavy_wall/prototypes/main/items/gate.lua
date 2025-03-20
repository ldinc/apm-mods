local item_sounds = require("__base__.prototypes.item_sounds")

require("lib.const")

local name = rampant_heavy_wall.lib.const.gate.name
local tint = rampant_heavy_wall.lib.const.gate.tint

---@type data.ItemPrototype
local item = {
	type = "item",
	name = name,
	icons = {
		{
			icon = "__base__/graphics/icons/gate.png",
			tint = tint,
		}
	},
	subgroup = "defensive-structure",
	order = "a[heavy-wall]-b[heavy-gate]",
	inventory_move_sound = item_sounds.concrete_inventory_move,
	pick_sound = item_sounds.concrete_inventory_pickup,
	drop_sound = item_sounds.concrete_inventory_move,
	place_result = name,
	stack_size = 50,

	weight = 10000,
}

data:extend({ item })
