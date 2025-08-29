require("__apm_lib_ldinc__.lib.features")
require("lib.features.compat")
require("__apm_lib_ldinc__.lib.utils.patch.item")
require("__apm_lib_ldinc__.lib.utils.patch.entity")

return function()
	if not apm.lib.features.power.compat.safthelamb then
		return
	end

	local mod_name = "crushing-industry"

	apm.lib.utils.patch.item.replace(mod_name, "crushed-coal", "apm_coal_crushed")

	apm.lib.utils.patch.entity.replace(
		mod_name,
		"burner-crusher",
		{ name = "burner-crusher", type = "furnace" },
		"apm_crusher_machine_0"
	)

	apm.lib.utils.patch.entity.replace(
		mod_name,
		"electric-crusher",
		{ name = "electric-crusher", type = "furnace" },
		"apm_crusher_machine_2"
	)
end
