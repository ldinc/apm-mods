require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/hexafluoride.lua"

APM_LOG_HEADER(self)


---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_yellowcake",
	icons = {
		apm.nuclear.icons.yellowcake
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_chemistry",
	order = "aa_a",

	weight = apm.lib.utils.constants.value.weight.chemistry,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_potassium_bromide",
	icons = {
		apm.nuclear.icons.potassium_bromide
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_chemistry",
	order = "ab_a",

	weight = apm.lib.utils.constants.value.weight.chemistry,
}

data:extend({ item })
