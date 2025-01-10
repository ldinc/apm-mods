-- startup --------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
data:extend({
	{ type = "string-setting", name = "apm_lib_log_level", setting_type = "startup", allow_blank = false, allowed_values = { '0: Error', '1: Warning', '2: Info' }, default_value = '0: Error', order = 'aa_a' },
	-- {
	-- 	type          = "string-setting",
	-- 	name          = "apm_lib_player_items",
	-- 	setting_type  = "startup",
	-- 	allow_blank   = true,
	-- 	default_value =
	-- 	'apm_assembling_machine_0:10 burner-mining-drill:10 apm_coke:400 wood:200 stone:100 burner-inserter:10 personal-roboport-equipment:1 battery-equipment:1 apm_zx80_construction_robot:5 modular-armor:1 apm_equipment_burner_generator_basic:1',
	-- 	order         = 'aa_a'
	-- },
	--- [apm_lib_stack_size]
	{
		type = "int-setting",
		name = "apm_lib_stack_size",
		setting_type = "startup",
		default_value = 200,
		minimum_value = 50,
		maximum_value = 200,
		allowed_values = { 50, 100, 200 },
		order = 'bc_a',
	},
	{
		type = "int-setting",
		name = "apm_lib_stack_size_ash",
		setting_type = "startup",
		default_value = 2000,
		minimum_value = 50,
		maximum_value = 2000,
		allowed_values = { 50, 100, 200, 400, 800, 1000, 2000 },
		order = 'de_a',
	},
})

-- runtime-global -------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local setting = {
	type = "bool-setting",
	name = "apm_lib_inserter_functions",
	setting_type = "runtime-global",
	default_value = true,
	order =
	'aa_a'
}
if mods.apm_power then
	setting.default_value = true
	log('Info: settings.lua: apm_lib_inserter_functions.default_value is: true')
else
	setting.default_value = false
	log('Info: settings.lua: apm_lib_inserter_functions.default_value is: false')
end
data:extend({ setting })

data:extend({
	{ type = "int-setting",    name = "apm_lib_inserter_iterations_01759",         setting_type = "runtime-global", minimum_value = 0,                                                              maximum_value = 100, default_value = 15, order = 'aa_b' },
	{ type = "string-setting", name = "apm_lib_inserter_valid_targets",            setting_type = "runtime-global", default_value = 'assembling-machine, furnace, lab, mining-drill, boiler, pump', order = 'aa_c' },
	{ type = "bool-setting",   name = "apm_lib_storage_spit_out",                  setting_type = "runtime-global", default_value = true,                                                           order = 'ab_a' },
	{ type = "bool-setting",   name = "apm_lib_storage_spit_out_mark_deconstruct", setting_type = "runtime-global", default_value = true,                                                           order = 'ab_b' },
	{ type = "int-setting",    name = "apm_lib_storage_spit_out_iterations",       setting_type = "runtime-global", minimum_value = 1,                                                              default_value = 48,  order = 'ab_c' },
	{ type = "bool-setting",   name = "apm_lib_radiation_dmg",                     setting_type = "runtime-global", default_value = true,                                                           order = 'ac_a' },
	{ type = "double-setting", name = "apm_lib_radiation_dmg_multiplier",          setting_type = "runtime-global", minimum_value = 0.1,                                                            default_value = 1.0, order = 'ac_b' },
	{ type = "bool-setting",   name = "apm_lib_radiation_dmg_based_on_stack",      setting_type = "runtime-global", default_value = false,                                                           order = 'ac_a' },
})

-- runtime-per-user -----------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
data:extend({
	{ type = "bool-setting", name = "apm_lib_burner_equipment_alerts_sound", setting_type = "runtime-per-user", default_value = true, order = 'aa_a' },
})
