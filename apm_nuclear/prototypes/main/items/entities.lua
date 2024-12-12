require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/entities.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_cooling_pond_0",
	icons = {
		apm.nuclear.icons.cooling_pond
	},
	stack_size = 10,
	subgroup = "apm_nuclear_machines_1",
	order = "aa_b",
	place_result = "apm_cooling_pond_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_hybrid_cooling_tower_0",
	icons = {
		apm.nuclear.icons.hybrid_cooling_tower
	},
	stack_size = 10,
	subgroup = "apm_nuclear_cooling_tower",
	order = "aa_a",
	place_result = "apm_hybrid_cooling_tower_0",

	weight = apm.lib.utils.constants.value.weight.building.medium,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_nuclear_breeder",
	icons = {
		apm.nuclear.icons.breeder_reactor
	},
	stack_size = 5,
	subgroup = "apm_nuclear_machines_2",
	order = "ab_a",
	place_result = "apm_nuclear_breeder",

	weight = apm.lib.utils.constants.value.weight.building.big,
}

data:extend({ item })
