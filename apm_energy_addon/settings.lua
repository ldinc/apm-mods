-- startup --------------------------------------------------------------------
--
--
-------------------------------------------------------------------------------
data:extend(
{
  {type = "bool-setting", name = "apm_energy_addon_always_show_made_in", setting_type = "startup", default_value = true, order='aa_a'},
  {type = "bool-setting", name = "apm_energy_addon_compat_bob", setting_type = "startup", default_value = false, order='pa_a'},
  {type = "bool-setting", name = "apm_energy_addon_compat_earendel", setting_type = "startup", default_value = false, order='pb_a'},
  {type = "bool-setting", name = "apm_energy_addon_compat_reverse_factory", setting_type = "startup", default_value = false, order='pc_a'},
})