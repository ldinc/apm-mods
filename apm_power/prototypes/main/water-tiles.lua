require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/water-tiles.lua'

APM_LOG_HEADER(self)

water_tile_type_names = water_tile_type_names or {}

local tile_subgroup_for_overwrite = {
	["gleba-water-tiles"] = "apm_dirt_water",
}

function update_water_fuild_on_tiles(tile_subgroup_for_overwrite)
	for _, tile_name in ipairs(water_tile_type_names) do
		local tile = data.raw["tile"][tile_name]

		if tile then
			if tile.fluid and tile.fluid == "water" then
				if tile.subgroup then
					local fluid = tile_subgroup_for_overwrite[tile.subgroup]
					if fluid then
						tile.fluid = fluid
					else
						tile.fluid = "apm_sea_water"
					end
				else
					tile.fluid = "apm_sea_water"
				end
			end
		end
	end
end

update_water_fuild_on_tiles(tile_subgroup_for_overwrite)
