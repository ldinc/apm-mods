require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/hexafluoride.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_yellowcake",
	icons = {
		apm.nuclear.icons.yellowcake
	},
	stack_size = 200,
	subgroup = "apm_nuclear_chemistry",
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
	name = "apm_potassium_bromide",
	icons = {
		apm.nuclear.icons.potassium_bromide
	},
	stack_size = 200,
	subgroup = "apm_nuclear_chemistry",
	order = "ab_a",
}

data:extend({ item })
