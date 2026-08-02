require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/science.lua"

APM_LOG_HEADER(self)

---@type ItemPrototype
local item = {
	type = "item",
	name = "apm_nuclear_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.nuclear.icons.sciencepack
	},
	stack_size = 200,
	subgroup = "apm_nuclear_science",
	order = "aa_a",

	weight = apm.lib.utils.constants.value.weight.science_pack,
}

data:extend({ item })
