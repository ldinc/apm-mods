require('__apm_lib_ldinc__.lib.features')

if not apm.lib.features.stack_size then apm.lib.features.stack_size = {} end

---@type int64
apm.lib.features.stack_size.ash =
    apm.lib.features.startup.get_int_value_from_setting(
      "apm_power_stack_size_ash", 2000
    )
