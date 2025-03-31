if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.technology.remove.recipe_from_unlock("oil-processing", "crushed-coal")

apm.lib.utils.technology.remove.recipe_from_unlock("ore-crushing", "electric-crusher")
apm.lib.utils.technology.remove.prerequisites_all("ore-crushing")
apm.lib.utils.technology.add.prerequisites("ore-crushing", "apm_stone_bricks")
apm.lib.utils.technology.force.update_science_packs("ore-crushing")

apm.lib.utils.technology.remove.recipe_from_unlock("steam-power", "burner-crusher")
apm.lib.utils.technology.remove.recipe_from_unlock("steam-power", "sand")
apm.lib.utils.technology.add.recipe_for_unlock("apm_stone_bricks", "sand")
apm.lib.utils.technology.add.prerequisites("electronics", "apm_stone_bricks")
