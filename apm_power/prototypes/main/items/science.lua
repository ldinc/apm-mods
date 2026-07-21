require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/items/science.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_industrial_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_1
	},
	stack_size = 200,
	subgroup = "apm_power_science",
	order = "aa_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_steam_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_2
	},
	stack_size = 200,
	subgroup = "apm_power_science",
	order = "ab_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
