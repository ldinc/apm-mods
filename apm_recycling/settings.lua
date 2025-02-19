data:extend(
{
  {type = "int-setting", name = "apm_recycler_payback", setting_type = "startup", minimum_value = 5, maximum_value = 100, default_value = 10, order='aa_a'},
  {type = "int-setting", name = "apm_recycler_conversion", setting_type = "startup", minimum_value = 1, maximum_value = 5, default_value = 3, order='aa_b'},
  {type = "bool-setting", name = "apm_recycler_always_show_made_in", setting_type = "startup", default_value = true, order='ab_a'},

  {type = "bool-setting", name = "apm_recycler_integration_bob", setting_type = "startup", default_value = false, order='ia_a'},
  {type = "bool-setting", name = "apm_recycler_integration_angel", setting_type = "startup", default_value = false, order='ia_b'},
  {type = "bool-setting", name = "apm_recycler_integration_earendel", setting_type = "startup", default_value = false, order='ia_c'},
  {type = "bool-setting", name = "apm_recycler_integration_kingarthur", setting_type = "startup", default_value = false, order='ia_d'},
  {type = "bool-setting", name = "apm_recycler_integration_sctm", setting_type = "startup", default_value = false, order='ia_e'},

  {type = "bool-setting", name = "apm_recycler_compat_bob", setting_type = "startup", default_value = false, order='pa_a'},
  {type = "bool-setting", name = "apm_recycler_compat_angel", setting_type = "startup", default_value = false, order='pb_a'},
  {type = "bool-setting", name = "apm_recycler_compat_earendel", setting_type = "startup", default_value = false, order='pc_a'},
  {type = "bool-setting", name = "apm_recycler_compat_kingarthur", setting_type = "startup", default_value = false, order='pe_a'},
  {type = "bool-setting", name = "apm_recycler_compat_sctm", setting_type = "startup", default_value = false, order='pf_a'},

})