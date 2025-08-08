apm.lib.features.runtime.register(
	"apm_lib_radiation_dmg",
	function()
		return apm.lib.features.getter.boolean(
			apm.lib.features.getter.type.runtime,
			"apm_lib_radiation_dmg",
			true
		)
	end
)

apm.lib.features.runtime.register(
	"apm_lib_radiation_dmg_multiplier",
	function()
		return apm.lib.features.getter.double(
			apm.lib.features.getter.type.runtime,
			"apm_lib_radiation_dmg_multiplier",
			0.1
		)
	end
)

apm.lib.features.runtime.register(
	"apm_lib_radiation_dmg_based_on_stack",
	function()
		return apm.lib.features.getter.boolean(
			apm.lib.features.getter.type.runtime,
			"apm_lib_radiation_dmg_based_on_stack",
			false
		)
	end
)
