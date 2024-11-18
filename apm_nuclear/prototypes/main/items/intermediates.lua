require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/intermediates.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_container",
	icons = {
		apm.nuclear.icons.fuel_container
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "aa_a",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_container_worn",
	icons = {
		apm.nuclear.icons.fuel_container_worn
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "aa_b",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_container",
	icons = {
		apm.nuclear.icons.breeder_container
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "ab_a",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_breeder_container_worn",
	icons = {
		apm.nuclear.icons.breeder_container_worn
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "ab_b",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_waste_container",
	icons = {
		apm.nuclear.icons.waste_container
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "ac_a",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_depleted_uranium_metal_mixture",
	icons = {
		apm.nuclear.icons.depleted_uranium_mix
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "ad_a",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_depleted_uranium_ingots",
	icons = {
		apm.nuclear.icons.staballoy
	},
	stack_size = 200,
	subgroup = "apm_nuclear_products",
	order = "ad_b",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_rtg_radioisotope_thermoelectric_generator",
	icons = {
		apm.nuclear.icons.rtg
	},
	stack_size = 50,
	subgroup = "apm_nuclear_products",
	order = "ae_a",
	place_as_equipment_result = "apm_rtg_radioisotope_thermoelectric_generator",
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_hexafluoride_sample",
	icons = {
		apm.nuclear.icons.hexafluoride_sample
	},
	stack_size = 50,
	subgroup = "apm_nuclear_science",
	order = "ab_a",
}

data:extend({ item })
