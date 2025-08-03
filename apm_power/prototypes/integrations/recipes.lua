require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/integrations/recipes.lua'

APM_LOG_HEADER(self)

require("prototypes.integrations.recipes.base")


local apm_power_overhaul_machine_frames = settings.startup["apm_power_overhaul_machine_frames"].value
local apm_power_steam_assembler_craftin_with_fluids = settings.startup["apm_power_steam_assembler_craftin_with_fluids"]
		.value
local apm_power_compat_bob = settings.startup["apm_power_compat_bob"].value
local apm_power_compat_bob_overhaul_machine_frames = settings.startup["apm_power_compat_bob_overhaul_machine_frames"]
		.value
local apm_power_compat_angel = settings.startup["apm_power_compat_angel"].value
local apm_power_compat_angel_overhaul_machine_frames = settings.startup
		["apm_power_compat_angel_overhaul_machine_frames"].value
local apm_power_compat_angel_overwrite_crystal_saw_blades = settings.startup
		["apm_power_compat_angel_overwrite_crystal_saw_blades"].value
local apm_power_compat_sctm = settings.startup["apm_power_compat_sctm"].value
local apm_power_compat_sct_overhaul_machine_frames = settings.startup["apm_power_compat_sct_overhaul_machine_frames"]
		.value
local apm_power_compat_earendel = settings.startup["apm_power_compat_earendel"].value
local apm_power_compat_bio_industries = settings.startup["apm_power_compat_bio_industries"].value
local apm_power_compat_expensivelandfillrecipe = settings.startup["apm_power_compat_expensivelandfillrecipe"].value
local apm_power_compat_kingarthur = settings.startup["apm_power_compat_kingarthur"].value
local apm_power_compat_mferrari = settings.startup["apm_power_compat_mferrari"].value
local apm_power_compat_linver = settings.startup["apm_power_compat_linver"].value
local apm_power_compat_realistic_reactors = settings.startup["apm_power_compat_realistic_reactors"].value
local apm_power_compat_reverse_factory = settings.startup["apm_power_compat_reverse_factory"].value
local apm_power_compat_arcitos = settings.startup["apm_power_compat_arcitos"].value
local apm_power_always_show_made_in = settings.startup["apm_power_always_show_made_in"].value

APM_LOG_SETTINGS(self, 'apm_power_overhaul_machine_frames', apm_power_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_steam_assembler_craftin_with_fluids', apm_power_steam_assembler_craftin_with_fluids)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob', apm_power_compat_bob)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob_overhaul_machine_frames', apm_power_compat_bob_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel', apm_power_compat_angel)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overhaul_machine_frames', apm_power_compat_angel_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overwrite_crystal_saw_blades',
	apm_power_compat_angel_overwrite_crystal_saw_blades)
APM_LOG_SETTINGS(self, 'apm_power_compat_sctm', apm_power_compat_sctm)
APM_LOG_SETTINGS(self, 'apm_power_compat_sct_overhaul_machine_frames', apm_power_compat_sct_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_earendel', apm_power_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_power_compat_bio_industries', apm_power_compat_bio_industries)
APM_LOG_SETTINGS(self, 'apm_power_compat_expensivelandfillrecipe', apm_power_compat_expensivelandfillrecipe)
APM_LOG_SETTINGS(self, 'apm_power_compat_kingarthur', apm_power_compat_kingarthur)
APM_LOG_SETTINGS(self, 'apm_power_compat_mferrari', apm_power_compat_mferrari)
APM_LOG_SETTINGS(self, 'apm_power_compat_linver', apm_power_compat_linver)
APM_LOG_SETTINGS(self, 'apm_power_compat_realistic_reactors', apm_power_compat_realistic_reactors)
APM_LOG_SETTINGS(self, 'apm_power_compat_reverse_factory', apm_power_compat_reverse_factory)
APM_LOG_SETTINGS(self, 'apm_power_compat_arcitos', apm_power_compat_arcitos)
APM_LOG_SETTINGS(self, 'apm_power_always_show_made_in', apm_power_always_show_made_in)

