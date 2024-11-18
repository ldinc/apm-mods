require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/purex.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_nuclear_ash",
	icons = {
		apm.nuclear.icons.generic_ash
	},
	stack_size = 2000,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_a",
}

data:extend({ item })


-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_phosphorus",
	icons = {
		apm.nuclear.icons.phosphorus
	},
	stack_size = 200,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_b",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_phosphorpentachlorid",
	icons = {
		apm.nuclear.icons.phosphorpentachlorid
	},
	stack_size = 200,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_c",
}

data:extend({ item })
