if mods["bzlead"] then
	apm.lib.utils.technology.add.recipe_for_unlock("apm_press_machine_0", "apm_dry_stone_brick")


	if mods["wood-industry"] and mods["alloy-smelting"] then
		apm.lib.utils.technology.remove.prerequisites_all("kiln-smelting")
		apm.lib.utils.technology.add.prerequisites("kiln-smelting", "apm_press_machine_0")
	end
end

if mods["bzcarbon"] then
	apm.lib.utils.technology.remove.prerequisites_all("fluid-mining")

	apm.lib.utils.technology.remove.prerequisites("steel-processing", "graphite-processing")
	apm.lib.utils.technology.add.prerequisites("fluid-mining", "apm_electric_mining_drills")

	local prereq = {
		"lubricant",
		"fluid-hadndling",
		"nuclear-power",
		"battery",
		"advanced-material-processing-2",
		"fullerenes"
	}

	for _, v in ipairs(prereq) do
		apm.lib.utils.technology.add.prerequisites(v, "graphite-processing")
	end

	-- apm.lib.utils.technology.delete("fluid-mining")
	apm.lib.utils.technology.delete("electric-mining-drill")
	apm.lib.utils.technology.delete("electronics")

	-- apm.lib.utils.technology.remove.prerequisites("uranium-processing", "fluid-mining")
	-- apm.lib.utils.technology.remove.prerequisites("titanium-processing", "fluid-mining")

	apm.lib.utils.technology.add.recipe_for_unlock("graphite-processing", "apm_bz_graphite_electronic-circuit")
end

if mods["bztitanium"] then
	-- apm.lib.utils.technology.remove.prerequisites("uranium-processing", "fluid-mining")
	-- apm.lib.utils.technology.remove.prerequisites("titanium-processing", "fluid-mining")
end

if mods["bzsilicon"] then
	apm.lib.utils.technology.remove.prerequisites_all("graphite-processing")
	apm.lib.utils.technology.remove.recipe_from_unlock("graphite-processing", "basic-crusher")
	apm.lib.utils.technology.add.prerequisites("graphite-processing", "apm_crusher_machine_0")
end

if mods["bzzirconium"] then
	apm.lib.utils.technology.add.prerequisites("zirconia-processing", "logistic-science-pack")
end
