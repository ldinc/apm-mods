if not apm.lib.features.power.compat.safthelamb then
	return
end

-- logistic-science-pack

if mods["bobtech"] then
	if apm.lib.utils.technology.has.science_pack("heavy-armor", "logistic-science-pack") then
		apm.lib.utils.technology.force.update_science_packs("heavy-armor")
	end
end
