require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/technologies.lua'

APM_LOG_HEADER(self)

-- Technologie ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
-- local automation_science_pack = {}
-- automation_science_pack.type = 'technology'
-- automation_science_pack.name = 'apm_power_automation_science_pack'
-- automation_science_pack.icon = '__base__/graphics/technology/automation-science-pack.png'
-- automation_science_pack.icon_size = 256
-- automation_science_pack.icon_mipmaps = 4
-- automation_science_pack.effects = {
-- 	{ type = 'unlock-recipe', recipe = 'automation-science-pack' },
-- 	{ type = 'unlock-recipe', recipe = 'apm_electromagnet' },
-- 	{ type = 'unlock-recipe', recipe = 'apm_egen_unit' },
-- }
-- automation_science_pack.prerequisites = { 'apm_lab_1', 'apm_treated_wood_planks-1' }
-- automation_science_pack.unit = {}
-- automation_science_pack.unit.count = 100
-- automation_science_pack.unit.ingredients = { { "apm_industrial_science_pack", 1 }, { "apm_steam_science_pack", 1 } }
-- automation_science_pack.unit.time = 20
-- automation_science_pack.order = 'aa_a'
-- data:extend({ automation_science_pack })

local apm_inserter_bonus = {}
apm_inserter_bonus.type = 'technology'
apm_inserter_bonus.name = 'apm_inserter_capacity_bonus'
apm_inserter_bonus.icon = '__base__/graphics/technology/inserter-capacity.png'
apm_inserter_bonus.icon_size = 256
apm_inserter_bonus.icon_mipmaps = 4
apm_inserter_bonus.effects = {
	{ type = 'inserter-stack-size-bonus', modifier = 1 },
}
apm_inserter_bonus.prerequisites = { 'apm_puddling_furnace_0' }
apm_inserter_bonus.unit = {}
apm_inserter_bonus.unit.count = 50
apm_inserter_bonus.unit.ingredients = { { "apm_industrial_science_pack", 1 } }
apm_inserter_bonus.unit.time = 25
apm_inserter_bonus.order = 'aa_a'
data:extend({ apm_inserter_bonus })

local apm_steam_mining_drill = {}
apm_steam_mining_drill.type = 'technology'
apm_steam_mining_drill.name = 'apm_steam_mining_drill'
apm_steam_mining_drill.icon = '__base__/graphics/technology/mining-productivity.png'
apm_steam_mining_drill.icon_size = 256
apm_steam_mining_drill.icon_mipmaps = 4
apm_steam_mining_drill.effects = {
	{ type = 'unlock-recipe', recipe = 'apm_steam_mining_drill' },
}
apm_steam_mining_drill.prerequisites = { 'apm_steam_science_pack' }
apm_steam_mining_drill.unit = {}
apm_steam_mining_drill.unit.count = 75
apm_steam_mining_drill.unit.ingredients = { { "apm_industrial_science_pack", 1 }, { "apm_steam_science_pack", 1 } }
apm_steam_mining_drill.unit.time = 20
apm_steam_mining_drill.order = 'aa_a'
data:extend({ apm_steam_mining_drill })

local apm_electric_mining_drills = {}
apm_electric_mining_drills.type = 'technology'
apm_electric_mining_drills.name = 'apm_electric_mining_drills'
apm_electric_mining_drills.icon = '__base__/graphics/technology/mining-productivity.png'
apm_electric_mining_drills.icon_size = 256
apm_electric_mining_drills.icon_mipmaps = 4
apm_electric_mining_drills.effects = {
	{ type = 'unlock-recipe', recipe = 'electric-mining-drill' },
}
apm_electric_mining_drills.prerequisites = { 'apm_steam_mining_drill', 'apm_power_electricity', 'electronics' }
apm_electric_mining_drills.unit = {}
apm_electric_mining_drills.unit.count = 30
apm_electric_mining_drills.unit.ingredients = { { "automation-science-pack", 1 } }
apm_electric_mining_drills.unit.time = 30
apm_electric_mining_drills.order = 'aa_a'
data:extend({ apm_electric_mining_drills })

-- Technologie ----------------------------------------------------------------
-- electronic-circuit ??
--
-- ----------------------------------------------------------------------------

local mod_name = 'apm_power'

