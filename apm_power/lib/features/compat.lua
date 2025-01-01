require('__apm_lib_ldinc__.lib.features')

if not apm.lib.features.power then apm.lib.features.power = {} end
if not apm.lib.features.power.compat then apm.lib.features.power.compat = {} end

---@type boolean
apm.lib.features.power.compat.safthelamb =
		apm.lib.features.startup.get_boolean_value_from_setting(
			"apm_power_compat_safthelamb"
		)

---@type boolean
apm.lib.features.power.compat.earendel =
		apm.lib.features.startup.get_boolean_value_from_setting(
			"apm_power_compat_earendel"
		)
