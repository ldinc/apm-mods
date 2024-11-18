require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/pellets.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_oxide_pellet_u238",
	icons = {
		apm.nuclear.icons.oxide_pellet_u238
	},
	stack_size = 200,
	subgroup = "apm_nuclear_oxide_pellets",
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
	name = "apm_oxide_pellet_u235",
	icons = {
		apm.nuclear.icons.oxide_pellet_u235
	},
	stack_size = 200,
	subgroup = "apm_nuclear_oxide_pellets",
	order = "ab_a",
}

data:extend({ item })


-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_oxide_pellet_th232",
	icons = {
		apm.nuclear.icons.oxide_pellet_th232
	},
	stack_size = 200,
	subgroup = "apm_nuclear_oxide_pellets",
	order = "ac_a",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_oxide_pellet_np237",
	icons = {
		apm.nuclear.icons.oxide_pellet_np237
	},
	stack_size = 200,
	subgroup = "apm_nuclear_oxide_pellets",
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
	name = "apm_oxide_pellet_pu239",
	icons = {
		apm.nuclear.icons.oxide_pellet_pu239
	},
	stack_size = 200,
	subgroup = "apm_nuclear_oxide_pellets",
	order = "ae_a",
}

data:extend({ item })
