require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/technologies-overwrite.lua"

APM_LOG_HEADER(self)

--atomic-bomb
apm.lib.utils.technology.remove.prerequisites("atomic-bomb", "kovarex-enrichment-process")
apm.lib.utils.technology.add.prerequisites("atomic-bomb", "nuclear-fuel-reprocessing")
apm.lib.utils.technology.add.science_pack("atomic-bomb", "apm_nuclear_science_pack", 1)

--uranium-processing
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_fluorite_ore")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_yellowcake")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_potassium_bromide")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_bromine")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_bromine_trifluoride")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_waste_container")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_radioactive_wastewater_recyling")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_007")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_012")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_017")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_022")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_027")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_032")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_037")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_042")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_hexafluoride_047")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_oxide_pellet_u238")
apm.lib.utils.technology.add.recipe_for_unlock("uranium-processing", "apm_oxide_pellet_u235")

--nucular power
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-power", "apm_fuel_rod_container")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-power", "apm_fuel_rod_uranium")

--nuclear-fuel-reprocessing
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_cooling_pond_0")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_hybrid_cooling_tower_0")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_container_maintenance")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_uranium_cooling")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_uranium_recovery_stage_a")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_mox")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_mox_cooling")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_mox_recovery_stage_a")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "hot_water_cooling")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "steam_condensing")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_nuclear_ash")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_phosphorus")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_trimethyl_phosphate")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_tbp_30")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_uranium_recovery_stage_b")
apm.lib.utils.technology.add.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_fuel_rod_mox_recovery_stage_b")
apm.lib.utils.technology.remove.science_pack("nuclear-fuel-reprocessing", "production-science-pack")
apm.lib.utils.technology.remove.prerequisites("nuclear-fuel-reprocessing", "production-science-pack")
apm.lib.utils.technology.add.prerequisites("nuclear-fuel-reprocessing", "apm_nuclear_science_pack")
apm.lib.utils.technology.add.science_pack("nuclear-fuel-reprocessing", "apm_nuclear_science_pack", 1)
apm.lib.utils.technology.mod.unit_count("nuclear-fuel-reprocessing", 150)

-- fusion-reactor-equipment
--apm.lib.utils.technology.add.prerequisites("fusion-reactor-equipment", "apm_nuclear_rtg")
apm.lib.utils.technology.add.prerequisites("fusion-reactor-equipment", "apm_nuclear_science_pack")
apm.lib.utils.technology.add.science_pack("fusion-reactor-equipment", "apm_nuclear_science_pack", 1)

if mods["space-age"] then
	apm.lib.utils.technology.add.recipe_for_unlock("fission-reactor-equipment", "apm_shielded_nuclear_fuel_cell")
	apm.lib.utils.technology.add.recipe_for_unlock("fission-reactor-equipment",
		"apm_shielded_nuclear_fuel_cell_reprocessing")

	apm.lib.utils.technology.add.prerequisites("apm_nuclear_breeder", "productivity-module-2")

	apm.lib.utils.technology.add.prerequisites("atomic-bomb", "space-science-pack")
else
	apm.lib.utils.technology.add.recipe_for_unlock("fusion-reactor-equipment", "apm_shielded_nuclear_fuel_cell")
	apm.lib.utils.technology.add.recipe_for_unlock("fusion-reactor-equipment",
		"apm_shielded_nuclear_fuel_cell_reprocessing")
end

--- [fix barreling] <<<

--- for angles only
apm.lib.utils.technology.remove.recipe_from_unlock("fluid-handling", "apm_phosphoroxychlorid-barrel")
apm.lib.utils.technology.remove.recipe_from_unlock("fluid-handling", "empty-apm_phosphoroxychlorid-barrel")

---@param tname string
---@param trecipe string
local bind = function(tname, trecipe)
	apm.lib.utils.technology.force.recipe_for_unlock(tname,
		trecipe .. "-barrel")
	apm.lib.utils.technology.force.recipe_for_unlock(tname,
		"empty-" .. trecipe .. "-barrel")
end

--- base
apm.lib.utils.technology.force.recipe_for_unlock("apm_nuclear_breeder_uranium",
	"apm_purex_solution_breeder_uranium-barrel")
