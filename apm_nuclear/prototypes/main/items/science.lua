require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/science.lua"

APM_LOG_HEADER(self)

---@type data.ToolPrototype
local item = {
	type = "tool",
	name = "apm_nuclear_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.nuclear.icons.sciencepack
	},
	stack_size = 200,
	group = "apm_nuclear",
	subgroup = "apm_nuclear_science",
	order = "aa_a",
	durability = 1,
	durability_description_key = "description.science-pack-remaining-amount-key",
	durability_description_value = "description.science-pack-remaining-amount-value",

	weight = apm.lib.utils.constants.value.weight.science_pack,
}

data:extend({ item })
