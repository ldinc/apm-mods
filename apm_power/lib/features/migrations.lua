require('__apm_lib_ldinc__.lib.features')

if not apm.lib.features.power then apm.lib.features.power = {} end

---@type boolean
apm.lib.features.power.migrations_patches_enabled =
		apm.lib.features.startup.get_boolean_value_from_setting(
			"apm_extra_migrations_enabled",
      false
		)
