-- More tips and tricks of apm_power (the inserter tips with simulations are in prototypes/tips.lua).
-- Added in data-final-fixes through apm.lib.utils.tips.add, which skips a tip whose
-- prototypes an integration or a setting has removed.

local tips = apm.lib.utils.tips

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-refined-fuel",
	category = "apm",
	order = "p-a",
	indent = 1,
	tag = "[item=apm_coke][item=coal]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_coking_plant_0"),
}, { recipe = { "apm_coking_plant_0" }, item = { "apm_coke" } })

tips.add({
		type = "tips-and-tricks-item",
		name = "apm-crushing-sifting",
		category = "apm",
		order = "p-b",
		indent = 1,
		tag = "[entity=apm_crusher_machine_0][entity=apm_sieve_0]",
		dependencies = { "apm-introduction" },
		trigger = tips.unlock_trigger("apm_crusher_machine_0"),
		simulation = tips.simulation("__apm_power_ldinc__/simulations/crushing-sifting.lua"),
	},
	{ recipe = { "apm_crusher_machine_0", "apm_crushed_stone", "apm_dry_mud_sifting_iron" }, ["assembling-machine"] = { "apm_crusher_machine_0", "apm_sieve_0" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-ash-uses",
	category = "apm",
	order = "p-c",
	indent = 1,
	tag = "[item=apm_generic_ash]",
	dependencies = { "apm-ash-chaining" },
	trigger = tips.unlock_trigger("apm_fertiliser_1"),
}, { recipe = { "apm_fertiliser_1" }, ["tips-and-tricks-item"] = { "apm-ash-chaining" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-sinkhole",
	category = "apm",
	order = "p-d",
	indent = 1,
	tag = "[entity=apm_sinkhole]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_sinkhole"),
	simulation = tips.simulation("__apm_power_ldinc__/simulations/sinkhole.lua"),
}, { recipe = { "apm_sinkhole" }, furnace = { "apm_sinkhole", "apm_sinkhole_small" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-steam-inserters",
	category = "apm",
	order = "p-e",
	indent = 1,
	tag = "[entity=apm_steam_inserter]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_steam_inserter"),
	simulation = tips.simulation("__apm_power_ldinc__/simulations/steam-inserters.lua"),
}, { recipe = { "apm_steam_inserter" }, inserter = { "apm_steam_inserter", "apm_steam_inserter_long" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-equipment-manager",
	category = "apm",
	order = "p-f",
	indent = 1,
	tag = "[item=apm_equipment_burner_generator_basic]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_equipment_burner_generator_basic"),
}, { recipe = { "apm_equipment_burner_generator_basic" } })
