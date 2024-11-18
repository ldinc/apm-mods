require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/items/uranium.lua"

APM_LOG_HEADER(self)

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_uranium",
	icons = {
		apm.nuclear.icons.fuel_container_uranium
	},
	stack_size = 200,
	subgroup = "apm_nuclear_fuel",
	order = "aa_a",
	fuel_category = "apm_nuclear_uranium",
	burnt_result = "apm_fuel_rod_uranium_active",
	fuel_value = apm.nuclear.constants.fuel_value.fuel_rod.uranium,
	fuel_glow_color = apm.nuclear.color.fuel_glow.fuel_rod.uranium,
}

data:extend({ item })

-- Item -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
---@type data.ItemPrototype
local item = {
	type = "item",
	name = "apm_fuel_rod_uranium_active",
	icons = {
		apm.nuclear.icons.fuel_container_uranium_active
	},
	stack_size = 200,
	subgroup = "apm_nuclear_used_fuel",
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
	name = "apm_fuel_rod_uranium_cooled",
	icons = {
		apm.nuclear.icons.fuel_container_uranium_cooled
	},
	stack_size = 200,
	subgroup = "apm_nuclear_used_fuel_cold",
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
	name = "apm_breeder_uranium",
	icons = {
		apm.nuclear.icons.breeder_container_uranium
	},
	stack_size = 200,
	subgroup = "apm_nuclear_breeding_uranium",
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
	name = "apm_breeder_uranium_loaded",
	icons = {
		apm.nuclear.icons.breeder_container_uranium_loaded
	},
	stack_size = 200,
	subgroup = "apm_nuclear_breeding_uranium",
	fuel_category = "apm_nuclear_breeder",
	burnt_result = "apm_breeder_uranium_active",
	fuel_value = apm.nuclear.constants.fuel_value.breeder.uranium,
	fuel_glow_color = apm.nuclear.color.fuel_glow.breeder.uranium,
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
	name = "apm_breeder_uranium_active",
	icons = {
		apm.nuclear.icons.breeder_container_uranium_active
	},
	stack_size = 200,
	subgroup = "apm_nuclear_breeding_uranium",
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
	name = "apm_breeder_uranium_cooled",
	icons = {
		apm.nuclear.icons.breeder_container_uranium_cooled
	},
	stack_size = 200,
	subgroup = "apm_nuclear_breeding_uranium",
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
	name = "apm_breeder_uranium_seperated",
	icons = {
		apm.nuclear.icons.breeder_container_uranium_seperated
	},
	stack_size = 200,
	subgroup = "apm_nuclear_breeding_uranium",
	order = "ae_a",
}

data:extend({ item })
