if mods["bzlead"] or mods["bzlead2"] then
	apm.lib.utils.technology.add.recipe_for_unlock("apm_press_machine_0", "apm_dry_stone_brick")


	if mods["wood-industry"] and mods["alloy-smelting"] then
		apm.lib.utils.technology.remove.prerequisites_all("kiln-smelting")
		apm.lib.utils.technology.add.prerequisites("kiln-smelting", "apm_press_machine_0")
	end
end

if mods["bzcarbon"] or mods["bzcarbon2"] then
	apm.lib.utils.technology.remove.prerequisites_all("fluid-mining")

	apm.lib.utils.technology.remove.prerequisites("steel-processing", "graphite-processing")
	apm.lib.utils.technology.add.prerequisites("fluid-mining", "apm_electric_mining_drills")

	apm.lib.utils.technology.remove.prerequisites("electronics", "graphite-processing")

	apm.lib.utils.technology.force.recipe_for_unlock("electronics", "copper-cable")
	apm.lib.utils.technology.force.recipe_for_unlock("electronics", "electronic-circuit")

	apm.lib.utils.technology.remove.prerequisites_all("fluid-mining")
	apm.lib.utils.technology.add.prerequisites("fluid-mining", "apm_steam_mining_drill")

	apm.lib.utils.technology.remove.prerequisites("graphite-processing", "electric-mining-drill")
	apm.lib.utils.technology.add.prerequisites("electronics", "graphite-processing")

	apm.lib.utils.technology.add.prerequisites("graphene", "production-science-pack")

	--- TTree cleanup
	apm.lib.utils.technology.remove.prerequisites("apm_electric_mining_drills", "apm_steam_mining_drill")
	apm.lib.utils.technology.remove.prerequisites("electric-mining-drill", "steam-power")
	apm.lib.utils.technology.remove.prerequisites("fluid-handling", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("battery", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("uranium-processing", "fluid-mining")
	apm.lib.utils.technology.remove.prerequisites("nuclear-power", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("nuclear-power", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("advanced-material-processing-2", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("fullerenes", "oil-processing")
	apm.lib.utils.technology.remove.prerequisites("fullerenes", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("lubricant", "graphite-processing")
	apm.lib.utils.technology.remove.prerequisites("military-3", "chemical-science-pack")
	apm.lib.utils.technology.remove.prerequisites("laser", "chemical-science-pack")
	apm.lib.utils.technology.remove.prerequisites("low-density-structure", "advanced-material-processing")
	apm.lib.utils.technology.remove.prerequisites("low-density-structure", "chemical-science-pack")
end

if mods["bztitanium"] or mods["bztitanium2"] then
	-- apm.lib.utils.technology.remove.prerequisites("uranium-processing", "fluid-mining")
	-- apm.lib.utils.technology.remove.prerequisites("titanium-processing", "fluid-mining")
end

if mods["bzsilicon"] or mods["bzsilicon2"] then
	apm.lib.utils.technology.remove.prerequisites_all("graphite-processing")
	apm.lib.utils.technology.remove.recipe_from_unlock("graphite-processing", "basic-crusher")
	apm.lib.utils.technology.add.prerequisites("graphite-processing", "apm_crusher_machine_0")
end

if mods["bzzirconium"] or mods["bzzirconium2"] then
	apm.lib.utils.technology.add.prerequisites("zirconia-processing", "logistic-science-pack")
end
