require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/integrations/technologies.lua'

APM_LOG_HEADER(self)

local apm_power_overhaul_machine_frames = settings.startup["apm_power_overhaul_machine_frames"].value
local apm_power_steam_assembler_craftin_with_fluids = settings.startup["apm_power_steam_assembler_craftin_with_fluids"]
		.value
local apm_power_compat_bob = settings.startup["apm_power_compat_bob"].value
local apm_power_compat_bob_overhaul_machine_frames = settings.startup["apm_power_compat_bob_overhaul_machine_frames"]
		.value
local apm_power_compat_angel = settings.startup["apm_power_compat_angel"].value
local apm_power_compat_angel_overhaul_machine_frames = settings.startup
		["apm_power_compat_angel_overhaul_machine_frames"].value
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

APM_LOG_SETTINGS(self, 'apm_power_overhaul_machine_frames', apm_power_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_steam_assembler_craftin_with_fluids', apm_power_steam_assembler_craftin_with_fluids)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob', apm_power_compat_bob)
APM_LOG_SETTINGS(self, 'apm_power_compat_bob_overhaul_machine_frames', apm_power_compat_bob_overhaul_machine_frames)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel', apm_power_compat_angel)
APM_LOG_SETTINGS(self, 'apm_power_compat_angel_overhaul_machine_frames', apm_power_compat_angel_overhaul_machine_frames)
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

-- apm ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------

apm.lib.utils.technology.force.recipe_for_unlock('apm_crusher_machine_0', 'apm_gun_powder')
apm.lib.utils.technology.force.recipe_for_unlock('apm_fertiliser_2', 'apm_ammonium_sulfate_chem')

-- more early electric engine technology
apm.lib.utils.technology.remove.science_pack('electric-engine', 'chemical-science-pack')
apm.lib.utils.technology.add.prerequisites('electric-engine', 'apm_power_electricicty')

if mods.apm_recycling then
	apm.lib.utils.technology.add.science_pack('apm_recycling-0', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('apm_recycling-0', 'automation-science-pack')
	apm.lib.utils.technology.add.prerequisites('apm_recycling-0', 'apm_stone_bricks')
	apm.lib.utils.technology.mod.unit_count('apm_recycling-0', 20)
end

-- AsphaltRoads ----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['AsphaltRoads'] and apm_power_compat_arcitos then
	apm.lib.utils.technology.add.prerequisites('Arci-asphalt', 'apm_asphalt-1')
	if mods.bobplates and not mods.bobrevamp then
		apm.lib.utils.technology.remove.prerequisites('Arci-asphalt', 'oil-processing')
		apm.lib.utils.technology.add.prerequisites('Arci-asphalt', 'chemical-processing-2')
	end
	if mods.bobrevamp then
		apm.lib.utils.technology.remove.prerequisites('Arci-asphalt', 'oil-processing')
		apm.lib.utils.technology.add.prerequisites('Arci-asphalt', 'chemical-plant')
	end
end

-- bio_industries -------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.Bio_Industries and apm_power_compat_bio_industries then
	apm.lib.utils.technology.delete('bi-tech-coal-processing-2')
	apm.lib.utils.technology.delete('bi-tech-coal-processing-3')
	apm.lib.utils.recipe.disable('bi_recipe_crushed_stone')

	apm.lib.utils.technology.force.recipe_for_unlock('apm_power_electricity', 'bi_recipe_big_wooden_pole')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'bi_recipe_wood_pipe')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'bi_recipe_pipe_to_ground_wood')
end

