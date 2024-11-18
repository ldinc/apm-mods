require("util")
require("__apm_lib_ldinc__.lib.log")
require("__apm_lib_ldinc__.lib.utils")

local self = "apm_nuclear/prototypes/main/technologies.lua"

APM_LOG_HEADER(self)

---@param t_name string
---@param t_prerequisites data.TechnologyID[]
---@param t_recipes string[]
---@param t_unit?  data.TechnologyUnit
local new_fn = function(t_name, t_prerequisites, t_recipes, t_unit)
	apm.lib.utils.technology.new(
		"apm_nuclear",
		t_name,
		t_prerequisites,
		t_recipes,
		nil,
		t_unit
	)
end

local new_unit = apm.lib.utils.technology.new_unit

--- [apm_depleted_uranium]
new_fn(
	"apm_depleted_uranium",
	{ "uranium-processing" },
	{ "apm_depleted_uranium_metal_mixture", "apm_depleted_uranium_ingots" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack" },
		250,
		30
	)
)

--- [apm_nuclear_science_pack]
new_fn(
	"apm_nuclear_science_pack",
	{ "uranium-processing", "apm_depleted_uranium" },
	{ "apm_nuclear_science_pack", "apm_hexafluoride_sample" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack" },
		300,
		30
	)
)

--- [apm_nuclear_fuel]
new_fn(
	"apm_nuclear_fuel",
	{ "apm_nuclear_science_pack", "rocket-fuel", "nuclear-fuel-reprocessing" },
	{ "nuclear-fuel" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "apm_nuclear_science_pack" },
		150,
		30
	)
)

--- [apm_nuclear_neptunium_fuel]
new_fn(
	"apm_nuclear_neptunium_fuel",
	{ "apm_nuclear_science_pack", "nuclear-fuel-reprocessing" },
	{
		"apm_fuel_rod_neptunium",
		"apm_fuel_rod_neptunium_cooling",
		"apm_fuel_cell_neptunium_recovery_stage_a",
		"apm_fuel_cell_neptunium_recovery_stage_b",
	},
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "apm_nuclear_science_pack" },
		200,
		30
	)
)

--- [apm_nuclear_rtg]
new_fn(
	"apm_nuclear_rtg",
	{ "apm_nuclear_science_pack", "production-science-pack", "utility-science-pack", "nuclear-fuel-reprocessing" },
	{ "apm_rtg_radioisotope_thermoelectric_generator" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "utility-science-pack",
			"apm_nuclear_science_pack" },
		300,
		30
	)
)

--- [apm_nuclear_breeder]
new_fn(
	"apm_nuclear_breeder",
	{ "apm_nuclear_science_pack", "production-science-pack", "apm_depleted_uranium", "nuclear-fuel-reprocessing" },
	{ "apm_nuclear_breeder", "apm_breeder_container", "apm_breeder_container_worn_maintenance" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "production-science-pack",
			"apm_nuclear_science_pack" },
		250,
		30
	)
)

--- [apm_nuclear_breeder_uranium]
new_fn(
	"apm_nuclear_breeder_uranium",
	{ "apm_nuclear_breeder" },
	{
		"apm_breeder_uranium",
		"apm_breeder_uranium_loaded",
		"apm_breeder_uranium_cooling",
		"apm_breeder_uranium_unloading",
		"apm_breeder_uranium_seperation_process_a",
		"apm_breeder_uranium_seperation_process_b",
	},
	new_unit(
		{
			"automation-science-pack",
			"logistic-science-pack",
			"chemical-science-pack",
			"production-science-pack",
			"apm_nuclear_science_pack",
		},
		750,
		30
	)
)

--- [apm_nuclear_thorium_processing]
new_fn(
	"apm_nuclear_thorium_processing",
	{ "uranium-processing", "apm_nuclear_science_pack" },
	{ "apm_oxide_pellet_th232" },
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "apm_nuclear_science_pack" },
		200,
		30
	)
)

--- [apm_nuclear_thorium_fuel]
new_fn(
	"apm_nuclear_thorium_fuel",
	{ "apm_nuclear_thorium_processing", "nuclear-fuel-reprocessing" },
	{
		"apm_fuel_rod_thorium",
		"apm_fuel_cell_thorium_cooling",
		"apm_fuel_cell_thorium_recovery_stage_a",
		"apm_fuel_cell_thorium_recovery_stage_b",
	},
	new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "apm_nuclear_science_pack" },
		500,
		30
	)
)

--- [apm_nuclear_breeder_thorium]
new_fn(
	"apm_nuclear_breeder_thorium",
	{ "apm_nuclear_breeder", "apm_nuclear_thorium_processing" },
	{
		"apm_breeder_thorium",
		"apm_breeder_thorium_loaded",
		"apm_breeder_thorium_cooling",
		"apm_breeder_thorium_unloading",
		"apm_breeder_thorium_seperation_process_a",
		"apm_breeder_thorium_seperation_process_b",
	},
	new_unit(
		{ "automation-science-pack",
			"logistic-science-pack",
			"chemical-science-pack",
			"production-science-pack",
			"apm_nuclear_science_pack",
		},
		750,
		30
	)
)
