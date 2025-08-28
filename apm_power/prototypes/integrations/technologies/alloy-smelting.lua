if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.technology.add.recipe_for_unlock("apm_stone_bricks", "sand")

apm.lib.utils.technology.disable("kiln	-smelting")
apm.lib.utils.technology.disable("kiln-smelting-2")

apm.lib.utils.technology.remove.recipe_from_unlock("advanced-material-processing-2", "electric-kiln")

if mods["wood-industry"] then
	apm.lib.utils.technology.add.prerequisites("kiln-smelting", "apm_stone_bricks")
end
