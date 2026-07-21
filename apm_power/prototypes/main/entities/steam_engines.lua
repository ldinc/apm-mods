require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_power/prototypes/main/entities/steam_engines.lua"

APM_LOG_HEADER(self)

--- [apm_steam_engine_2]
local steam_engine = table.deepcopy(data.raw.generator["steam-engine"])
steam_engine.name = "apm_steam_engine_2"
steam_engine.icons = {
	apm.power.icons.steam_engine,
	apm.lib.icons.dynamics.t2
}

steam_engine.minable = { mining_time = 0.2, result = "apm_steam_engine_2" }
steam_engine.fast_replaceable_group = "steam-engine"
steam_engine.max_health = 500
steam_engine.maximum_temperature = 240
steam_engine.fluid_usage_per_tick = 0.45

-- East = old horizontal_animation
local east_layers = steam_engine.pictures.east.animation.layers

if east_layers then
	east_layers[3] = table.deepcopy(east_layers[1])
	east_layers[3].filename = "__apm_resource_pack_ldinc__/graphics/masks/steam_engine/hr-steam-engine-H.png"
	east_layers[3].tint = apm.power.color.steam_engine_tier_2
end

-- North = old vertical_animation
local north_layers = steam_engine.pictures.north.animation.layers
if north_layers then
	north_layers[3] = table.deepcopy(north_layers[1])
	north_layers[3].filename = "__apm_resource_pack_ldinc__/graphics/masks/steam_engine/hr-steam-engine-V.png"
	north_layers[3].tint = apm.power.color.steam_engine_tier_2
end



data:extend({ steam_engine })
