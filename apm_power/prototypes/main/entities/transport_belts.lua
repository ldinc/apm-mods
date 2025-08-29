require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/transport_belts.lua"

APM_LOG_HEADER(self)

-- Entity ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local transport_belt = table.deepcopy(data.raw["transport-belt"]["transport-belt"])
transport_belt.name = "apm_basic_transport_belt"
transport_belt.icon = "__base__/graphics/icons/transport-belt.png"
transport_belt.icon_size = 32
transport_belt.minable = { mining_time = 0.1, result = "apm_basic_transport_belt" }
transport_belt.max_health = 100

transport_belt.belt_animation_set = {
	animation_set = {
		filename =
		"__apm_resource_pack_ldinc__/graphics/entities/basic_transport_belt/hr_basic_transport_belt.png",
		priority = "extra-high",
		width = 128,
		height = 128,
		scale = 0.5,
		frame_count = 16,
	},
}

transport_belt.belt_animation_set.animation_set.direction_count = 20
transport_belt.fast_replaceable_group = "transport-belt"
transport_belt.next_upgrade = "transport-belt"
transport_belt.speed = 0.03125 / 2
data:extend({ transport_belt })
