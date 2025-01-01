require('__apm_lib_ldinc__.lib.features')

if not apm.lib.features.show then apm.lib.features.show = {} end

---@type boolean
apm.lib.features.show.made_in =
		apm.lib.features.startup.get_boolean_value_from_setting(
			"apm_power_always_show_made_in"
		)