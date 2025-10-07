local crafting_categories = apm.lib.utils.furnace.get.crafting_categories("bi-stone-crusher")

if crafting_categories then
	apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_0", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_1", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_2", crafting_categories)
end

apm.lib.utils.furnace.set.hidden("bi-stone-crusher")

crafting_categories = apm.lib.utils.assembler.get.crafting_categories("bi-cokery")

if crafting_categories then
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_0", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_1", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_coking_plant_2", crafting_categories)
end

apm.lib.utils.assembler.set.hidden("bi-cokery")

crafting_categories = apm.lib.utils.assembler.get.crafting_categories("bi-bio-greenhouse")

if crafting_categories then
	apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_0", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_1", crafting_categories)
	apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_2", crafting_categories)
end

apm.lib.utils.assembler.set.hidden("bi-bio-greenhouse")

-- crafting_categories = apm.lib.utils.assembler.get.crafting_categories("kr-greenhouse")

-- if crafting_categories then
--   apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_0", crafting_categories)
--   apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_1", crafting_categories)
--   apm.lib.utils.assembler.add.crafting_categories("apm_greenhouse_2", crafting_categories)
-- end

-- apm.lib.utils.lab.add.science_pack("apm_lab_1", "kr-basic-tech-card")

-- apm.lib.utils.furnace.set.hidden("kr-crusher")
