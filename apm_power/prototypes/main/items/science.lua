require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/items/science.lua"

APM_LOG_HEADER(self)

---@type ItemPrototype
local item = {
	type = "item",
	name = "apm_industrial_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_1
	},
	stack_size = 200,
	subgroup = "science-pack",
	order = "a[apm_industrial_science_pack]",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type ItemPrototype
local item = {
	type = "item",
	name = "apm_steam_science_pack",
	localised_description = { "item-description.science-pack" },
	icons = {
		apm.power.icons.sciencepack_2
	},
	stack_size = 200,
	subgroup = "science-pack",
	order = "ab[apm_steam_science_pack]",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
