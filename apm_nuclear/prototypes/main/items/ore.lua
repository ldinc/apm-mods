require("util")
require("__apm_lib_ldinc__.lib.log")

local item_sounds = require("__base__.prototypes.item_sounds")

local self = "apm_nuclear/prototypes/main/items/ore.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fluorite_ore",
	icons = {
		apm.nuclear.icons.fluorite
	},
	pictures = {
		apm.nuclear.icons.fluorite,
		apm.nuclear.icons.fluorite_1,
		apm.nuclear.icons.fluorite_2,
		apm.nuclear.icons.fluorite_3
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_ore",
	order = "aa_a",

	weight = apm.lib.utils.constants.value.weight.ore,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "thorium-ore",
	icon = apm.nuclear.icons.thorium_ore.icon,
	-- icons = {
	-- 	apm.nuclear.icons.thorium_ore
	-- },
	pictures = {
		{
			layers = { apm.nuclear.icons.thorium_ore },
		},
		{
			layers = {apm.nuclear.icons.thorium_ore_1},
		},
		{
			layers = {apm.nuclear.icons.thorium_ore_2},
		},
		{
			layers = {apm.nuclear.icons.thorium_ore_3},
		},
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_ore",
	order = "aa_b",
	inventory_move_sound = item_sounds.nuclear_inventory_move,
	pick_sound = item_sounds.nuclear_inventory_pickup,
	drop_sound = item_sounds.nuclear_inventory_move,

	weight = 5 * kg,
}

data:extend({ item })
