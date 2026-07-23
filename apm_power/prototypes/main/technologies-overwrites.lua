require("util")
require("__apm_lib_ldinc__.lib.log")

--- vanilla

apm.lib.utils.technology.force.recipe_for_unlock("apm_stone_bricks", "stone-brick")
apm.lib.utils.technology.add.prerequisites("stone-walls", "apm_stone_bricks")

apm.lib.utils.technology.force.recipe_for_unlock("landfill", "apm_landfill")

apm.lib.utils.technology.add.science_pack("logistics", "apm_industrial_science_pack")
apm.lib.utils.technology.remove.science_pack("logistics", "automation-science-pack")
apm.lib.utils.technology.force.recipe_for_unlock("logistics", "transport-belt")
apm.lib.utils.technology.mod.unit_count("logistics", 10)
apm.lib.utils.technology.force.prerequisites("logistics", "apm_rubber-1")

apm.lib.utils.technology.force.recipe_for_unlock("apm_water_supply-1", "pipe")
apm.lib.utils.technology.force.recipe_for_unlock("apm_water_supply-1", "pipe-to-ground")
apm.lib.utils.technology.remove.recipe_from_unlock("fluid-handling", "storage-tank")
apm.lib.utils.technology.remove.recipe_from_unlock("fluid-handling", "empty-apm_coke_oven_gas-barrel")
apm.lib.utils.technology.remove.recipe_from_unlock("fluid-handling", "apm_coke_oven_gas-barrel")
apm.lib.utils.technology.force.recipe_for_unlock("apm_stone_bricks", "storage-tank")

apm.lib.utils.technology.add.science_pack("turrets", "apm_industrial_science_pack")
apm.lib.utils.technology.remove.science_pack("turrets", "automation-science-pack")