-- Earendel -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['aai-industry'] and apm_power_compat_earendel then
	apm.lib.utils.technology.remove.recipe_from_unlock('basic-automation', 'burner-inserter')
	apm.lib.utils.recipe.enable('burner-inserter')
	apm.lib.utils.technology.delete('basic-logistics')
	apm.lib.utils.technology.delete('basic-automation')
	apm.lib.utils.technology.force.recipe_for_unlock('automation', 'inserter')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_stone_bricks', 'stone-tablet')
	apm.lib.utils.technology.add.prerequisites('toolbelt', 'apm_power_automation_science_pack')
	apm.lib.utils.technology.add.prerequisites('rail-signals', 'electronics')
	apm.lib.utils.technology.add.recipe_for_unlock('apm_power_electricity', 'electric-motor')
	apm.lib.utils.technology.add.prerequisites('fuel-processing', 'apm_power_electricity')
	apm.lib.utils.technology.delete('electricity')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_power_electricity', 'small-electric-pole')
	apm.lib.utils.technology.delete('basic-fluid-handling')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'pipe')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'pipe-to-ground')
	apm.lib.utils.technology.delete('electric-mining')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_electric_mining_drills', 'electric-mining-drill')
	apm.lib.utils.technology.delete('steam-power')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_power_steam', 'boiler')

	apm.lib.utils.technology.trigger.set.craft_item("automation-science-pack", "apm_lab_1", 1)
	apm.lib.utils.technology.add.prerequisites("lamp", "automation-science-pack")

	--- [electronics]
	apm.lib.utils.technology.force.recipe_for_unlock("electronics", "copper-cable")
	apm.lib.utils.technology.add.prerequisites("electronics", "apm_lab_1")
	apm.lib.utils.technology.add.prerequisites("automation-science-pack", "electronics")

	apm.lib.utils.technology.add.prerequisites("electric-lab", "automation")

	apm.lib.utils.technology.force.recipe_for_unlock("radar", "radar")

	apm.lib.utils.technology.delete("sand-processing")

	apm.lib.utils.technology.add.prerequisites("glass-processing", "apm_stone_bricks")

	if not mods.bobelectronics then
		apm.lib.utils.technology.force.recipe_for_unlock('apm_power_electricity', 'electronic-circuit')
	end
end

