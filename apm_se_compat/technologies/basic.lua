--- Fixing postprocessed technologies ...
local list = {
	"apm_industrial_science_pack",
	"apm_steam_science_pack"
}





--- Fixing broken links
apm.lib.utils.technology.add.prerequisites("apm_rubber-1", "apm_crusher_machine_0")
apm.lib.utils.technology.add.prerequisites("steel-axe", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("apm_asphalt-1", "apm_fuel-3")
apm.lib.utils.technology.add.prerequisites("apm_fuel-1", "apm_coking_plant_0")
apm.lib.utils.technology.add.prerequisites("apm_coking_plant_0", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("apm_stone_bricks", "apm_press_machine_0")
apm.lib.utils.technology.add.prerequisites("apm_press_machine_0", "apm_water_supply-1")
apm.lib.utils.technology.add.prerequisites("apm_fluid_control-1", "apm_water_supply-1")
apm.lib.utils.technology.add.prerequisites("apm_rubber-2", "apm_rubber-1")
apm.lib.utils.technology.add.prerequisites("apm_steam_science_pack", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("apm_puddling_furnace_0", "apm_fuel-1")
apm.lib.utils.technology.add.prerequisites("apm_inserter_capacity_bonus", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("apm_particle_filter", "apm_coking_plant_0")
apm.lib.utils.technology.add.prerequisites("apm_assembler_machine_1", "apm_steam_science_pack")
apm.lib.utils.technology.add.prerequisites("apm_press_machine_1", "apm_steam_science_pack")
apm.lib.utils.technology.add.prerequisites("apm_centrifuge_0", "apm_steam_science_pack")
apm.lib.utils.technology.add.prerequisites("apm_greenhouse_1", "apm_steam_science_pack")
apm.lib.utils.technology.add.prerequisites("apm_crusher_machine_1", "apm_steam_science_pack")
apm.lib.utils.technology.add.prerequisites("apm_coking_plant_1", "apm_fuel-2")
apm.lib.utils.technology.add.prerequisites("apm_coking_plant_1", "apm_assembler_machine_1")
apm.lib.utils.technology.add.prerequisites("apm_fuel-2", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.prerequisites("steel-processing", "apm_puddling_furnace_0")

apm.lib.utils.technology.add.prerequisites("apm_treated_wood_planks-1", "apm_fuel-3")
apm.lib.utils.technology.add.prerequisites("apm_treated_wood_planks-2", "apm_treated_wood_planks-1")

apm.lib.utils.technology.add.prerequisites("se-medpack", "apm_crusher_machine_0")
apm.lib.utils.technology.add.prerequisites("apm_ash_production", "apm_coking_plant_0")
apm.lib.utils.technology.add.prerequisites("se-heat-shielding", "apm_stone_bricks")
apm.lib.utils.technology.add.prerequisites("se-heat-shielding", "chemical-science-pack")

apm.lib.utils.technology.add.prerequisites("electronics", "apm_lab_1")
apm.lib.utils.technology.add.prerequisites("automation-science-pack", "electronics")
apm.lib.utils.technology.add.prerequisites("automation-science-pack", "apm_treated_wood_planks-1")
apm.lib.utils.technology.add.prerequisites("military", "apm_press_machine_0")
apm.lib.utils.technology.add.prerequisites("advanced-oil-processing", "chemical-science-pack")
apm.lib.utils.technology.add.prerequisites("railway", "apm_treated_wood_planks-1")


apm.lib.utils.technology.disable("burner-mechanics")

local tlist = {
	["se-medpack"] = 1,
	["apm_water_supply-1"] = 1,
	["logistics"] = 1,
	["apm_press_machine_0"] = 1,
	["military"] = 1,
	["apm_stone_bricks"] = 1,
	["apm_greenhouse"] = 1,
	["gun-turret"] = 1,
	["apm_coking_plant_0"] = 1,
}

local techlist = {
	[1] = { "apm_industrial_science_pack" },
	[2] = {
		"apm_industrial_science_pack",
		"apm_steam_science_pack"
	},
}

for tname, tier in pairs(tlist) do
	apm.lib.utils.technology.remove.science_packs_except(tname, techlist[tier])
end

-- --- Remove invalids science packs
-- local tnames = apm.lib.utils.technology.find.by_prefix("apm")

-- if tnames then
-- 	for _, tname in ipairs(tnames) do
-- 		apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites(tname)
-- 	end
-- end
