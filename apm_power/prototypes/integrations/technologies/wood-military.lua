if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.technology.add.prerequisites("military", "apm_puddling_furnace_0")

apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("heavy-armor")

-- logistic-science-pack

if mods["bobtech"] then
	if apm.lib.utils.technology.has.science_pack("heavy-armor", "logistic-science-pack") then
		apm.lib.utils.technology.force.update_science_packs("heavy-armor")
	end
end


---TTree optimizing
apm.lib.utils.technology.remove.prerequisites("military", "apm_press_machine_0")
apm.lib.utils.technology.remove.prerequisites("heavy-armor", "apm_puddling_furnace_0")
