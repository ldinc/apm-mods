require("__apm_lib_ldinc__.lib.features")
require("lib.features.compat")
require("__apm_lib_ldinc__.lib.utils.patch.item")

return function()
	if not apm.lib.features.power.compat.safthelamb then
		return
	end

	local mod_name = "wood-industry"

	apm.lib.utils.patch.item.replace(mod_name, "charcoal", "apm_charcoal")
	apm.lib.utils.patch.item.replace(mod_name, "resin", "apm_resin")
end
