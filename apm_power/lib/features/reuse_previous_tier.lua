require('__apm_lib_ldinc__.lib.features')

---@type boolean
apm.lib.features.reuse_previous_tier =
    apm.lib.features.startup.get_boolean_value_from_setting(
      "apm_power_machine_reusable_recipies"
    )
