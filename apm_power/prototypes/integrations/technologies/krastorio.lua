local list = {
	"artillery-shell-range-1",
	"artillery-shell-speed-1",
	"follower-robot-count-5",
	"laser-weapons-damage-7",
	"mining-productivity-4",
	"physical-projectile-damage-7",
	"refined-flammables-7",
	"stronger-explosives-7",
	"worker-robots-speed-6"
}

for _, t in ipairs(list) do
	local tech = data.raw["technology"][t]

	local sp = { "apm_industrial_science_pack", "apm_steam_science_pack", "utility-science-pack", "space-science-pack" }

	for _, sp_name in ipairs(sp) do
		apm.lib.utils.technology.remove.science_pack(tech.name, sp_name)
	end
end

apm.lib.utils.technology.add.prerequisites("kr-iron-pickaxe", "apm_crusher_machine_0")
apm.lib.utils.technology.add.prerequisites("kr-automation-core", "apm_crusher_machine_0")

apm.lib.utils.technology.overwrite.by("kr-crusher", "apm_crusher_machine_0")
apm.lib.utils.technology.disable("kr-crusher")

local set_only_industrial = function(name, count)
	apm.lib.utils.technology.remove.science_packs_except(name, {})
	apm.lib.utils.technology.add.science_pack(name, "apm_industrial_science_pack", count)
end

set_only_industrial("kr-automation-core", 10)
set_only_industrial("kr-iron-pickaxe", 25)
set_only_industrial("kr-stone-processing", 25)

apm.lib.utils.technology.add.prerequisites("apm_greenhouse", "kr-stone-processing")

apm.lib.utils.technology.overwrite.by("kr-greenhouse", "apm_greenhouse")
apm.lib.utils.technology.disable("kr-greenhouse")
set_only_industrial("kr-greenhouse", 30)

set_only_industrial("kr-decorations", 55)
set_only_industrial("military", 50)
set_only_industrial("kr-light-armor", 50)
set_only_industrial("heavy-armor", 50)
set_only_industrial("gun-turret", 10)
set_only_industrial("stone-wall", 10)
set_only_industrial("logistics", 10)

apm.lib.utils.technology.add.prerequisites("steel-axe", "kr-iron-pickaxe")

set_only_industrial("steel-axe", 50)

apm.lib.utils.technology.remove.recipe_from_unlock("logistics", "long-handed-inserter")
apm.lib.utils.technology.remove.recipe_from_unlock("logistics", "kr-loader")
apm.lib.utils.technology.add.recipe_for_unlock("apm_power_electricity", "long-handed-inserter")
apm.lib.utils.technology.add.recipe_for_unlock("apm_power_electricity", "kr-loader")
apm.lib.utils.technology.add.prerequisites("apm_power_electricity", "logistics")

apm.lib.utils.technology.remove.recipe_from_unlock("logistic-science-pack", "lab")
apm.lib.utils.technology.add.recipe_for_unlock("kr-laboratory", "lab")
apm.lib.utils.technology.add.prerequisites("kr-laboratory", "apm_power_electricity")

apm.lib.utils.technology.remove.prerequisites("automation-science-pack", "kr-laboratory")
apm.lib.utils.technology.add.prerequisites("logistic-science-pack", "kr-laboratory")

apm.lib.utils.technology.add.science_pack("automation", "automation-science-pack")

apm.lib.utils.technology.remove.prerequisites_all("electronics")
apm.lib.utils.technology.remove.prerequisites("electronics", "automation")
apm.lib.utils.technology.add.prerequisites("electronics", "apm_lab_1")
apm.lib.utils.technology.add.prerequisites("automation-science-pack", "electronics")
apm.lib.utils.technology.remove.recipe_from_unlock("apm_power_electricity", "electronic-circuit")
apm.lib.utils.technology.add.recipe_for_unlock("electronics", "electronic-circuit")

apm.lib.utils.technology.unit.clear_all("apm_power_electricity")
apm.lib.utils.technology.trigger.set.craft_item("apm_power_electricity", "automation-science-pack", 100)

apm.lib.utils.technology.add.recipe_for_unlock("apm_power_electricity", "kr-wind-turbine")

apm.lib.utils.technology.add.recipe_for_unlock("apm_crusher_machine_0", "firearm-magazine")

apm.lib.utils.technology.add.science_pack("modular-armor", "automation-science-pack")
apm.lib.utils.technology.add.science_pack("modular-armor", "logistic-science-pack")

apm.lib.utils.technology.add.science_pack("automated-rail-transportation", "kr-basic-tech-card")
apm.lib.utils.technology.add.science_pack("automated-rail-transportation", "automation-science-pack")

apm.lib.utils.technology.add.science_pack("railway", "kr-basic-tech-card")
apm.lib.utils.technology.add.science_pack("railway", "automation-science-pack")

apm.lib.utils.technology.add.prerequisites("railway", "steel-processing")

apm.lib.utils.technology.add.prerequisites("electric-mining-drill", "apm_power_electricity")

apm.lib.utils.technology.overwrite.by("apm_electric_mining_drills", "electric-mining-drill")
apm.lib.utils.technology.disable("apm_electric_mining_drills")

apm.lib.utils.technology.add.science_pack("kr-laboratory", "kr-basic-tech-card")
apm.lib.utils.technology.add.science_pack("kr-laboratory", "automation-science-pack")

apm.lib.utils.technology.add.science_pack("apm_fuel-4", "automation-science-pack")
apm.lib.utils.technology.add.science_pack("apm_fuel-4", "logistic-science-pack")

local t2 = function(name)
	apm.lib.utils.technology.remove.science_packs_except(name, {})
	apm.lib.utils.technology.add.science_pack(name, "automation-science-pack")
	apm.lib.utils.technology.add.science_pack(name, "logistic-science-pack")
end

t2("apm_greenhouse-3")
t2("apm_greenhouse-3")
t2("apm_centrifuge_2")
t2("apm_crusher_machine_2")
t2("apm_press_machine_2")
t2("apm_equipment_burner_generator-1")

apm.lib.utils.technology.add.prerequisites("robotics", "chemical-science-pack")
