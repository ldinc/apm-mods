require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/integrations/technologies.lua"

APM_LOG_HEADER(self)

local apm_nuclear_compat_bob = settings.startup["apm_nuclear_compat_bob"].value
local apm_nuclear_compat_angel = settings.startup["apm_nuclear_compat_angel"].value
local apm_nuclear_compat_earendel = settings.startup["apm_nuclear_compat_earendel"].value
local apm_nuclear_compat_bio_industries = settings.startup["apm_nuclear_compat_bio_industries"].value
local apm_nuclear_compat_sctm = settings.startup["apm_nuclear_compat_sctm"].value
local apm_nuclear_compat_realistic_reactors = settings.startup["apm_nuclear_compat_realistic_reactors"].value
local apm_nuclear_compat_realistic_reactors_cooling_tower = settings.startup
		["apm_nuclear_compat_realistic_reactors_cooling_tower"].value
local apm_nuclear_compat_reverse_factory = settings.startup["apm_nuclear_compat_reverse_factory"].value
local apm_nuclear_compat_mferrari = settings.startup["apm_nuclear_compat_mferrari"].value

APM_LOG_SETTINGS(self, "apm_nuclear_compat_bob", apm_nuclear_compat_bob)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_angel", apm_nuclear_compat_angel)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_earendel", apm_nuclear_compat_earendel)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_bio_industries", apm_nuclear_compat_bio_industries)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_sctm", apm_nuclear_compat_sctm)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_realistic_reactors", apm_nuclear_compat_realistic_reactors)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_realistic_reactors_cooling_tower",
	apm_nuclear_compat_realistic_reactors_cooling_tower)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_reverse_factory", apm_nuclear_compat_reverse_factory)
APM_LOG_SETTINGS(self, "apm_nuclear_compat_mferrari", apm_nuclear_compat_mferrari)

-- bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and apm_nuclear_compat_bob then
	apm.lib.utils.technology.delete("bobingabout-enrichment-process")
	apm.lib.utils.technology.delete("bob-thorium-processing")
	apm.lib.utils.technology.delete("bob-thorium-fuel-reprocessing")
	apm.lib.utils.technology.add.prerequisites("bob-deuterium-processing", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("bob-deuterium-processing", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("bob-deuterium-fuel-reprocessing", "apm_nuclear_science_pack")
end

if mods.bobassembly and apm_nuclear_compat_bob then
	apm.lib.utils.technology.delete("basic-automation")
end

if mods.bobpower and apm_nuclear_compat_bob then
	apm.lib.utils.technology.add.prerequisites("nuclear-fuel-reprocessing", "nuclear-power")
	apm.lib.utils.technology.add.prerequisites("bob-nuclear-power-2", "nuclear-power")
	apm.lib.utils.technology.add.prerequisites("bob-nuclear-power-2", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("bob-nuclear-power-2", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.prerequisites("apm_nuclear_thorium_fuel", "bob-nuclear-power-2")
end

if mods.bobequipment and apm_nuclear_compat_bob then
	apm.lib.utils.technology.add.science_pack("bob-fusion-reactor-equipment-2", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("bob-fusion-reactor-equipment-3", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("bob-fusion-reactor-equipment-4", "apm_nuclear_science_pack")
end

-- angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelspetrochem and mods.angelsrefining and apm_nuclear_compat_angel then
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_phosphorpentachlorid")
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_phosphoroxychlorid")
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-fuel-reprocessing", "apm_phosphoroxychlorid-barrel")
end

-- Earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods["aai-vehicles-miner"] and apm_nuclear_compat_earendel then
	apm.lib.utils.technology.add.prerequisites("vehicle-miner-5", "apm_nuclear_science_pack")
	apm.lib.utils.technology.add.science_pack("vehicle-miner-5", "apm_nuclear_science_pack")
	apm.lib.utils.technology.remove.science_pack("vehicle-miner-5", "production-science-pack")
end

if mods["space-exploration"] and apm_nuclear_compat_earendel then
	apm.lib.utils.technology.remove.prerequisites("se-rtg-equipment", "nuclear-power")
	apm.lib.utils.technology.add.prerequisites("se-rtg-equipment", "apm_nuclear_rtg")
	apm.lib.utils.technology.remove.prerequisites("fusion-reactor-equipment", "se-rtg-equipment-2")
end

-- RealisticReactors ----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.RealisticReactors and apm_nuclear_compat_realistic_reactors then
	apm.lib.utils.technology.delete("breeder-reactors")
	apm.lib.utils.technology.force.recipe_for_unlock("apm_nuclear_breeder", "breeder-reactor")
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-power", "apm_hybrid_cooling_tower_0")

	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-power", "hot_water_cooling")
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-power", "steam_condensing")
	apm.lib.utils.technology.force.recipe_for_unlock("nuclear-power", "water-cooling")
end


--- Vanilla
apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("kovarex-enrichment-process")

if mods["space-age"] then
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("apm_nuclear_breeder")
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("apm_nuclear_breeder_thorium")
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("apm_nuclear_breeder_uranium")
end

-- APM ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods["apm_power_ldinc"] then
	apm.lib.utils.technology.add.prerequisites("rocket-silo", "apm_nuclear_rtg")
	apm.lib.utils.technology.remove.prerequisites("rocket-silo", "concrete")
	apm.lib.utils.technology.remove.prerequisites("rocket-silo", "utility-science-pack")
	apm.lib.utils.technology.remove.prerequisites("space-science-pack", "apm_nuclear_rtg")
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("rocket-silo")

	if mods["space-age"] then
		apm.lib.utils.technology.add.prerequisites("fission-reactor-equipment", "nuclear-fuel-reprocessing")
		apm.lib.utils.technology.add.prerequisites("personal-roboport-equipment", "chemical-science-pack")
		apm.lib.utils.technology.add.prerequisites("worker-robots-speed-2", "chemical-science-pack")

		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("fission-reactor-equipment")
		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("spidertron")
		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("")
		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("")
		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("")

		--- optimize t-tree
		apm.lib.utils.technology.remove.prerequisites("fission-reactor-equipment", "nuclear-power")
		apm.lib.utils.technology.remove.prerequisites("rocket-silo", "concrete")
		apm.lib.utils.technology.remove.prerequisites("rocket-silo", "processing-unit")
		apm.lib.utils.technology.remove.prerequisites("rocket-silo", "low-density-structure")
		apm.lib.utils.technology.remove.prerequisites("rocket-silo", "advanced-material-processing-2")
		apm.lib.utils.technology.remove.prerequisites("space-science-pack", "apm_nuclear_rtg")
	end
end
