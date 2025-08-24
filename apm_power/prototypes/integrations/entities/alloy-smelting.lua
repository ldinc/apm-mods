if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.assembler.set.hidden("brick-kiln")
apm.lib.utils.assembler.set.hidden("electric-kiln")

local categories = apm.lib.utils.assembler.get.crafting_categories("brick-kiln")

if categories then
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_0", categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_1", categories)
end

categories = apm.lib.utils.assembler.get.crafting_categories("electric-kiln")

if categories then
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_2", categories)
end
