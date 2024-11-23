require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/equipment/fussion_reactor.lua"

APM_LOG_HEADER(self)

---@type data.GeneratorEquipmentPrototype
local reactor = {
	type = "generator-equipment",
	name = "apm_fusion_reactor",
	sprite = {
		filename = "__base__/graphics/equipment/fusion-reactor-equipment.png", --apm.nuclear.icons.rtg.icon
		width = 128,                                                         --apm.nuclear.icons.rtg.icon_size
		height = 128,                                                        --apm.nuclear.icons.rtg.icon_size
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
	power = "2000kW",
	categories = { "armor" },
	burner = {
		type = "burner",
		fuel_categories = { "apm_nuclear_fusion_cell" },
		fuel_inventory_size = 1,
		burnt_inventory_size = 1,
	},
}

data:extend({ reactor })
