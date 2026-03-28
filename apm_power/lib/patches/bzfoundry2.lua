require("__apm_lib_ldinc__.lib.features")
require("lib.features.compat")
require("__apm_lib_ldinc__.lib.utils.patch.item")
require("__apm_lib_ldinc__.lib.utils.patch.entity")

return function()
	local mod_name = "bzfoundry2"

	apm.lib.utils.patch.item.replace(mod_name, "coke", "apm_coke")
end