---@param technology string
---@param t_prerequisites data.TechnologyID[]
---@param t_recipes string[]
---@param t_trigger? data.TechnologyTrigger
---@param t_unit?  data.TechnologyUnit
---@paran t_icon? string
---@param t_icon_size? uint64
---@param t_is_essential? boolean
local new_tech = function(
	technology,
	t_prerequisites,
	t_recipes,
	t_trigger,
	t_unit,
	t_icon,
	t_icon_size,
	t_is_essential
)
	apm.lib.utils.technology.new(
		mod_name,
		technology,
		t_prerequisites,
		t_recipes,
		t_trigger,
		t_unit,
		t_icon,
		t_icon_size,
		t_is_essential
	)
end

local sp = {
	industrial = "apm_industrial_science_pack",
	automation = "automation-science-pack",
	logistic = "logistic-science-pack",
	chemical = "chemical-science-pack",
	steam = "apm_steam_science_pack",
	utility = "utility-science-pack",
}

-- Crusher
new_tech(
	'apm_crusher_machine_0',
	{},
	{ 'apm_crusher_machine_0', 'apm_coal_crushed_1', 'apm_stone_crushed_1', 'apm_wood_pellets_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 5,
		time = 10,
	}
)

-- Rubber I
new_tech(
	'apm_rubber-1',
	{ 'apm_crusher_machine_0' },
	{ 'apm_resin_1', 'apm_rubber_1', 'apm_coking_plant_0' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 15,
		time = 10,
	}
)

-- Rubber II
new_tech(
	'apm_rubber-2',
	{ 'apm_rubber-1', 'apm_coking_plant_0' },
	{ 'apm_rubber_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 25,
	}
)

-- Press
new_tech(
	'apm_press_machine_0',
	{ 'apm_crusher_machine_0', 'apm_water_supply-1' },
	{
		'apm_press_machine_0', 'apm_coal_briquette_pressed_1', 'apm_wood_briquette_1', 'apm_wood_board_2',
		'apm_lubricant_1', 'apm_iron_bearing_ball', 'apm_iron_bearing',
	},
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 5,
		time = 10,
	}
)

-- Stone bricks
new_tech(
	'apm_stone_bricks',
	{ 'apm_press_machine_0', 'apm_water_supply-1' },
	{ 'apm_crushed_stone', 'apm_stone_brick_raw_with_crushed', 'apm_stone_brick_raw_with_wed_mud',
		'apm_stone_brick_raw_with_ash' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 15,
		time = 10,
	}
)

-- Coking plant
new_tech(
	'apm_coking_plant_0',
	{ 'apm_press_machine_0', 'apm_stone_bricks' },
	{ 'apm_pyrolysis_charcoal_1', 'apm_pyrolysis_coke_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 20,
	}
)

-- puddling furnace (aka early steel)
new_tech(
	'apm_puddling_furnace_0',
	{ 'apm_fuel-1', 'apm_water_supply-1', 'apm_stone_bricks' },
	{ 'apm_puddling_furnace_0', 'apm_raw_crucible_0', 'apm_raw_crucible_1', 'apm_stone_crucible', 'apm_steel_0',
		'apm_burner_miner_drill_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 20,
	}
)

-- burner long insterter
new_tech(
	'apm_burner_long_inserter',
	{ 'apm_puddling_furnace_0' },
	{ 'apm_burner_long_inserter' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 25,
	}
)

-- Tools / Press
new_tech(
	'apm_tools_0',
	{ 'advanced-material-processing' },
	{ 'apm_press_plates', 'apm_press_plates_used_grind', 'apm_wood_briquette_3', 'apm_coal_briquette_pressed_3' },
	nil,
	{
		ingredients = { { sp.logistic, 1 }, { sp.automation, 1 } },
		count = 75,
		time = 30,
	}
)

-- Tools / Crusher
new_tech(
	'apm_tools_1',
	{ 'advanced-material-processing' },
	{ 'apm_crusher_drums', 'apm_crusher_drums_used_repair', 'apm_wood_pellets_3', 'apm_coal_crushed_3', 'apm_resin_2' },
	nil,
	{
		ingredients = { { sp.logistic, 1 }, { sp.automation, 1 } },
		count = 75,
		time = 30,
	}
)

-- Tools / Steel Saw
new_tech(
	'apm_tools_2',
	{ 'advanced-material-processing' },
	{ 'apm_saw_blade_steel', 'apm_saw_blade_steel_maintenance', 'apm_treated_wood_planks_2' },
	nil,
	{
		ingredients = { { sp.logistic, 1 }, { sp.automation, 1 } },
		count = 75,
		time = 30,
	}
)

