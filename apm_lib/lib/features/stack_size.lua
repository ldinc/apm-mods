if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.stack_size then apm.lib.features.stack_size = {} end

apm.lib.features.stack_size.default = apm.lib.features.startup.get_int_value_from_setting("apm_lib_stack_size", 200)