if mods.apm_energy_addon then
	apm.lib.utils.recipe.ingredient.mod('apm_battery_charging_station', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_battery_charging_station', 3, 3, 6, 3, true)
end

if mods.apm_nuclear then
	apm.lib.utils.recipe.ingredient.mod('apm_cooling_pond_0', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_cooling_pond_0', 3, nil, 6, nil, true)
	apm.lib.utils.recipe.ingredient.mod('apm_hybrid_cooling_tower_0', 'steel-plate', 0)
	apm.power.machine_frame_addition('apm_hybrid_cooling_tower_0', 3, nil, 6, nil, true)
end

-- AsphaltRoads ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['AsphaltRoads'] and apm_power_compat_arcitos then
	apm.lib.utils.recipe.ingredient.remove_all('Arci-asphalt')
	apm.lib.utils.recipe.ingredient.mod('Arci-asphalt', 'apm_asphalt', 5)
	apm.lib.utils.recipe.ingredient.mod('Arci-asphalt', 'steam', 50)
	apm.lib.utils.recipe.category.change('Arci-asphalt', 'chemistry')
end

-- ExpensiveLandFillRecipe ----------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.ExpensiveLandfillRecipe and apm_power_compat_expensivelandfillrecipe then
	apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'stone', 0)
	apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'gravel-pile', 150)
	apm.lib.utils.recipe.energy_required.mod('apm_landfill', 10)
	apm.lib.utils.recipe.result.mod('apm_landfill', 'landfill', 1)
	if settings.startup['apm_power_generic_ash'].value == true then
		apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'apm_generic_ash', 1500)
	else
		apm.lib.utils.recipe.ingredient.mod('apm_landfill', 'apm_generic_ash', 1500)
	end
end

-- linver ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.FluidMustFlow and apm_power_compat_linver then
	apm.lib.utils.recipe.ingredient.mod('duct-small', 'apm_sealing_rings', 2)
	apm.lib.utils.recipe.ingredient.mod('duct-t-junction', 'apm_sealing_rings', 3)
	apm.lib.utils.recipe.ingredient.mod('duct-curve', 'apm_sealing_rings', 2)
	apm.lib.utils.recipe.ingredient.mod('duct-cross', 'apm_sealing_rings', 4)
	apm.lib.utils.recipe.ingredient.mod('duct-underground', 'apm_sealing_rings', 2)
end

-- bio_industries -------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.Bio_Industries and apm_power_compat_bio_industries then
	apm.lib.utils.recipe.remove('bi_recipe_stone_crusher')
	apm.lib.utils.recipe.remove('bi_recipe_charcoal')
	apm.lib.utils.recipe.remove('bi_recipe_charcoal_2')
	apm.lib.utils.recipe.remove('bi_recipe_ash_1')
	apm.lib.utils.recipe.remove('bi_recipe_ash_2')
	apm.lib.utils.recipe.remove('bi_recipe_stone_brick')
	apm.lib.utils.recipe.remove('bi_recipe_cokery')
	apm.lib.utils.recipe.remove('bi_recipe_coal')
	apm.lib.utils.recipe.remove('bi_recipe_coke_coal')
	apm.lib.utils.recipe.remove('bi_recipe_coal_2')
	apm.lib.utils.recipe.remove('bi_recipe_resin_wood')
	apm.lib.utils.recipe.remove('bi_recipe_crushed_stone')
	apm.lib.utils.recipe.remove('bi_recipe_soild_fuel')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_rail_wood', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_rail_wood_bridge', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_wood_pipe', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_wood_pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_big_wooden_pole', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_huge_wooden_pole', 'wood', 'apm_treated_wood_planks')
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_1', 'bi-seed', 40 / 5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_2', 'bi-seed', 50 / 5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_3', 'bi-seed', 60 / 5)
	apm.lib.utils.recipe.result.mod('bi_recipe_seed_4', 'bi-seed', 80 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk1', 'bi-seed', 20 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk2', 'bi-seed', 20 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk3', 'bi-seed', 20 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seedling_mk4', 'bi-seed', 20 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_basic', 'bi-seed', 400 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_standard', 'bi-seed', 400 / 5)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_seed_bomb_advanced', 'bi-seed', 400 / 5)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_plastic_1', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_wood_fuel_brick', 'bi-woodpulp', 7)
	apm.lib.utils.recipe.result.mod('bi_recipe_wood_fuel_brick', 'apm_wood_briquette', 1)
	apm.lib.utils.recipe.result.mod('bi_recipe_wood_fuel_brick', 'wood-bricks', 0)
	apm.lib.utils.recipe.category.change('bi_recipe_wood_fuel_brick', 'apm_press')
	apm.lib.utils.recipe.ingredient.mod('bi_recipe_rail_wood', 'apm_crushed_stone', 0)
	apm.lib.utils.recipe.ingredient.mod('rail', 'apm_crushed_stone', 0)
	apm.lib.utils.recipe.ingredient.replace('bi_recipe_mineralized_sulfuric_waste', 'wood-charcoal', 'apm_charcoal')
