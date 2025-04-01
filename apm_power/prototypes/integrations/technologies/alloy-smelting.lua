if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.technology.add.recipe_for_unlock("apm_stone_bricks", "sand")

apm.lib.utils.technology.disable("kiln-smelting")
apm.lib.utils.technology.disable("kiln-smelting-2")
