require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/mox.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_mox",
	icons = {
		apm.nuclear.icons.fuel_container_mox
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_fuel",
	order = "ab_a",
	fuel_category = "apm_nuclear_mox",
	burnt_result = "apm_fuel_rod_mox_active",
	fuel_value = apm.nuclear.constants.fuel_value.fuel_rod.mox,
	fuel_glow_color = apm.nuclear.color.fuel_glow.fuel_rod.mox,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_mox_active",
	icons = {
		apm.nuclear.icons.fuel_container_mox_active
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel",
	order = "ab_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_mox_cooled",
	icons = {
		apm.nuclear.icons.fuel_container_mox_cooled
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel_cold",
	order = "ab_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
