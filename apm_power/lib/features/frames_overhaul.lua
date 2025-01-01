require('__apm_lib_ldinc__.lib.features')

---@type boolean
apm.lib.features.frames_overhaul =
		apm.lib.features.startup.get_boolean_value_from_setting(
			"apm_power_overhaul_machine_frames"
		)
