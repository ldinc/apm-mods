if mods["bzsilicon"] then
	local categories = { "basic-crushing" }

	if categories then
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_0", categories)
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_1", categories)
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_2", categories)
	end
end
