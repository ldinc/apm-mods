require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/purex.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_nuclear_ash",
	icons = {
		apm.nuclear.icons.generic_ash
	},
	stack_size = apm.lib.features.stack_size.ash,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_a",

	weight = apm.lib.utils.constants.value.weight.product.ash,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_phosphorus",
	icons = {
		apm.nuclear.icons.phosphorus
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_b",

	weight = apm.lib.utils.constants.value.weight.chemistry,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_phosphorpentachlorid",
	icons = {
		apm.nuclear.icons.phosphorpentachlorid
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_chemistry",
	order = "ad_c",

	weight = apm.lib.utils.constants.value.weight.chemistry,
}

data:extend({ item })
