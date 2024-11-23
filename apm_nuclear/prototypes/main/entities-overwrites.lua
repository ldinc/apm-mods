require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/overwrites.lua"

APM_LOG_HEADER(self)

-- ----------------------------------------------------------------------------------------------------------
-- This block should make this mod more compatible with other by setting the basic fuel categories for burners
-- apm.lib.utils.entities.set.fuel_categoriy_to_all_with_condition(entity_type, conditional_category, t_categories)
-- ----------------------------------------------------------------------------------------------------------
APM_LOG_INFO(self, "", "BEGIN: basic overwrites of the fuel categories")

for reactor_name, _ in pairs(data.raw.reactor) do
	if reactor_name == "heating-tower" and mods["space-age"] then
		local fuel_categories = {"chemical", "apm_refined_chemical"}
		
		apm.lib.utils.reactor.set.fuel_categories(reactor_name, fuel_categories)
	else
		apm.lib.utils.reactor.overhaul(reactor_name)
	end
end

APM_LOG_INFO(self, "", "END: basic overwrites of the fuel categories")

-- add electric-smelting category to electric-furnace
apm.lib.utils.furnace.mod.category.add("electric-furnace", "apm_electric_smelting")

apm.lib.utils.lab.add.science_pack("lab", "apm_nuclear_science_pack")

--- [space-age]
if mods["space-age"] then
	local categories_from_pond = {
		"apm_fluid_cooling_0",
		"apm_nuclear_cooling_0",
	}

	apm.lib.utils.assembler.add.crafting_categories("cryogenic-plant", categories_from_pond)
end