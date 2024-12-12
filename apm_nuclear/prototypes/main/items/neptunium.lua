require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/neptunium.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_neptunium",
	icons = {
		apm.nuclear.icons.fuel_container_neptunium
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_fuel",
	order = "ae_a",
	fuel_category = "apm_nuclear_neptunium",
	burnt_result = "apm_fuel_rod_neptunium_active",
	fuel_value = apm.nuclear.constants.fuel_value.fuel_rod.neptunium,
	fuel_glow_color = apm.nuclear.color.fuel_glow.fuel_rod.neptunium,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_neptunium_active",
	icons = {
		apm.nuclear.icons.fuel_container_neptunium_active
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel",
	order = "ae_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_neptunium_cooled",
	icons = {
		apm.nuclear.icons.fuel_container_neptunium_cooled
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel_cold",
	order = "ae_a",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