end

-- Earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['aai-industry'] and apm_power_compat_earendel then
	-- revert some changes from aai-industry
	apm.lib.utils.recipe.ingredient.replace('medium-electric-pole', 'small-iron-electric-pole', 'small-electric-pole')
	apm.lib.utils.recipe.remove('small-iron-electric-pole')
	apm.lib.utils.recipe.ingredient.replace('assembling-machine-1', 'burner-assembling-machine',
		'apm_assembling_machine_1')
	apm.lib.utils.recipe.remove('burner-assembling-machine')
	apm.lib.utils.recipe.ingredient.replace('lab', 'burner-lab', 'apm_lab_1')
	apm.lib.utils.recipe.remove('burner-lab')
	apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'burner-mining-drill', 0)
	apm.lib.utils.recipe.ingredient.mod('inserter', 'iron-plate', 1)
	apm.lib.utils.recipe.ingredient.mod('inserter', 'apm_gearing', 1)
	apm.lib.utils.recipe.remove('electronic-circuit-stone')

	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'stone-brick', 0)
	apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'stone-furnace', 1)

	apm.lib.utils.recipe.ingredient.replace("glass", "sand", "apm_crushed_stone")

	apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', "electric-motor", 1)
	apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', "apm_gearing", 1)

	apm.lib.utils.recipe.ingredient.replace_all("motor", "apm_simple_engine")

	if not mods.bobelectronics then
		apm.lib.utils.recipe.ingredient.mod('inserter', 'electronic-circuit', 1)
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'electronic-circuit', 5)
	else
		apm.lib.utils.recipe.ingredient.mod('inserter', 'bob-basic-circuit-board', 1)
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'bob-basic-circuit-board', 5)
	end

	-- integrate motors
	apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'motor', 0)
	apm.lib.utils.recipe.ingredient.replace('steam-engine', 'electric-motor', 'iron-gear-wheel')
	apm.lib.utils.recipe.ingredient.replace('steam-turbine', 'electric-motor', 'iron-gear-wheel')

	if mods.boblogistics and apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
		apm.lib.utils.recipe.ingredient.replace('basic-transport-belt', 'motor', 'iron-gear-wheel', 2)
	else
		apm.lib.utils.recipe.ingredient.replace('transport-belt', 'motor', 'iron-gear-wheel', 2)
		apm.lib.utils.recipe.ingredient.replace('underground-belt', 'motor', 'iron-gear-wheel')
		apm.lib.utils.recipe.ingredient.replace('splitter', 'motor', 'iron-gear-wheel')
	end
	apm.lib.utils.recipe.ingredient.mod('engine-unit', 'motor', 0)

	if not mods.bobelectronics then
		--apm.lib.utils.recipe.ingredient.replace('electronic-circuit', 'wood', 'apm_wood_board')
		apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'electronic-circuit', 3)
		apm.lib.utils.recipe.ingredient.mod('electronic-circuit', 'stone-tablet', 1)
	else
		apm.lib.utils.recipe.ingredient.mod('apm_offshore_pump_1', 'bob-basic-circuit-board', 0)
		apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'bob-basic-circuit-board', 3)
		apm.lib.utils.recipe.ingredient.mod('bob-basic-circuit-board', 'stone-tablet', 1)
	end
end

if mods['aai-vehicles-hauler'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'iron-gear-wheel', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'iron-plate', 5)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'apm_simple_engine', 2)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'steel-plate', 3)
	apm.lib.utils.recipe.ingredient.mod('vehicle-hauler', 'apm_rubber', 4)
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-warden', 'apm_rubber', 6)
end

if mods['aai-vehicles-chaingunner'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'motor', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'iron-gear-wheel', 0)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'apm_simple_engine', 3)
	apm.lib.utils.recipe.ingredient.mod('vehicle-chaingunner', 'steel-plate', 5)
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
end

if mods['aai-vehicles-warden'] and apm_power_compat_earendel then
end

if (mods['space-exploration'] or mods['aai-industry']) and apm_power_compat_earendel then
	-- integrate stone from sand
	apm.lib.utils.recipe.ingredient.mod('sand-from-stone', 'apm_crushed_stone', 4)
	apm.lib.utils.recipe.ingredient.mod('sand-from-stone', 'stone', 0)
	apm.lib.utils.recipe.category.change('sand-from-stone', 'apm_crusher')
	-- integrate glass
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_0', 'bob-glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_1', 'bob-glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_2', 'bob-glass', 25)
	apm.lib.utils.recipe.ingredient.mod('apm_lab_1', 'bob-glass', 10)