-- Better Steel
new_tech(
	'apm_steelworks-1',
	{ 'apm_puddling_furnace_0', 'advanced-material-processing' },
	{ 'apm_steelworks_0', 'apm_steel_1' },
	nil,
	{
		ingredients = { { sp.logistic, 1 }, { sp.automation, 1 } },
		count = 75,
		time = 30,
	}
)

-- Better Steel
new_tech(
	'apm_steelworks-2',
	{ 'apm_steelworks-1', 'processing-unit', 'low-density-structure' },
	{ 'apm_steelworks_1' },
	nil,
	{
		ingredients = { { sp.logistic, 1 }, { sp.automation, 1 }, { sp.chemical, 1 } },
		count = 75,
		time = 30,
	}
)

-- Fuel I
new_tech(
	'apm_fuel-1',
	{ 'apm_coking_plant_0' },
	{ 'apm_coke_crushed', 'apm_charcoal_brick', 'apm_coke_brick' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 30,
		time = 15,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_fuel.png'
)

-- Fuel II
new_tech(
	'apm_fuel-2',
	{ 'apm_fuel-1', 'apm_coking_plant_0', "steam-power" },
	{ 'apm_pyrolysis_charcoal_2', 'apm_pyrolysis_coke_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 75,
		time = 20,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_fuel.png'
)

-- Fuel III
new_tech(
	'apm_fuel-3',
	{ 'apm_fuel-2', 'apm_coking_plant_1' },
	{ 'apm_pyrolysis_charcoal_3', 'apm_pyrolysis_coke_3' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 75,
		time = 20,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_fuel.png'
)

-- Fuel IV
new_tech(
	'apm_fuel-4',
	{ 'apm_fuel-3', 'apm_coking_plant_2' },
	{ 'apm_pyrolysis_charcoal_4', 'apm_pyrolysis_coke_4' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 75,
		time = 30,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_fuel.png'
)

-- Asphalt
new_tech(
	'apm_asphalt-1',
	{ 'apm_fuel-3' },
	{ 'apm_asphalt_1', 'apm_asphalt_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 20,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_asphalt.png'
)

-- Asphalt
new_tech(
	'apm_asphalt-2',
	{ 'apm_asphalt-1', 'advanced-oil-processing' },
	{ 'apm_asphalt_3', 'apm_asphalt_4' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 50,
		time = 30,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_asphalt.png'
)

-- Treated wood planks I
new_tech(
	'apm_treated_wood_planks-1',
	{ 'apm_fuel-3' },
	{ 'apm_treated_wood_planks_1', 'apm_saw_blade_iron', 'apm_saw_blade_iron_maintenance' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 75,
		time = 15,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_treated_wood_planks.png'
)

-- Treated wood planks II
new_tech(
	'apm_treated_wood_planks-2',
	{ 'apm_treated_wood_planks-1', 'oil-processing' },
	{ 'apm_treated_wood_planks_1b' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 75,
		time = 15,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_treated_wood_planks.png'
)

-- Treated wood planks III
new_tech(
	'apm_treated_wood_planks-3',
	{ 'apm_treated_wood_planks-2', 'oil-processing', 'apm_tools_2' },
	{ 'apm_treated_wood_planks_2b' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 100,
		time = 30,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_treated_wood_planks.png'
)

-- Water supply I
new_tech(
	'apm_water_supply-1',
	{ 'apm_rubber-1' },
	{ 'apm_offshore_pump_0', 'apm_centrifuge_0', 'apm_sealing_rings', 'apm_seawater_centrifuging',
		'apm_dirty_water_purification', 'apm_coal_saturated_wastewater' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 10,
		time = 10,
	}
)

-- Fluid control (pumps)
new_tech(
	'apm_fluid_control-1',
	{ 'apm_water_supply-1' },
	{ 'apm_pump_0', 'apm_inline_storage_tank', 'apm_sinkhole_small' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 15,
	}
)

-- Water supply II
new_tech(
	'apm_water_supply-2',
	{ 'apm_power_electricity', 'apm_water_supply-1' },
	{ 'apm_offshore_pump_1' },
	nil,
	{
		ingredients = { { sp.automation, 1 } },
		count = 75,
		time = 30,
	}
)

-- Steam
-- new_tech(
-- 	'apm_power_steam',
-- 	{ 'apm_fuel-1', 'apm_puddling_furnace_0', 'apm_water_supply-1', 'apm_stone_bricks' },
-- 	{ 'boiler' },
-- 	nil,
-- 	{
-- 		ingredients = { { sp.industrial, 1 } },
-- 		count = 75,
-- 		time = 25,
-- 	}
-- )

--TODO: append long inserter?
-- Steam Science 
new_tech(
	'apm_steam_science_pack',
	-- { 'apm_power_steam' },
	{"steam-power"},
	{ 'apm_steam_science_pack', 'apm_steam_relay', 'apm_machine_frame_steam', 'apm_machine_frame_basic_maintenance',
		'apm_steam_engine',
		"apm_steam_inserter", "apm_steam_inserter_long" },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 75,
		time = 25,
	}
)

-- steam sieve
new_tech(
	'apm_sieve_0',
	{ 'apm_coking_plant_1' },
	{ 'apm_sieve_0', 'apm_dry_mud', 'apm_sieve_iron', 'apm_dry_mud_sifting_iron', 'apm_sieve_copper',
		'apm_dry_mud_sifting_copper' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 75,
		time = 30,
	}
)

-- Greenhouse I
new_tech(
	'apm_greenhouse',
	{ 'apm_water_supply-1', 'apm_stone_bricks' },
	{ 'apm_greenhouse_0', 'apm_tree_seeds', 'apm_wood_0' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 20,
		time = 10,
	}
)

-- Greenhouse II
new_tech(
	'apm_greenhouse-2',
	{ 'apm_greenhouse', 'apm_fuel-2', 'apm_steam_science_pack' },
	{ 'apm_greenhouse_1', 'apm_wood_1', 'apm_fertiliser_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 25,
	}
)

-- Fertiliser 2
new_tech(
	'apm_fertiliser_2',
	{ 'apm_greenhouse-2', 'sulfur-processing' },
	{ 'apm_air_cleaning_2', 'apm_fertiliser_2', 'apm_wood_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 30,
		time = 100,
	}
)

-- Steam assembler
new_tech(
	'apm_assembler_machine_1',
	{ 'apm_puddling_furnace_0', 'apm_steam_science_pack' },
	{ 'apm_assembling_machine_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 40,
		time = 25,
	}
)

-- Steam centrifuge
new_tech(
	'apm_centrifuge_0',
	{ 'apm_puddling_furnace_0', 'apm_steam_science_pack' },
	{ 'apm_centrifuge_1', 'apm_coal_saturated_wastewater_seperation' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 25,
	}
)

-- Steam air cleaner
new_tech(
	'apm_air_cleaner_machine',
	{ 'apm_centrifuge_0', 'apm_assembler_machine_1' },
	{ 'apm_air_cleaner_machine_0', 'apm_filter_charcoal', 'apm_filter_charcoal_used_recycling', 'apm_air_cleaning_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 75,
		time = 30,
	}
)

-- Electric air cleaner
new_tech(
	'apm_air_cleaner_machine_1',
	{ 'apm_centrifuge_2', 'apm_air_cleaner_machine' },
	{ 'apm_air_cleaner_machine_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 }, { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 75,
		time = 30,
	}
)

-- Particle Filter 1
new_tech(
	'apm_particle_filter',
	{ 'apm_coking_plant_0' },
	{ 'apm_particle_filter_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 50,
		time = 15,
	}
)

-- Particle Filter 2
new_tech(
	'apm_particle_filter-2',
	{ 'apm_particle_filter', 'apm_air_cleaner_machine' },
	{ 'apm_particle_filter_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 100,
		time = 30,
	}
)

-- Particle Filter 3
new_tech(
	'apm_particle_filter-3',
	{ 'apm_particle_filter-2', 'sulfur-processing' },
	{ 'apm_particle_filter_3' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 200,
		time = 30,
	}
)

-- Steam crusher
new_tech(
	'apm_crusher_machine_1',
	{ 'apm_centrifuge_0', 'apm_crusher_machine_0', 'apm_puddling_furnace_0', 'apm_steam_science_pack' },
	{ 'apm_crusher_machine_1', 'apm_wood_pellets_2', 'apm_coal_crushed_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 20,
	}
)

-- Steam press
new_tech(
	'apm_press_machine_1',
	{ 'apm_centrifuge_0', 'apm_press_machine_0', 'apm_puddling_furnace_0', 'apm_steam_science_pack' },
	{ 'apm_press_machine_1', 'apm_wood_briquette_2', 'apm_coal_briquette_pressed_2' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 20,
	}
)

-- Steam lab
new_tech(
	'apm_lab_1',
	{ 'apm_centrifuge_0' },
	{ 'apm_lab_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 100,
		time = 30,
	}
)

-- Coking plant II
new_tech(
	'apm_coking_plant_1',
	{ 'apm_coking_plant_0', 'apm_fuel-2', 'apm_assembler_machine_1' },
	{ 'apm_coking_plant_1' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.steam, 1 } },
		count = 50,
		time = 30,
	}
)

-- Coking plant III
new_tech(
	'apm_coking_plant_2',
	{ 'apm_coking_plant_1', 'oil-processing' },
	{ 'apm_coking_plant_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 120,
		time = 30,
	}
)

-- Ash...
new_tech(
	'apm_ash_production',
	{ 'apm_coking_plant_0' },
	{ 'apm_coal_ash_production', 'apm_wood_ash_production' },
	nil,
	{
		ingredients = { { sp.industrial, 1 } },
		count = 30,
		time = 15,
	}
)

-- Electricity
new_tech(
	'apm_power_electricity',
	{ "automation-science-pack", 'apm_fuel-3' },
	{ 'steam-engine', 'small-electric-pole', 'apm_machine_frame_advanced',
		'apm_machine_frame_steam_maintenance', 'apm_machine_frame_advanced_maintenance' },
	nil,
	{
		ingredients = { { sp.industrial, 1 }, { sp.automation, 1 }, { sp.steam, 1 } },
		count = 100,
		time = 30,
	}
)

-- Electric crusher
new_tech(
	'apm_crusher_machine_2',
	{ 'apm_crusher_machine_1', 'electric-engine' },
	{ 'apm_crusher_machine_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 75,
		time = 30,
	}
)

-- Electric press
new_tech(
	'apm_press_machine_2',
	{ 'apm_press_machine_1', 'electric-engine' },
	{ 'apm_press_machine_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 75,
		time = 30,
	}
)

-- Electric centrifuge
new_tech(
	'apm_centrifuge_2',
	{ 'apm_centrifuge_0', 'electric-engine' },
	{ 'apm_centrifuge_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 75,
		time = 30,
	}
)

-- Greenhouse III
new_tech(
	'apm_greenhouse-3',
	{ 'apm_greenhouse-2', 'electric-engine' },
	{ 'apm_greenhouse_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 75,
		time = 30,
	}
)

-- Equipment Burner Generator I
new_tech(
	'apm_equipment_burner_generator-1',
	{ 'modular-armor', 'electric-engine' },
	{ 'apm_equipment_burner_generator_basic' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 150,
		time = 30,
	}
)

-- Equipment Burner Generator II
new_tech(
	'apm_equipment_burner_generator-2',
	{ 'apm_equipment_burner_generator-1', 'utility-science-pack' },
	{ 'apm_equipment_burner_generator_advanced' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 }, { sp.utility, 1 } },
		count = 250,
		time = 30,
	}
)

-- Wood liquefaction
-- TODO: create own icon for this technology
new_tech(
	'apm_wood_liquefaction',
	{ 'advanced-oil-processing' },
	{ 'apm_refining_wood_1', 'apm_refining_creosote_1', 'apm_refining_coke_oven_gas_1' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 }, { sp.chemical, 1 } },
		count = 125,
		time = 30,
	},
	'__base__/graphics/technology/oil-processing.png',
	256
)

-- Boiler
new_tech(
	'apm_power_boiler',
	{ 	"steam-power"	, 'advanced-material-processing' },
	{ 'apm_boiler_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 125,
		time = 30,
	},
	'__apm_resource_pack_ldinc__/graphics/technologies/apm_power_steam.png'
)

-- Steam Engine
new_tech(
	'apm_steam_engine',
	{ 'apm_power_electricity', 'apm_power_boiler' },
	{ 'apm_steam_engine_2' },
	nil,
	{
		ingredients = { { sp.automation, 1 }, { sp.logistic, 1 } },
		count = 250,
		time = 30,
	}
)
