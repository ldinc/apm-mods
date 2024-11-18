require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/ore.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
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
	stack_size = 200,
	subgroup = "apm_nuclear_ore",
	order = "aa_a",
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
	icons = {
		apm.nuclear.icons.thorium_ore
	},
	pictures = {
		apm.nuclear.icons.thorium_ore,
		apm.nuclear.icons.thorium_ore_1,
		apm.nuclear.icons.thorium_ore_2,
		apm.nuclear.icons.thorium_ore_3
	},
	stack_size = 200,
	subgroup = "apm_nuclear_ore",
	order = "aa_b",
}

data:extend({ item })
