if not apm then apm = {} end
if not apm.lib then apm.lib = {} end
if not apm.lib.features then apm.lib.features = {} end
if not apm.lib.features.inserters then apm.lib.features.inserters = {} end

apm.lib.features.runtime.register(
	"apm_lib_inserter_functions",
	function()
		return apm.lib.features.getter.boolean(
			apm.lib.features.getter.type.runtime,
			"apm_lib_inserter_functions",
			false
		)
	end
)

apm.lib.features.runtime.register(
	"apm_lib_inserter_iterations_01759",
	function()
		return apm.lib.features.getter.int(
			apm.lib.features.getter.type.runtime,
			"apm_lib_inserter_iterations_01759",
			15
		)
	end
)

apm.lib.features.runtime.register(
	"apm_lib_inserter_valid_targets",
	function()
		return apm.lib.features.getter.string(
			apm.lib.features.getter.type.runtime,
			"apm_lib_inserter_valid_targets",
			""
		)
	end
)

apm.lib.features.runtime.register(
	"apm_lib_inserter_ash_chaining",
	function()
		return apm.lib.features.getter.boolean(
			apm.lib.features.getter.type.runtime,
			"apm_lib_inserter_ash_chaining",
			true
		)
	end
)
