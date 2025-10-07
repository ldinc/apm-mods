apm.lib.utils.recipe.disable("bi-crushed-stone-1")

apm.lib.utils.technology.force.recipe_for_unlock("apm_power_electricity", "bi-wooden-pole-big")
apm.lib.utils.technology.force.recipe_for_unlock("apm_water_supply-1", "bi-wood-pipe")
apm.lib.utils.technology.force.recipe_for_unlock("apm_water_supply-1", "bi-wood-pipe-to-ground")
apm.lib.utils.technology.force.recipe_for_unlock("railway", "bi-rail-wood")


apm.lib.utils.technology.delete("apm_fertiliser_2")
apm.lib.utils.technology.delete("apm_fertiliser_1")
apm.lib.utils.technology.remove.science_pack("apm_greenhouse-3", "chemical-science-pack")
apm.lib.utils.technology.add.prerequisites("bi-tech-bio-farming", "apm_greenhouse-3")
apm.lib.utils.technology.add.prerequisites("apm_greenhouse-3", "lamp")
