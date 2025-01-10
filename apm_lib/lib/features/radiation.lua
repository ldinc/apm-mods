-- { type = "bool-setting",   name = "apm_lib_radiation_dmg",                     setting_type = "runtime-global", default_value = true,                                                           order = 'ac_a' },
-- { type = "double-setting", name = "apm_lib_radiation_dmg_multiplier",          setting_type = "runtime-global", minimum_value = 0.1,

apm.lib.features.runtime.register(
  "radiation_dmg",
  function()
    return apm.lib.features.getter.boolean(
      apm.lib.features.getter.type.runtime,
      "apm_lib_radiation_dmg",
      true
    )
  end
)

apm.lib.features.runtime.register(
  "radiation_dmg_multiplier",
  function()
    return apm.lib.features.getter.double(
      apm.lib.features.getter.type.runtime,
      "apm_lib_radiation_dmg_multiplier",
      0.1
    )
  end
)