apm.lib.utils.technology.force.recipe_for_unlock("apm_nuclear_breeder_uranium",
	"empty-apm_purex_solution_breeder_uranium-barrel")

bind("nuclear-fuel-reprocessing", "apm_purex_solution_mox")
bind("apm_nuclear_neptunium_fuel", "apm_purex_solution_neptunium")
bind("apm_nuclear_breeder_thorium", "apm_purex_solution_thorium_breeder")
bind("apm_nuclear_thorium_fuel", "apm_purex_solution_thorium")
bind("nuclear-fuel-reprocessing", "apm_purex_solution_uranium")
bind("uranium-processing", "apm_bromine")
bind("uranium-processing", "apm_bromine_trifluoride")
bind("uranium-processing", "apm_radioactive_wastewater")
bind("nuclear-fuel-reprocessing", "apm_tbp_30")
bind("nuclear-fuel-reprocessing", "apm_trimethyl_phosphate")

bind("nuclear-fuel-reprocessing", "apm_hot_water")

--- >>> [fix barreling]

apm.lib.utils.technology.add.prerequisites("kovarex-enrichment-process", "nuclear-fuel-reprocessing")
apm.lib.utils.technology.add.prerequisites("atomic-bomb", "production-science-pack")

apm.lib.utils.technology.remove.prerequisites("kovarex-enrichment-process", "uranium-processing")
apm.lib.utils.technology.remove.prerequisites("atomic-bomb", "apm_nuclear_science_pack")
apm.lib.utils.technology.remove.prerequisites("uranium-ammo", "uranium-processing")

apm.lib.utils.technology.remove.prerequisites("artillery-shell-range-1", "apm_nuclear_science_pack")
apm.lib.utils.technology.remove.prerequisites("artillery-shell-speed-1", "apm_nuclear_science_pack")

-- space-science-pack
--apm.lib.utils.technology.add.prerequisites("space-science-pack", "apm_nuclear_science_pack")
apm.lib.utils.technology.add.prerequisites("space-science-pack", "apm_nuclear_rtg")
apm.lib.utils.technology.add.science_pack("space-science-pack", "apm_nuclear_science_pack", 1)

--kovarex-enrichment-process
apm.lib.utils.technology.disable("kovarex-enrichment-process")

-- uranium-ammo
--apm.lib.utils.technology.add.prerequisites("uranium-ammo", "apm_depleted_uranium")
apm.lib.utils.technology.add.prerequisites("uranium-ammo", "apm_nuclear_science_pack")
apm.lib.utils.technology.add.science_pack("uranium-ammo", "apm_nuclear_science_pack", 1)

if mods["space-age"] then
	apm.lib.utils.technology.remove.prerequisites("atomic-bomb", "nuclear-fuel-reprocessing")
	apm.lib.utils.technology.remove.prerequisites("atomic-bomb", "production-science-pack")

	apm.lib.utils.technology.remove.prerequisites("kovarex-enrichment-process", "nuclear-fuel-reprocessing")
	apm.lib.utils.technology.remove.prerequisites("productivity-module-2", "productivity-module")
	apm.lib.utils.technology.remove.prerequisites("follower-robot-count-5", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("apm_nuclear_breeder", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("apm_nuclear_breeder", "nuclear-fuel-reprocessing")
	apm.lib.utils.technology.remove.prerequisites("personal-roboport-mk2-equipment", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("personal-roboport-mk2-equipment", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("processing-unit-productivity", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("scrap-recycling-productivity", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("low-density-structure-productivity", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("rail-support-foundations", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("advanced-asteroid-processing", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("advanced-asteroid-processing", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("epic-quality", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("health", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("plastic-bar-productivity", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("rocket-fuel-productivity", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("stack-inserter", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("stack-inserter", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("biolab", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("biolab", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("biolab", "uranium-processing")
	apm.lib.utils.technology.remove.prerequisites("overgrowth-soil", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("overgrowth-soil", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("spidertron", "production-science-pack")
	apm.lib.utils.technology.remove.prerequisites("fusion-reactor-equipment", "apm_nuclear_science_pack")
end