end

if mods['space-exploration'] and apm_power_compat_earendel then
	apm.lib.utils.recipe.ingredient.mod('se-space-pipe', 'apm_sealing_rings', 1)
	apm.lib.utils.recipe.ingredient.replace('se-lifesupport-canister-coal', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-meteor-point-defence-ammo', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-nutrient-gel', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('se-observation-frame-blank', 'coal', 'apm_coal_briquette', 1)
	apm.lib.utils.recipe.ingredient.replace('se-bio-sludge-from-wood', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('se-lifesupport-canister-fish', 'wood', 'apm_wood_pellets', 1)
end

-- bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

if apm_power_compat_bob then
	require("prototypes.integrations.recipes.bobs")
end

-- angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_power_compat_angel then
	apm.lib.utils.recipe.ingredient.replace('filter-coal', 'coal', 'apm_coal_briquette', 1)

	apm.lib.utils.recipe.result.replace('apm_dry_mud_sifting_iron', 'iron-ore', 'angels-ore1')
	apm.lib.utils.recipe.result.replace('apm_dry_mud_sifting_copper', 'copper-ore', 'angels-ore3')
	apm.lib.utils.recipe.ingredient.replace('apm_steel_0', 'iron-ore', 'angels-ore1-crushed')
	apm.lib.utils.recipe.ingredient.replace('apm_steel_1', 'iron-ore', 'angels-ore1-crushed')
	apm.lib.utils.recipe.remove('burner-ore-crusher')
	apm.lib.utils.recipe.ingredient.replace('ore-crusher', 'burner-ore-crusher', 'apm_crusher_machine_1')
	-- angelsmods.functions.make_void(fluid_name, void_category) --categories: chemical (flare-stack), water(clarifier)
	angelsmods.functions.make_void('apm_sea_water', 'water')
	angelsmods.functions.make_void('apm_dirt_water', 'water')
	angelsmods.functions.make_void('apm_coal_saturated_wastewater', 'water')
	angelsmods.functions.make_void('apm_creosote', 'water')

	apm.lib.utils.recipe.ingredient.replace('ore-crusher', 'iron-gear-wheel', 'apm_gearing')
	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('ore-crusher', 3, 2, 3, 3)
		apm.power.machine_frame_addition('ore-crusher-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('ore-crusher-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('ore-sorting-facility', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-sorting-facility-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-sorting-facility-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('ore-sorting-facility-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('ore-floatation-cell', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-floatation-cell-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-floatation-cell-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-leaching-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-leaching-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-leaching-plant-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-refinery', 3, nil, 7, nil)
		apm.power.machine_frame_addition('ore-refinery-2', 3, 3, 9, 5)

		apm.power.machine_frame_addition('ore-powderizer', 3, nil, 3, nil)
		apm.power.machine_frame_addition('ore-powderizer-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('ore-powderizer-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('electro-whinning-cell', 3, nil, 5, nil)
		apm.power.machine_frame_addition('electro-whinning-cell-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('electro-whinning-cell-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('filtration-unit', 3, nil, 5, nil)
		apm.power.machine_frame_addition('filtration-unit-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('crystallizer', 3, nil, 5, nil)
		apm.power.machine_frame_addition('crystallizer-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('hydro-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('hydro-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('hydro-plant-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('salination-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('salination-plant-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('washing-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('washing-plant-2', 3, 3, 7, 4)
	end
end

if mods.angelssmelting and apm_power_compat_angel then
	apm.lib.utils.recipe.result.mod('coolant-cool-steam', 'water-purified', 45)
	apm.lib.utils.recipe.result.mod('coolant-cool-100', 'steam', 100)
	apm.lib.utils.recipe.result.mod('coolant-cool-200', 'steam', 100)
	apm.lib.utils.recipe.result.mod('coolant-cool-300', 'steam', 100)

	apm.lib.utils.recipe.remove('apm_steelworks_0')
	apm.lib.utils.recipe.remove('apm_steelworks_1')
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'angels-ore1-crushed', 20)
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'apm_stone_crucible', 2)
	apm.lib.utils.recipe.ingredient.mod('apm_steel_0', 'apm_coke_crushed', 5)
	apm.lib.utils.recipe.result.mod('apm_steel_0', 'steel-plate', 2)
	apm.lib.utils.recipe.energy_required.mod('apm_steel_0', 24)

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('ore-processing-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('ore-processing-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('ore-processing-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('ore-processing-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('pellet-press', 3, nil, 5, nil)
		apm.power.machine_frame_addition('pellet-press-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('pellet-press-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('pellet-press-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('powder-mixer', 3, nil, 5, nil)
		apm.power.machine_frame_addition('powder-mixer-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('powder-mixer-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('powder-mixer-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('blast-furnace', 1, nil, 5, nil)
		apm.power.machine_frame_addition('blast-furnace-2', 1, 1, 7, 4)
		apm.power.machine_frame_addition('blast-furnace-3', 1, 1, 9, 5)
		apm.power.machine_frame_addition('blast-furnace-4', 1, 1, 11, 6)

		apm.power.machine_frame_addition('angels-chemical-furnace', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-chemical-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-chemical-furnace-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-chemical-furnace-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('induction-furnace', 3, nil, 5, nil)
		apm.power.machine_frame_addition('induction-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('induction-furnace-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('induction-furnace-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('casting-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('casting-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('casting-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('casting-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('strand-casting-machine', 3, nil, 5, nil)
		apm.power.machine_frame_addition('strand-casting-machine-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('strand-casting-machine-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('strand-casting-machine-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('sintering-oven', 3, nil, 5, nil)
		apm.power.machine_frame_addition('sintering-oven-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('sintering-oven-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('sintering-oven-4', 3, 3, 11, 6)
	end
end

if mods.angelspetrochem and apm_power_compat_angel then
	-- angelsmods.functions.make_void(fluid_name, void_category) --categories: chemical (flare-stack), water(clarifier)
	angelsmods.functions.make_void('apm_coke_oven_gas', 'chemical')

	apm.lib.utils.recipe.ingredient.replace('carbon-separation-2', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('solid-nitroglycerin', 'coal', 'apm_coal_crushed', 2)

	apm.lib.utils.recipe.result.mod('apm_refining_coke_oven_gas_1', 'gas-hydrogen', 20)
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_1', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_2', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_3', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_4', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_5', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.ingredient.replace('apm_coke_crushed', 'apm_coke', 'solid-coke')
	apm.lib.utils.recipe.ingredient.replace('apm_coke_brick', 'apm_coke', 'solid-coke')

	apm.lib.utils.recipe.remove('solid-coke')
	apm.lib.utils.recipe.remove('solid-coke-sulfur')

	apm.lib.utils.recipe.ingredient.replace('apm_pyrolysis_coke_5', 'steam', 'water-purified')
	apm.lib.utils.recipe.result.replace('apm_pyrolysis_coke_5', 'sulfur', 'water-yellow-waste')
	apm.lib.utils.recipe.result.mod('apm_pyrolysis_coke_5', 'water-yellow-waste', 100)
	--apm.lib.utils.technology.add.recipe_for_unlock('angels-coal-processing-2', 'apm_pyrolysis_coke_5')
	apm.lib.utils.technology.add.recipe_for_unlock('angels-coal-cracking', 'apm_pyrolysis_coke_5')
	--apm.lib.utils.technology.add.prerequisites('angels-coal-processing-2', 'apm_coking_plant_2')
	--apm.lib.utils.technology.add.prerequisites('angels-coal-processing-2', 'apm_fuel-4')

	apm.lib.utils.recipe.remove('pellet-coke')
	apm.lib.utils.recipe.remove('coal-crushed')

	apm.lib.utils.recipe.result.mod('coal-cracking-1', 'solid-coke', 2)
	apm.lib.utils.recipe.result.mod('coal-cracking-2', 'solid-coke', 2)
	apm.lib.utils.recipe.result.mod('condensates-refining', 'solid-coke', 1)

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('angels-electrolyser', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-electrolyser-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-electrolyser-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-electrolyser-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('liquifier', 3, nil, 5, nil)
		apm.power.machine_frame_addition('liquifier-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('liquifier-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('liquifier-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('angels-air-filter', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-air-filter-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('separator', 3, nil, 5, nil)
		apm.power.machine_frame_addition('separator-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('separator-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('separator-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('gas-refinery-small', 3, nil, 5, nil)
		apm.power.machine_frame_addition('gas-refinery-small-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('gas-refinery-small-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('gas-refinery-small-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('angels-electric-boiler', 3, nil, 5, nil)

		apm.power.machine_frame_addition('steam-cracker', 3, nil, 5, nil)
		apm.power.machine_frame_addition('steam-cracker-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('steam-cracker-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('steam-cracker-4', 3, 3, 11, 6)

		apm.power.machine_frame_addition('gas-refinery', 3, nil, 5, nil)
		apm.power.machine_frame_addition('gas-refinery-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('gas-refinery-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('advanced-chemical-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('advanced-chemical-plant-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('angels-chemical-plant', 3, nil, 5, nil)
		apm.power.machine_frame_addition('angels-chemical-plant-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('angels-chemical-plant-3', 3, 3, 9, 5)
		apm.power.machine_frame_addition('angels-chemical-plant-4', 3, 3, 11, 6)
	end
end

if mods.angelsbioprocessing and apm_power_compat_angel then
	-- wooden board from solid-paper
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_board')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-paper')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -6, 0 })
	local item_icon_c = { apm.lib.icons.dynamics.t3 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	if mods.bobelectronics then
		apm.lib.utils.recipe.set.icons('wooden-board-paper', icons)
		apm.lib.utils.recipe.set.always_show_products('wooden-board-paper', true)
		if apm_power_always_show_made_in then
			apm.lib.utils.recipe.set.always_show_made_in('wooden-board-paper', true)
		end
		apm.lib.utils.recipe.energy_required.mod('wooden-board-paper', 1)
		apm.lib.utils.recipe.ingredient.mod('wooden-board-paper', 'solid-paper', 6)
		apm.lib.utils.recipe.result.mod('wooden-board-paper', 'apm_wood_board', 3)
		apm.lib.utils.recipe.result.mod('wooden-board-paper', 'wooden-board', 0)
		apm.lib.utils.recipe.category.change('wooden-board-paper', 'apm_press')
		apm.lib.utils.recipe.overwrite.group('wooden-board-paper', 'apm_power_intermediates', 'ac_b')
	else
		local recipe = {}
		recipe.type = "recipe"
		recipe.name = "apm_wooden_board_from_paper"
		recipe.category = 'apm_press'
		recipe.group = "apm_power"
		recipe.subgroup = "apm_power_intermediates"
		recipe.order = 'ac_b'
		recipe.icons = icons

		recipe.enabled = false
		recipe.energy_required = 1
		recipe.ingredients = {
			{ type = "item", name = "solid-paper", amount = 6 }
		}
		recipe.results = {
			{ type = 'item', name = 'apm_wood_board', amount = 3 }
		}
		recipe.main_product = ''
		recipe.requester_paste_multiplier = 4
		recipe.always_show_products = true
		recipe.always_show_made_in = apm_power_always_show_made_in

		data:extend({ recipe })
		apm.lib.utils.technology.add.recipe_for_unlock('bio-paper-1', 'apm_wooden_board_from_paper')
	end

	-- wood pellets from wood
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
	local item_icon_b = apm.lib.utils.icon.get.from_item('wood')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, -8 })
	local item_icon_c = { apm.lib.icons.dynamics.t1 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	apm.lib.utils.recipe.set.icons('apm_wood_pellets_1', icons)

	-- wood pellets from cellulose
	local item_icon_a = apm.lib.utils.icon.get.from_item('apm_wood_pellets')
	local item_icon_b = apm.lib.utils.icon.get.from_item('cellulose-fiber')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, -8 })
	local item_icon_c = { apm.lib.icons.dynamics.t1 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	local recipe = table.deepcopy(data.raw.recipe['apm_wood_pellets_1'])
	recipe.name = 'apm_wood_pellets_cellulose'
	recipe.category = 'apm_press'
	recipe.icons = icons
	recipe.subgroup = "apm_power_wood"
	recipe.order = 'ac_b'
	recipe.ingredients = {
		{ type = "item", name = "cellulose-fiber", amount = 8 },
	}

	data:extend({ recipe })
	apm.lib.utils.technology.add.recipe_for_unlock('bio-processing-brown', 'apm_wood_pellets_cellulose')

	-- wood-sawing I
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_iron')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, -6 })
	local item_icon_c = { apm.lib.icons.dynamics.t1 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	apm.lib.utils.recipe.set.icons('wood-sawing-1', icons)
	apm.lib.utils.recipe.ingredient.mod('wood-sawing-1', 'solid-saw', 0)
	apm.lib.utils.recipe.ingredient.mod('wood-sawing-1', 'apm_saw_blade_iron', 1)
	apm.lib.utils.recipe.result.mod('wood-sawing-1', 'solid-saw', 0)
	apm.lib.utils.recipe.result.mod('wood-sawing-1', 'apm_saw_blade_iron_used', 1)

	-- removing iron saw blades
	apm.lib.utils.recipe.remove('solid-saw')

	-- wood-sawing II
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-crystal-tipped-saw')
	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		item_icon_b = apm.lib.utils.icon.get.from_item('apm_saw_blade_steel')
	end
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, -6 })
	local item_icon_c = { apm.lib.icons.dynamics.t2 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	apm.lib.utils.recipe.set.icons('wood-sawing-2', icons)
	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		apm.lib.utils.recipe.ingredient.mod('wood-sawing-2', 'solid-crystal-tipped-saw', 0)
		apm.lib.utils.recipe.ingredient.mod('wood-sawing-2', 'apm_saw_blade_steel', 1)
		apm.lib.utils.recipe.result.mod('wood-sawing-2', 'solid-crystal-tipped-saw', 0)
		apm.lib.utils.recipe.result.mod('wood-sawing-2', 'apm_saw_blade_steel_used', 1)
	end

	--
	apm.lib.utils.recipe.ingredient.mod('solid-crystal-tipped-saw', 'solid-saw', 0)
	apm.lib.utils.recipe.ingredient.mod('solid-crystal-tipped-saw', 'apm_saw_blade_steel', 1)

	-- wood-sawing III
	local item_icon_a = apm.lib.utils.icon.get.from_item('wood')
	local item_icon_b = apm.lib.utils.icon.get.from_item('solid-crystal-full-saw')
	item_icon_b = apm.lib.utils.icons.mod(item_icon_b, 0.5, { -8, -6 })
	local item_icon_c = { apm.lib.icons.dynamics.t3 }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })
	apm.lib.utils.recipe.set.icons('wood-sawing-3', icons)

	if apm_power_compat_angel_overwrite_crystal_saw_blades then
		-- wood-sawing III
		apm.lib.utils.recipe.remove('wood-sawing-3')

		-- removing crystal saw blades
		apm.lib.utils.recipe.remove('solid-crystal-tipped-saw')
		apm.lib.utils.recipe.remove('solid-crystal-full-saw')
	end

	if apm_power_compat_angel_overhaul_machine_frames then
		apm.power.machine_frame_addition('algae-farm', 3, nil, 5, nil)
		apm.power.machine_frame_addition('algae-farm-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('algae-farm-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('bio-arboretum-1', 3, nil, 5, nil)

		apm.power.machine_frame_addition('bio-generator-desert-1', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-generator-swamp-1', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-generator-temperate-1', 3, nil, 5, nil)

		apm.power.machine_frame_addition('crop-farm', 3, nil, 5, nil)
		apm.power.machine_frame_addition('temperate-farm', 3, 3, 7, 4)
		apm.power.machine_frame_addition('desert-farm', 3, 3, 7, 4)
		apm.power.machine_frame_addition('swamp-farm', 3, 3, 7, 4)

		apm.power.machine_frame_addition('bio-press', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-processor', 3, nil, 5, nil)
		apm.power.machine_frame_addition('composter', 3, nil, 3, nil)
		apm.power.machine_frame_addition('nutrient-extractor', 3, nil, 3, nil)
		apm.power.machine_frame_addition('seed-extractor', 3, nil, 3, nil)

		apm.power.machine_frame_addition('bio-butchery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-hatchery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bio-refugium-biter', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-refugium-fish', 3, nil, 5, nil)
		apm.power.machine_frame_addition('bio-refugium-puffer', 3, nil, 5, nil)
	end
end

if mods.angelsbioprocessing and mods.angelsrefining and apm_power_compat_angel then
end

local unlock_steel_with_oxy = function()
	if mods.bobelectronics then
		apm.lib.utils.recipe.ingredient.replace('apm_steelworks_0', 'electronic-circuit', 'bob-basic-circuit-board')
	end

	local item_icon_a = apm.lib.utils.icon.get.from_item('steel-plate')
	local item_icon_b = { apm.lib.icons.dynamics.t3 }
	local item_icon_c = { apm.lib.icons.dynamics.smelting }
	local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b, item_icon_c })

	local recipe = {}
	recipe.type = "recipe"
	recipe.name = "apm_steel_2"
	recipe.category = 'apm_steelworks'
	recipe.group = "apm_power"
	recipe.subgroup = "apm_power_smelting"
	recipe.order = 'ab_c'
	recipe.icons = icons
	recipe.crafting_machine_tint = {
		primary = { r = 0.800, g = 0.800, b = 0.800, a = 1.000 },
		secondary = { r = 0.850, g = 0.850, b = 0.850, a = 1.000 },
		tertiary = { r = 0.800, g = 0.800, b = 0.800, a = 1.000 },
		quaternary = { r = 0.850, g = 0.850, b = 0.850, a = 1.000 },
	}

	recipe.enabled = false
	recipe.energy_required = 15
	recipe.ingredients = {
		{ type = "item",  name = "apm_stone_crucible", amount = 4 },
		{ type = "item",  name = "iron-ore",           amount = 8 },
		{ type = "fluid", name = "water",              amount = 100, fluidbox_index = 1 },
		{ type = "fluid", name = "bob-oxygen",         amount = 40,  fluidbox_index = 2 }
	}
	recipe.results = {
		{ type = 'item',  name = 'steel-plate', amount = 4 },
		{ type = "fluid", name = "steam",       amount = 100, temperature = 280 }
	}
	recipe.main_product = ''
	recipe.requester_paste_multiplier = 4
	recipe.always_show_products = true
	recipe.always_show_made_in = apm_power_always_show_made_in
	--recipe.allow_decomposition = false
	--recipe.allow_as_intermediate = false
	--recipe.allow_intermediates = false

	data:extend({ recipe })
	apm.lib.utils.technology.add.recipe_for_unlock('advanced-material-processing', recipe.name)
end

-- bob only: steel fix --------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and not mods.angelssmelting and apm_power_compat_bob then
	unlock_steel_with_oxy()
end

-- sctm -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.ScienceCostTweakerM and apm_power_compat_sctm then
	apm.lib.utils.recipe.ingredient.replace('sct-lab-t2', 'lab', 'apm_lab_1')
	apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'sct-t1-ironcore', 'apm_gearing', 1)
	apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'sct-t1-magnet-coils', 'apm_electromagnet', 1)
	apm.lib.utils.recipe.ingredient.replace_all('sct-t1-magnet-coils', 'apm_electromagnet')
	apm.lib.utils.recipe.remove('lab')
	apm.lib.utils.recipe.remove('sct-t1-ironcore')
	apm.lib.utils.recipe.remove('sct-t1-magnet-coils')

	-- apm.power.machine_frame_addition('xxx', 3, nil, 3, nil)
	if apm_power_compat_sct_overhaul_machine_frames then
		apm.power.machine_frame_addition('sct-lab-t2', 3, 2, 8, 4)
		apm.power.machine_frame_addition('sct-lab-t3', 3, 3, 8, 4)
		apm.power.machine_frame_addition('sct-lab-t4', 3, 3, 8, 4)
	end
end

-- kingarthur -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.PyCoalTBaA and apm_power_compat_kingarthur then
	apm.lib.utils.recipe.result.mod('coal-gas', 'solid-coke', 4)
	apm.lib.utils.recipe.result.mod('coal-gas-from-wood', 'coal', 5)
	apm.lib.utils.recipe.result.mod('coarse-coal', 'coal', 1)
	apm.lib.utils.recipe.remove('coke-coal')
	apm.lib.utils.recipe.remove('treated-wood')

	--apm.lib.utils.recipe.ingredient.mod_temperature('recipe_name', 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("sodium-chlorate", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("vpulp1", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("vpulp5", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("clay", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberboard", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberglass", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("stone-wool", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("benzene-aromatics", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("bone-fat", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("glycerol2", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("nylon", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("collagen", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("plastics-3", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("phosphoric-acid", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("propene", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("raw-ralesia-extract", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("al-pulp-02", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("nickel-pulp-04", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-pulp-01", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-pulp-02", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("u-rich-pulp", 'steam', 165, 120)
	apm.lib.utils.recipe.ingredient.mod_temperature("fiberboard-2", 'steam', 165, 120)
end

if mods["deadlock-beltboxes-loaders"] then
	apm.lib.utils.recipe.ingredient.replace("transport-belt-beltbox", "electronic-circuit", "apm_mechanical_relay", 1)
	apm.lib.utils.recipe.ingredient.replace("fast-transport-belt-beltbox", "advanced-circuit", "electronic-circuit", 1)
end

--- [SafTheLamb]
---
--- [wood-logistics]
if mods["wood-logistics"] then
	require("prototypes.integrations.recipes.wood-logistics")
end

--- [crushing-industry]
if mods["crushing-industry"] then
	require("prototypes.integrations.recipes.crushing-industry")
end

--- [alloy-smelting]
if mods["alloy-smelting"] then
	require("prototypes.integrations.recipes.alloy-smelting")
end

---
--- [/SafTheLamb]

--- [hot-metals]
if mods["hot-metals"] then
	require("prototypes.integrations.recipes.hot-metals")
end

--- [ColonyBuilder]
if mods["ColonyBuilder"] then
	require("prototypes.integrations.recipes.colony-builder")
end
