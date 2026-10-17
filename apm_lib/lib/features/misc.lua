if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.science then apm.lib.features.science = {} end

apm.lib.features.science.sort_fn_enabled = apm.lib.features.startup.get_boolean_value_from_setting(
	"apm_lib_resort_science_packs_functions", true)
