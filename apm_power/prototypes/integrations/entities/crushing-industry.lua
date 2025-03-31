if not apm.lib.features.power.compat.safthelamb then
	return
end

local safthelamb_categories = {
	"basic-crushing",
	"basic-crushing-or-crafting",
	"basic-crushing-or-hand-crafting"
}

local apm_categories = {
	"apm_crusher",
	"apm_crusher_2",
	"apm_crusher_3",
}

apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_0", safthelamb_categories)
apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_1", safthelamb_categories)
apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_2", safthelamb_categories)

apm.lib.utils.assembler.add.crafting_categories("big-crusher", apm_categories)

apm.lib.utils.furnace.set.hidden("burner-crusher")
apm.lib.utils.furnace.set.hidden("electric-crusher")