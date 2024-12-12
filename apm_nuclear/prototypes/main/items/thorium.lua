require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/thorium.lua"

APM_LOG_HEADER(self)

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_thorium",
	icons = {
		apm.nuclear.icons.fuel_container_thorium
	},
	fuel_category = "apm_nuclear_thorium",
	burnt_result = "apm_fuel_rod_thorium_active",
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_fuel",
	order = "ad_a[thorium]",
	fuel_value = apm.nuclear.constants.fuel_value.fuel_rod.thorium,
	fuel_glow_color = apm.nuclear.color.fuel_glow.fuel_rod.thorium,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_thorium_active",
	icons = {
		apm.nuclear.icons.fuel_container_thorium_active
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel",
	order = "ad_a[thorium]",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_thorium_cooled",
	icons = {
		apm.nuclear.icons.fuel_container_thorium_cooled
	},
	stack_size = apm.lib.features.stack_size.default,
	subgroup = "apm_nuclear_used_fuel_cold",
	order = "ad_a[thorium]",

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_thorium",
	icons = {
		apm.nuclear.icons.breeder_container_thorium
	},
	subgroup = "apm_nuclear_breeding_thorium",
	order = "aa_a",
	stack_size = apm.lib.features.stack_size.default,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_thorium_loaded",
	icons = {
		apm.nuclear.icons.breeder_container_thorium_loaded
	},
	subgroup = "apm_nuclear_breeding_thorium",
	fuel_category = "apm_nuclear_breeder",
	burnt_result = "apm_breeder_thorium_active",
	fuel_value = apm.nuclear.constants.fuel_value.breeder.thorium,
	fuel_glow_color = apm.nuclear.color.fuel_glow.breeder.thorium,
	order = "ab_a",
	stack_size = apm.lib.features.stack_size.default,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_thorium_active",
	icons = {
		apm.nuclear.icons.breeder_container_thorium_active
	},
	subgroup = "apm_nuclear_breeding_thorium",
	order = "ac_a",
	stack_size = apm.lib.features.stack_size.default,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_thorium_cooled",
	icons = {
		apm.nuclear.icons.breeder_container_thorium_cooled
	},
	subgroup = "apm_nuclear_breeding_thorium",
	order = "bd_a",
	stack_size = apm.lib.features.stack_size.default,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })

---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_thorium_seperated",
	icons = {
		apm.nuclear.icons.breeder_container_thorium_seperated
	},
	subgroup = "apm_nuclear_breeding_thorium",
	order = "bd_a",
	stack_size = apm.lib.features.stack_size.default,

	weight = apm.lib.utils.constants.value.weight.fuel_element,
}

data:extend({ item })
