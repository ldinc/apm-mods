require('__apm_lib_ldinc__.lib.features')

---@type boolean
apm.lib.features.burner_inserter_with_infinite_energy_source =
    apm.lib.features.startup.get_boolean_value_from_setting(
      "apm_burner_inserter_with_infinite_energy_source"
    )
