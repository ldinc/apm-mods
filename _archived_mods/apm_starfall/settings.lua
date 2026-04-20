-- startup --------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
data:extend(
{
  {type = "bool-setting", name = "apm_starfall_always_show_made_in", setting_type = "startup", default_value = true, order='aa_a'},
  {type = "bool-setting", name = "apm_starfall_compat_bob", setting_type = "startup", default_value = false, order='pa_a'},
  {type = "bool-setting", name = "apm_starfall_compat_angel", setting_type = "startup", default_value = false, order='pb_a'},
  {type = "bool-setting", name = "apm_starfall_compat_earendel", setting_type = "startup", default_value = false, order='pc_a'},
  {type = "bool-setting", name = "apm_starfall_compat_reverse_factory", setting_type = "startup", default_value = false, order='pd_a'},
  {type = "bool-setting", name = "apm_starfall_update_01801_disable", setting_type = "startup", default_value = false, order='pd_a'},
})

-- runtime-global -------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
data:extend(
{
  {type = "int-setting", name = "apm_starfall_event_min_minutes", setting_type = "runtime-global", minimum_value = 0, default_value = 20, order='aa_a'},
  {type = "int-setting", name = "apm_starfall_event_max_minutes", setting_type = "runtime-global", minimum_value = 0, default_value = 40, order='aa_b'},
  {type = "double-setting", name = "apm_starfall_richness_multiplikator", setting_type = "runtime-global", minimum_value = 0.1, default_value = 1.0, order='ab_a'},
  {type = "bool-setting", name = "apm_starfall_mark_impact_on_map", setting_type = "runtime-global", default_value = false, order='ac_a'},
  {type = "bool-setting", name = "apm_starfall_compat_start_impacts", setting_type = "runtime-global", default_value = true, order='ad_a'},
})

-- runtime-per-user -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
data:extend(
{
  {type = "string-setting", name = "apm_starfall_event_player_sound_volume", setting_type = "runtime-per-user", allow_blank  = false,
   allowed_values = {'apm_sound_type_very_low', 'apm_sound_type_low', 'apm_sound_type_normal'},
   default_value = 'apm_sound_type_normal', order='aa_a'},
  {type = "bool-setting", name = "apm_starfall_event_player_alert_sound", setting_type = "runtime-per-user", default_value = true, order='ab_a'},
  {type = "bool-setting", name = "apm_starfall_event_player_impact_sound", setting_type = "runtime-per-user", default_value = true, order='ab_b'},
})