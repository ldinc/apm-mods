require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/equipment/fission_reactor.lua"

APM_LOG_HEADER(self)

---@type data.GeneratorEquipmentPrototype
local reactor = {
	type = "generator-equipment",
	name = "apm_fission_reactor",
	take_result = "fusion-reactor-equipment",
	sprite = {
		filename = "__base__/graphics/equipment/fusion-reactor-equipment.png",
		width = 128,
		height = 128,
		priority = "medium",
	},
	shape = {
		width = 4,
		height = 4,
		type = "full",
	},
	energy_source = {
		type = "electric",
		usage_priority = "secondary-output",
	},
	power = "750kW",
	categories = { "armor" },
	burner = {
		type = "burner",
		fuel_categories = { "apm_nuclear_shielded_cell" },
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
		emissions_per_minute = nil,
	},
}

data:extend({ reactor })