if mods['aai-vehicles-miner'] and apm_power_compat_earendel then
	apm.lib.utils.technology.add.science_pack('vehicle-miner', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('vehicle-miner', 'automation-science-pack')
	apm.lib.utils.technology.add.prerequisites('vehicle-miner-2', 'apm_electric_mining_drills')
end

if mods['aai-programmable-vehicles'] and apm_power_compat_earendel then
	apm.lib.utils.technology.add.prerequisites('position-beacon', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('vehicle-depot', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('vehicle-deployment', 'apm_power_electricity')
end

if mods['aai-vehicles-hauler'] and apm_power_compat_earendel then
	apm.lib.utils.technology.add.prerequisites('basic-vehicles', 'apm_puddling_furnace_0')
	apm.lib.utils.technology.add.science_pack('basic-vehicles', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('basic-vehicles', 'automation-science-pack')
	apm.lib.utils.technology.mod.unit_count('basic-vehicles', 30)
end

if mods['aai-vehicles-chaingunner'] and apm_power_compat_earendel then
	apm.lib.utils.technology.add.prerequisites('vehicle-chaingunner', 'apm_power_automation_science_pack')
	apm.lib.utils.technology.add.science_pack('basic-vehicles', 'apm_industrial_science_pack', 1)
end

if (mods['space-exploration'] or mods['aai-industry']) and apm_power_compat_earendel then
	apm.lib.utils.technology.remove.prerequisites_all('sand-processing')

	apm.lib.utils.technology.add.prerequisites('sand-processing', 'apm_stone_bricks')
	apm.lib.utils.technology.add.science_pack('sand-processing', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('sand-processing', 'automation-science-pack')
	apm.lib.utils.technology.add.science_pack('glass-processing', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('glass-processing', 'automation-science-pack')
	apm.lib.utils.technology.add.prerequisites('apm_greenhouse', 'glass-processing')
	apm.lib.utils.technology.add.prerequisites('apm_lab_1', 'glass-processing')
	apm.lib.utils.technology.add.prerequisites('fluid-handling', 'automation-2')

	apm.lib.utils.technology.add.prerequisites('apm_crusher_machine_0', 'burner-mechanics')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_puddling_furnace_0', 'boiler')
	apm.lib.utils.technology.add.prerequisites('apm_steam_science_pack', 'apm_puddling_furnace_0')

	apm.lib.utils.technology.force.recipe_for_unlock('electric-lab', 'lab')

	apm.lib.utils.technology.remove.recipe_from_unlock("burner-mechanics", "motor")
	apm.lib.utils.technology.remove.recipe_from_unlock("burner-mechanics", "iron-stick")
	apm.lib.utils.technology.remove.recipe_from_unlock("burner-mechanics", "burner-inserter")
end

-- Bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if apm_power_compat_bob then
	require("prototypes.integrations.technologies.bobs")
end

-- Angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('ore-crushing', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('water-treatment', 'apm_power_electricity')
end

if mods.angelssmelting and apm_power_compat_angel then
	apm.lib.utils.technology.delete('apm_steelworks-1')
	apm.lib.utils.technology.delete('apm_steelworks-2')
	apm.lib.utils.technology.add.prerequisites('angels-metallurgy-1', 'apm_power_electricity')
end

if mods.angelspetrochem and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('basic-chemistry', 'apm_power_electricity')
end

if mods['angelsaddons-warehouses'] and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('angels-warehouses', 'apm_power_automation_science_pack')
	apm.lib.utils.technology.add.science_pack('angels-warehouses', 'apm_industrial_science_pack', 1)
end

if mods.angelsbioprocessing and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('gardens', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('bio-arboretum-1', 'apm_power_electricity')

	apm.lib.utils.technology.delete('bio-wood-processing')
	apm.lib.utils.technology.delete('bio-wood-processing-2')
	apm.lib.utils.technology.delete('bio-wood-processing-3')

	apm.lib.utils.technology.add.prerequisites('bio-arboretum-2', 'apm_tools_2')
end

if mods.angelsindustries and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('angels-vequipment-1', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('cargo-robots', 'apm_power_electricity')
end

if mods['angelsaddons-smeltingtrain'] and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('angels-smelting-train', 'apm_power_electricity')
end

if mods['angelsaddons-petrotrain'] and apm_power_compat_angel then
	apm.lib.utils.technology.add.prerequisites('angels-petro-train', 'apm_power_electricity')
end

-- bob only: steel fix --------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and not mods.angelssmelting and apm_power_compat_bob then
	apm.lib.utils.technology.add.prerequisites('apm_steelworks-1', 'apm_power_electricity')
	apm.lib.utils.technology.remove.prerequisites('apm_steelworks-1', 'advanced-material-processing')
	apm.lib.utils.technology.add.prerequisites('advanced-material-processing', 'apm_steelworks-1')
	apm.lib.utils.technology.remove.science_pack('apm_steelworks-1', 'logistic-science-pack')
	apm.lib.utils.technology.add.science_pack('apm_steelworks-1', 'apm_industrial_science_pack')
end

-- Greenhouse -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if (mods.angelsbioprocessing and apm_power_compat_angel) or (mods.Bio_Industries and apm_power_compat_bio_industries) or (mods.bobgreenhouse and apm_power_compat_bob) then
	-- apm.lib.utils.technology.delete('apm_fertiliser_2')
	-- apm.lib.utils.technology.delete('apm_greenhouse-3')
end

-- MFerrari -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['Mining-Space-Industries'] and apm_power_compat_mferrari then
	if not mods.boblogistics then
		apm.lib.utils.technology.remove.prerequisites('logistics', 'laboratory')
	end
	apm.lib.utils.technology.add.prerequisites('laboratory', 'apm_power_electricity')
	apm.lib.utils.technology.force.recipe_for_unlock('laboratory', 'lab')
	apm.lib.utils.technology.add.science_pack('laboratory', 'apm_industrial_science_pack', 1)
end

-- sctm -----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.ScienceCostTweakerM and apm_power_compat_sctm then
	apm.lib.utils.technology.delete('sct-lab-t1')
	apm.lib.utils.technology.remove.recipe_from_unlock('apm_power_automation_science_pack', 'apm_electromagnet')
	apm.lib.utils.technology.delete('apm_power_automation_science_pack')

	apm.lib.utils.technology.remove.prerequisites('apm_power_electricity', 'automation-science-pack')
	apm.lib.utils.technology.remove.prerequisites('turrets', 'sct-automation-science-pack')
	apm.lib.utils.technology.remove.prerequisites('stone-walls', 'sct-automation-science-pack')

	apm.lib.utils.technology.force.recipe_for_unlock('sct-automation-science-pack', 'apm_electromagnet')
	apm.lib.utils.technology.add.prerequisites('sct-automation-science-pack', 'apm_lab_1')
	apm.lib.utils.technology.add.prerequisites('sct-automation-science-pack', 'apm_treated_wood_planks-1')
	apm.lib.utils.technology.add.science_pack('sct-automation-science-pack', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.mod.unit_count('sct-automation-science-pack', 50)
	apm.lib.utils.technology.mod.unit_time('sct-automation-science-pack', 30)

	if mods.apm_recycling then
		apm.lib.utils.technology.remove.prerequisites('apm_recycling-0', 'sct-automation-science-pack')
	end

	if mods.boblogistics then
		if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
			apm.lib.utils.technology.remove.prerequisites('logistics-0', 'sct-automation-science-pack')
		else
			apm.lib.utils.technology.remove.prerequisites('logistics', 'sct-automation-science-pack')
		end
	else
		apm.lib.utils.technology.remove.prerequisites('logistics', 'sct-automation-science-pack')
	end

	if mods.bobinserters or mods.boblogistics then
		apm.lib.utils.technology.remove.prerequisites('long-inserters-1', 'sct-automation-science-pack')
	end

	if mods['aai-industry'] then
		apm.lib.utils.technology.force.recipe_for_unlock('fuel-processing', 'fuel-processor')
		apm.lib.utils.technology.remove.prerequisites('sand-processing', 'sct-automation-science-pack')
		apm.lib.utils.technology.add.science_pack('electric-mining', 'automation-science-pack', 1)
		apm.lib.utils.technology.remove.science_pack('electric-mining', 'sct-science-pack-0')
		apm.lib.utils.technology.remove.science_pack('sct-automation-science-pack', 'sct-science-pack-0')
		apm.lib.utils.technology.delete('sct-aai-basic-fuel-processing')
		apm.lib.utils.technology.delete('sct-aai-advanced-fuel-processing')
		apm.lib.utils.technology.delete('sct-aai-nuclear-fuel-processing')
		apm.lib.utils.technology.delete('sct-aai-rocket-fuel-processing')
		apm.lib.utils.recipe.disable('sct-t0-crate')
		apm.lib.utils.recipe.disable('sct-t0-solvent')
		apm.lib.utils.recipe.disable('sct-science-pack-0')
	end
end

-- kingarthur -----------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.PyCoalTBaA and apm_power_compat_kingarthur then
	--apm.lib.utils.technology.remove.prerequisites('engine', 'coal-processing-1')
end

if mods["Smart_Inserters"] then
	apm.lib.utils.technology.delete("apm_burner_long_inserter")
end

if mods["deadlock-beltboxes-loaders"] then
	apm.lib.utils.technology.remove.science_packs_except("deadlock-stacking-1", { "apm_industrial_science_pack" })
	apm.lib.utils.technology.set.heritage_science_packs_from_prerequisites("deadlock-stacking-1")
end

--- [SafTheLamb]
---
--- [wood-logistics]
if mods["wood-logistics"] then
	require("prototypes.integrations.technologies.wood-logistics")
end

--- [crushing-industry]
if mods["crushing-industry"] then
	require("prototypes.integrations.technologies.crushing-industry")
end

--- [alloy-smelting]
if mods["alloy-smelting"] then
	require("prototypes.integrations.technologies.alloy-smelting")
end

---
--- [/SafTheLamb]

--- [hot-metals]
if mods["hot-metals"] then
	require("prototypes.integrations.technologies.hot-metals")
end
