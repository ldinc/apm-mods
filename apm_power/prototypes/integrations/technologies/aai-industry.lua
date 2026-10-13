apm.lib.utils.technology.delete("basic-fluid-handling")
apm.lib.utils.technology.delete("basic-logistics")

apm.lib.utils.technology.add.prerequisites("apm_crusher_machine_0", "burner-mechanics")
apm.lib.utils.technology.add.prerequisites("apm_steam_science_pack", "steam-power")
apm.lib.utils.technology.add.prerequisites("steam-power", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("sand-processing", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("sand-processing", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("glass-processing", "sand-processing")


apm.lib.utils.technology.add.prerequisites("apm_fuel-2", "apm_puddling_furnace_0")

apm.lib.utils.technology.remove.prerequisites("steam-power", "fluid-handling")

apm.lib.utils.technology.remove.prerequisites("electronics", "electricity")
apm.lib.utils.technology.force.recipe_for_unlock("electronics", "copper-cable")

apm.lib.utils.technology.add.prerequisites("automation-science-pack", "electronics")
apm.lib.utils.technology.add.prerequisites("apm_power_electricity", "electronics")

apm.lib.utils.technology.remove.prerequisites("sand-processing", "automation-science-pack")
apm.lib.utils.technology.force.update_science_packs("sand-processing")
apm.lib.utils.technology.force.update_science_packs("glass-processing")

apm.lib.utils.technology.add.prerequisites("apm_lab_1", "glass-processing")
apm.lib.utils.technology.add.prerequisites("apm_greenhouse", "glass-processing")
apm.lib.utils.technology.remove.prerequisites("apm_greenhouse", "apm_stone_bricks")

apm.lib.utils.technology.add.prerequisites("automation-science-pack", "apm_lab_1")

apm.lib.utils.technology.add.prerequisites("electric-mining-drill", "apm_electric_mining_drills")

apm.lib.utils.technology.add.prerequisites("fluid-handling", "automation-2")
apm.lib.utils.technology.add.prerequisites("fluid-handling", "engine")

apm.lib.utils.technology.force.recipe_for_unlock("apm_press_machine_0", "burner-inserter")

apm.lib.utils.technology.remove.recipe_from_unlock("basic-fluid-handling", "offshore-pump")

apm.lib.utils.technology.add.prerequisites("apm_power_electricity", "automation-science-pack")
apm.lib.utils.technology.add.prerequisites("automation-science-pack", "electronics")

apm.lib.utils.technology.add.prerequisites("electric-lab", "apm_power_electricity")
apm.lib.utils.technology.force.recipe_for_unlock("electric-lab", "lab")
apm.lib.utils.technology.force.update_science_packs("electric-lab")

apm.lib.utils.technology.add.prerequisites("fuel-processing", "apm_stone_bricks")
apm.lib.utils.technology.remove.prerequisites("fuel-processing", "automation-science-pack")
apm.lib.utils.technology.force.update_science_packs("fuel-processing")

apm.lib.utils.technology.add.prerequisites("electricity", "electronics")
apm.lib.utils.technology.force.update_science_packs("electricity")
apm.lib.utils.technology.add.science_pack("electricity", apm.lib.utils.constants.science.apm.steam)

--- TTree optimization
apm.lib.utils.technology.remove.prerequisites("apm_fuel-2", "apm_puddling_furnace_0")
apm.lib.utils.technology.remove.prerequisites("automation-science-pack", "burner-mechanics")
apm.lib.utils.technology.remove.prerequisites("automation-science-pack", "apm_lab_1")
apm.lib.utils.technology.remove.prerequisites("apm_power_electricity", "electronics")
apm.lib.utils.technology.remove.prerequisites("electric-lab", "electronics")
apm.lib.utils.technology.remove.prerequisites("electric-lab", "glass-processing")
apm.lib.utils.technology.remove.prerequisites("fast-inserter", "electronics")
apm.lib.utils.technology.remove.prerequisites("lamp", "glass-processing")
apm.lib.utils.technology.remove.prerequisites("radar", "electronics")
apm.lib.utils.technology.remove.prerequisites("electric-mining-drill", "automation-science-pack")
apm.lib.utils.technology.remove.prerequisites("logistic-science-pack", "electricity")
apm.lib.utils.technology.remove.prerequisites("automation-2", "electronics")
apm.lib.utils.technology.remove.prerequisites("circuit-network", "electronics")
apm.lib.utils.technology.remove.prerequisites("gate", "electronics")
apm.lib.utils.technology.remove.prerequisites("logistics-2", "electronics")
apm.lib.utils.technology.remove.prerequisites("medium-electric-pole", "electricity")
apm.lib.utils.technology.remove.prerequisites("solar-energy", "electronics")
apm.lib.utils.technology.remove.prerequisites("solar-energy", "glass-processing")
apm.lib.utils.technology.remove.prerequisites("concrete", "logistic-science-pack")
apm.lib.utils.technology.remove.prerequisites("concrete", "sand-processing")
apm.lib.utils.technology.remove.prerequisites("fluid-handling", "steel-processing")
apm.lib.utils.technology.remove.prerequisites("fluid-handling", "logistic-science-pack")
apm.lib.utils.technology.remove.prerequisites("oil-processing", "glass-processing")
apm.lib.utils.technology.remove.prerequisites("oil-processing", "automation")
apm.lib.utils.technology.remove.prerequisites("flamethrower", "engine")
apm.lib.utils.technology.remove.prerequisites("advanced-circuit", "electronics")
apm.lib.utils.technology.remove.prerequisites("chemical-science-pack", "engine")
apm.lib.utils.technology.remove.prerequisites("laser", "electronics")
apm.lib.utils.technology.remove.prerequisites("nuclear-power", "steam-power")
apm.lib.utils.technology.remove.prerequisites("automation-3", "automation-2")
apm.lib.utils.technology.remove.prerequisites("automation-3", "concrete")
apm.lib.utils.technology.remove.prerequisites("coal-liquefaction", "steam-power")
apm.lib.utils.technology.remove.prerequisites("rocket-silo", "concrete")

if mods["space-age"] then
	apm.lib.utils.technology.remove.prerequisites("elevated-rail", "concrete")
end
