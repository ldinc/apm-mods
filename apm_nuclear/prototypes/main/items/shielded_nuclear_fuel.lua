require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/shielded_nuclear_fuel.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_shielded_nuclear_fuel_cell",
	icons = {
		apm.nuclear.icons.shielded_nuclear_fuel_cell
	},
	stack_size = 10,
	subgroup = "apm_nuclear_products",
	order = "af_a",
	fuel_category = "apm_nuclear_shielded_cell",
	burnt_result = "apm_shielded_nuclear_fuel_cell_used",
	fuel_value = apm.nuclear.constants.fuel_value.shielded_nuclear_fuel,
	fuel_glow_color = apm.nuclear.color.fuel_glow.shielded_nuclear_fuel,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_shielded_nuclear_fuel_cell_used",
	icons = {
		apm.nuclear.icons.shielded_nuclear_fuel_cell_used
	},
	stack_size = 10,
	subgroup = "apm_nuclear_products",
	order = "af_b",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