apm.lib.utils.technology.add.science_pack("stone-walls", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("stone-walls", "automation-science-pack")
apm.lib.utils.technology.mod.unit_count("stone-walls", 20)

apm.lib.utils.technology.add.science_pack("military", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("military", "automation-science-pack")
apm.lib.utils.technology.force.prerequisites("military", "apm_press_machine_0")

--- [steel-processing]
apm.lib.utils.technology.add.prerequisites("steel-processing", "automation-science-pack")
apm.lib.utils.technology.remove.recipe_from_unlock("steel-processing", "steel-plate")

--- [steel-axe]
apm.lib.utils.technology.add.science_pack("steel-axe", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("steel-axe", "automation-science-pack")
apm.lib.utils.technology.force.prerequisites("steel-axe", "apm_puddling_furnace_0")

--- [railway]
apm.lib.utils.technology.add.science_pack("railway", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.add.science_pack("railway", "apm_steam_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("railway", "automation-science-pack")
apm.lib.utils.technology.remove.science_pack("railway", "logistic-science-pack")
apm.lib.utils.technology.force.prerequisites("railway", { "apm_power_steam", "apm_treated_wood_planks-1" })

--- [automated-rail-transportation]
apm.lib.utils.technology.add.science_pack("automated-rail-transportation", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.add.science_pack("automated-rail-transportation", "apm_steam_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("automated-rail-transportation", "automation-science-pack")
apm.lib.utils.technology.remove.science_pack("automated-rail-transportation", "logistic-science-pack")

apm.lib.utils.technology.add.prerequisites("rail-signals", "apm_power_electricity")
--apm.lib.utils.technology.add.science_pack('rail-signals', 'apm_industrial_science_pack', 1)
--apm.lib.utils.technology.add.science_pack('rail-signals', 'apm_steam_science_pack', 1)
apm.lib.utils.technology.remove.science_pack("rail-signals", "logistic-science-pack")

apm.lib.utils.technology.force.recipe_for_unlock("apm_power_electricity", "steam-engine")
apm.lib.utils.technology.force.recipe_for_unlock("apm_power_electricity", "small-electric-pole")
apm.lib.utils.technology.force.recipe_for_unlock("apm_power_electricity", "electronic-circuit")
apm.lib.utils.recipe.disable("electric-mining-drill")
apm.lib.utils.recipe.disable("offshore-pump")

--- [automation]
apm.lib.utils.technology.add.prerequisites("automation", "apm_power_electricity")
apm.lib.utils.technology.remove.prerequisites("automation", "automation-science-pack")

apm.lib.utils.technology.add.science_pack("automation", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.add.science_pack("automation", "apm_steam_science_pack", 1)

apm.lib.utils.technology.force.recipe_for_unlock("automation", "inserter")

apm.lib.utils.technology.mod.unit_count("automation", 75)
apm.lib.utils.technology.mod.unit_time("automation", 30)

apm.lib.utils.technology.add.prerequisites("optics", "apm_power_electricity")
--apm.lib.utils.technology.add.science_pack('optics', 'apm_industrial_science_pack', 1)
apm.lib.utils.technology.mod.unit_count("optics", 50)
apm.lib.utils.technology.mod.unit_time("optics", 25)

apm.lib.utils.technology.add.prerequisites("logistic-science-pack", "automation")
--apm.lib.utils.technology.add.science_pack('logistic-science-pack', 'apm_industrial_science_pack', 1)
apm.lib.utils.technology.force.recipe_for_unlock("logistic-science-pack", "lab")



apm.lib.utils.technology.add.prerequisites("heavy-armor", "apm_puddling_furnace_0")
apm.lib.utils.technology.remove.prerequisites("heavy-armor", "steel-processing")
apm.lib.utils.technology.add.science_pack("heavy-armor", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("heavy-armor", "automation-science-pack")

apm.lib.utils.technology.add.science_pack("weapon-shooting-speed-1", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("weapon-shooting-speed-1", "automation-science-pack")
apm.lib.utils.technology.add.science_pack("physical-projectile-damage-1", "apm_industrial_science_pack", 1)
apm.lib.utils.technology.remove.science_pack("physical-projectile-damage-1", "automation-science-pack")

apm.lib.utils.technology.add.prerequisites("weapon-shooting-speed-2", "logistic-science-pack")
apm.lib.utils.technology.add.prerequisites("physical-projectile-damage-2", "logistic-science-pack")

apm.lib.utils.technology.force.recipe_for_unlock("uranium-processing", "apm_coal_ash_washing")

apm.lib.utils.technology.add.recipe_for_unlock("concrete", "apm_sinkhole")


--- [steam-power]
apm.lib.utils.technology.add.prerequisites("steam-power", "apm_puddling_furnace_0")

apm.lib.utils.technology.add.recipe_for_unlock("steam-power", "apm_fuel-1")
apm.lib.utils.technology.add.recipe_for_unlock("steam-power", "apm_puddling_furnace_0")
apm.lib.utils.technology.add.recipe_for_unlock("steam-power", "apm_water_supply-1")
apm.lib.utils.technology.add.recipe_for_unlock("steam-power", "apm_stone_bricks")

apm.lib.utils.technology.trigger.set.craft_item("steam-power", "steel-plate", 50)

--- [electric-engine]
apm.lib.utils.technology.add.prerequisites("electric-engine", "engine")
apm.lib.utils.technology.remove.prerequisites("electric-engine", "lubricant")
apm.lib.utils.technology.add.prerequisites("electric-engine", "apm_power_automation_science_pack")


--- [automation-science-pack]
apm.lib.utils.technology.add.prerequisites("automation-science-pack", "apm_treated_wood_planks-1")
apm.lib.utils.technology.remove.prerequisites("automation-science-pack", "steam-power")
apm.lib.utils.technology.trigger.set.craft_item("automation-science-pack", "apm_lab_1")

apm.lib.utils.technology.add.recipe_for_unlock("basic-logistics", "automation-science-pack")
apm.lib.utils.technology.add.recipe_for_unlock("automation-science-pack", "apm_electromagnet")
apm.lib.utils.technology.add.recipe_for_unlock("automation-science-pack", "apm_egen_unit")

--- [electronics]
apm.lib.utils.technology.add.prerequisites("electronics", "apm_lab_1")

apm.lib.utils.technology.trigger.set.craft_item("electronics", "apm_steam_science_pack", 150)

--- [iron-stick]
apm.lib.utils.technology.remove.recipe_from_unlock("railway", "iron-stick")
apm.lib.utils.recipe.enable("iron-stick")

-- apm.lib.utils.technology.force.recipe_for_unlock('military-2', 'radar')

--- [gun-turret]
apm.lib.utils.technology.remove.prerequisites_all("gun-turret")
apm.lib.utils.technology.force.prerequisites("gun-turret", { "military" })
apm.lib.utils.technology.remove.science_packs_except("gun-turret", { "apm_industrial_science_pack" })
apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("gun-turret")

--- [fast-inserter]
apm.lib.utils.technology.remove.prerequisites("fast-inserter", "automation-science-pack")

--- [lamp]
apm.lib.utils.technology.remove.prerequisites("lamp", "automation-science-pack")

--- [radar]
apm.lib.utils.technology.remove.prerequisites("radar", "automation-science-pack")

--- [logistic-science-pack]
apm.lib.utils.technology.remove.prerequisites("logistic-science-pack", "automation-science-pack")


--- [automation-2]
apm.lib.utils.technology.remove.prerequisites("automation-2", "automation")

--- [robotics]
apm.lib.utils.technology.remove.science_pack("robotics", "chemical-science-pack")

--- [construction-robotics]
apm.lib.utils.technology.remove.science_pack("construction-robotics", "chemical-science-pack")

--- [logistic-robotics]
apm.lib.utils.technology.remove.science_pack("logistic-robotics", "chemical-science-pack")

--- [worker-robots-speed-1]
apm.lib.utils.technology.remove.science_pack("worker-robots-speed-1", "chemical-science-pack")

--- [worker-robots-storage-1]
apm.lib.utils.technology.remove.science_pack("worker-robots-storage-1", "chemical-science-pack")

--- [personal-roboport-equipment]
apm.lib.utils.technology.add.science_pack("personal-roboport-equipment", "chemical-science-pack")

--- [worker-robots-speed-2]
apm.lib.utils.technology.add.science_pack("worker-robots-speed-2", "chemical-science-pack")

if not mods["space-age"] then
	apm.lib.utils.technology.remove.recipe_from_unlock("steam-power", "offshore-pump")
else
	apm.lib.utils.technology.remove.recipe_from_unlock("steam-power", "offshore-pump")
	apm.lib.utils.technology.add.recipe_for_unlock("tungsten-steel", "offshore-pump")
end


--- space age
