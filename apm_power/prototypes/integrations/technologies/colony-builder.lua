local apm_power_compat_earendel = settings.startup["apm_power_compat_earendel"].value

if  mods['aai-industry'] and apm_power_compat_earendel then
	-- move all recipies from steam-power to greenhouse

	local list = {
		"colony-consumer-essentials",
		"colony-farming-arboriculture",
		"colony-farming-agriculture",
		"colony-farming-aquaculture",
	}

	for _, recipe in ipairs(list) do
		apm.lib.utils.technology.force.recipe_for_unlock("apm_greenhouse", recipe)
	end

	apm.lib.utils.technology.force.recipe_for_unlock("apm_puddling_furnace_0", "colony-chu1")

	apm.lib.utils.technology.force.recipe_for_unlock("utility-science-pack", "colony-greenhouse")
end
