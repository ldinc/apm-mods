local categories = apm.lib.utils.assembler.get.crafting_categories("apm_coking_plant_0")

if categories then
	apm.lib.utils.assembler.add.crafting_categories("foundry", categories)
end
