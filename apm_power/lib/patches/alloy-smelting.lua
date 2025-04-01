require('__apm_lib_ldinc__.lib.features')
require('lib.features.compat')
require('__apm_lib_ldinc__.lib.utils.patch.item')
require('__apm_lib_ldinc__.lib.utils.patch.entity')

return function()
	if not apm.lib.features.power.compat.safthelamb then
		return
	end

	local mod_name = "alloy-smelting"

	apm.lib.utils.patch.item.replace(mod_name, "coke", "apm_coke")

	apm.lib.utils.patch.entity.replace(
		mod_name,
		"brick-kiln",
		{name = "brick-kiln", type = "assembling-machine"},
		"stone-furnace"
	)

	apm.lib.utils.patch.entity.replace(
		mod_name,
		"electric-kiln",
		{name = "electric-kiln", type = "assembling-machine"},
		"electric-furnace"
	)
end
