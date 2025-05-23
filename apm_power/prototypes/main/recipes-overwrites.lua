require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/recipes-overwrites.lua'

APM_LOG_HEADER(self)

apm.lib.utils.recipe.ingredient.replace('assembling-machine-1', 'iron-gear-wheel', 'apm_gearing')
if apm.lib.utils.setting.get.starup('apm_power_overhaul_machine_frames') then
	apm.lib.utils.recipe.ingredient.mod('assembling-machine-1', 'iron-plate', 0)
	apm.power.machine_frame_addition('assembling-machine-1', 3, nil, 3, nil)
end

apm.lib.utils.recipe.ingredient.replace('assembling-machine-2', 'iron-gear-wheel', 'apm_gearing')
if apm.lib.utils.setting.get.starup('apm_power_overhaul_machine_frames') then
	apm.lib.utils.recipe.ingredient.mod('assembling-machine-2', 'steel-plate', 0)
	apm.power.machine_frame_addition('assembling-machine-2', 3, 3, 5, 3)
end

apm.lib.utils.recipe.ingredient.replace('assembling-machine-3', 'iron-gear-wheel', 'apm_gearing')
apm.power.machine_frame_addition('assembling-machine-3', 3, 3, 7, 4)

apm.lib.utils.recipe.ingredient.replace('oil-refinery', 'iron-gear-wheel', 'apm_gearing')
apm.lib.utils.recipe.ingredient.mod('oil-refinery', 'apm_gearing', 3)
--apm.lib.utils.recipe.ingredient.replace('oil-refinery', 'stone-brick', 'apm_asphalt')
apm.power.machine_frame_addition('oil-refinery', 3, nil, 6, nil)

apm.lib.utils.recipe.ingredient.replace('chemical-plant', 'iron-gear-wheel', 'apm_gearing')
apm.lib.utils.recipe.ingredient.mod('chemical-plant', 'apm_gearing', 3)
apm.power.machine_frame_addition('chemical-plant', 3, nil, 3, nil)

apm.lib.utils.recipe.ingredient.replace('lab', 'iron-gear-wheel', 'apm_gearing')
apm.power.machine_frame_addition('lab', 3, nil, 4, nil)

apm.power.machine_frame_addition('electric-furnace', 3, nil, 5, nil)

apm.lib.utils.recipe.ingredient.mod('iron-gear-wheel', 'iron-plate', 1)

apm.lib.utils.recipe.energy_required.mod('firearm-magazine', 2)


apm.lib.utils.recipe.ingredient.mod('splitter', 'electronic-circuit', 0)
apm.lib.utils.recipe.ingredient.mod('splitter', 'apm_mechanical_relay', 5)

apm.lib.utils.recipe.ingredient.mod('boiler', 'stone-furnace', 0)
apm.lib.utils.recipe.ingredient.mod('boiler', 'copper-plate', 15)
apm.lib.utils.recipe.ingredient.mod('boiler', 'steel-plate', 10)
apm.lib.utils.recipe.ingredient.mod('boiler', 'stone-brick', 10)

apm.lib.utils.recipe.ingredient.mod('repair-pack', 'electronic-circuit', 0)
apm.lib.utils.recipe.ingredient.mod('repair-pack', 'apm_mechanical_relay', 2)

apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'iron-gear-wheel', 1)
apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'apm_iron_bearing', 1)
apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'apm_simple_engine', 1)
apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'iron-stick', 0)
apm.lib.utils.recipe.ingredient.mod('burner-inserter', 'apm_mechanical_relay', 1)

apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'iron-gear-wheel', 1)
apm.lib.utils.recipe.ingredient.mod('steam-inserter', 'apm_iron_bearing', 1)


apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'iron-gear-wheel', 0)
apm.lib.utils.recipe.ingredient.mod('burner-mining-drill', 'apm_simple_engine', 1)

apm.lib.utils.recipe.ingredient.replace('inserter', 'iron-gear-wheel', 'apm_gearing')
apm.lib.utils.recipe.ingredient.replace('inserter', 'burner-inserter', 'apm_steam_inserter')
apm.lib.utils.recipe.ingredient.mod('inserter', 'apm_steam_inserter', 1)

-- apm.lib.utils.recipe.ingredient.mod('fast-inserter', 'apm_gearing', 2)

apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'iron-stick', 0)
apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'iron-plate', 2)
apm.lib.utils.recipe.ingredient.mod('long-handed-inserter', 'electronic-circuit', 1)
apm.lib.utils.recipe.ingredient.replace('long-handed-inserter', 'iron-gear-wheel', 'apm_gearing', 2)
apm.lib.utils.recipe.ingredient.replace('long-handed-inserter', 'inserter', 'apm_steam_inserter_long')

apm.lib.utils.recipe.ingredient.mod('transport-belt', 'apm_rubber', 1)
apm.lib.utils.recipe.ingredient.mod('transport-belt', 'iron-stick', 2)
apm.lib.utils.recipe.ingredient.mod('transport-belt', 'iron-plate', 0)

apm.lib.utils.recipe.ingredient.mod('offshore-pump', 'apm_steam_relay', 2)
apm.lib.utils.recipe.ingredient.mod('offshore-pump', 'electronic-circuit', 0)

apm.lib.utils.recipe.ingredient.mod('engine-unit', 'iron-gear-wheel', 0)
apm.lib.utils.recipe.ingredient.mod('engine-unit', 'apm_simple_engine', 2)
apm.lib.utils.recipe.ingredient.mod('engine-unit', 'apm_iron_bearing', 2)
apm.lib.utils.recipe.ingredient.mod('engine-unit', 'apm_iron_gearing', 2)

apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', 'apm_electromagnet', 8)
apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', 'apm_simple_engine', 0)
apm.lib.utils.recipe.ingredient.mod('electric-engine-unit', 'apm_iron_bearing', 2)
local recipe = data.raw.recipe['electric-engine-unit']
recipe.energy_required = 3


apm.lib.utils.recipe.ingredient.mod('steam-engine', 'iron-gear-wheel', 0)
apm.lib.utils.recipe.ingredient.mod('steam-engine', 'pipe', 5)
apm.lib.utils.recipe.ingredient.mod('steam-engine', 'apm_steam_engine', 3)
apm.lib.utils.recipe.ingredient.mod('steam-engine', 'apm_electromagnet', 6)

apm.lib.utils.recipe.ingredient.mod('steam-turbine', 'iron-gear-wheel', 0)
apm.lib.utils.recipe.ingredient.mod('steam-turbine', 'apm_electromagnet', 12)
apm.lib.utils.recipe.ingredient.mod('steam-turbine', 'apm_steam_engine', 6)

apm.lib.utils.recipe.ingredient.mod('locomotive', 'electronic-circuit', 0)
apm.lib.utils.recipe.ingredient.mod('locomotive', 'apm_steam_relay', 20)
apm.lib.utils.recipe.ingredient.replace('locomotive', 'engine-unit', 'apm_steam_engine', 1)

apm.lib.utils.recipe.ingredient.mod('car', 'apm_rubber', 4)

apm.lib.utils.recipe.ingredient.mod('train-stop', 'electronic-circuit', 0)
apm.lib.utils.recipe.ingredient.mod('train-stop', 'apm_steam_relay', 20)

apm.lib.utils.recipe.ingredient.mod('pipe', 'apm_sealing_rings', 1)

apm.lib.utils.recipe.ingredient.mod('storage-tank', 'iron-plate', 20)
apm.lib.utils.recipe.ingredient.mod('storage-tank', 'steel-plate', 0)
apm.lib.utils.recipe.ingredient.mod('storage-tank', 'stone-brick', 20)

apm.lib.utils.recipe.ingredient.mod('rail', 'iron-stick', 0)
apm.lib.utils.recipe.ingredient.mod('rail', 'apm_treated_wood_planks', 4)
apm.lib.utils.recipe.ingredient.replace('rail', 'stone', 'apm_crushed_stone', 4)

apm.lib.utils.recipe.ingredient.replace('small-electric-pole', 'wood', 'apm_treated_wood_planks', 2)
apm.lib.utils.recipe.ingredient.mod('small-electric-pole', 'apm_rubber', 1)

--[[
	todo: further change...
	apm.lib.utils.recipe.ingredient.mod('medium-electric-pole', 'iron-stick', 0)
	apm.lib.utils.recipe.ingredient.mod('medium-electric-pole', 'apm_rubber', 1, 2)
	apm.lib.utils.recipe.ingredient.mod('medium-electric-pole', 'apm_treated_wood_planks', 3, 5)

	apm.lib.utils.recipe.ingredient.mod('big-electric-pole', 'iron-stick', 0)
	apm.lib.utils.recipe.ingredient.mod('big-electric-pole', 'apm_rubber', 1, 2)
	apm.lib.utils.recipe.ingredient.mod('big-electric-pole', 'apm_treated_wood_planks', 4, 6)
	]] --

apm.lib.utils.recipe.ingredient.mod('logistic-science-pack', 'pipe', 1)

apm.lib.utils.recipe.ingredient.replace('combat-shotgun', 'wood', 'apm_treated_wood_planks', 2)

apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'iron-gear-wheel', 0)
apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'apm_gearing', 2)
apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'apm_electromagnet', 4)
apm.lib.utils.recipe.ingredient.mod('electric-mining-drill', 'apm_steam_mining_drill', 1)

apm.lib.utils.recipe.ingredient.mod('empty-barrel', 'apm_sealing_rings', 1)

apm.lib.utils.recipe.ingredient.replace('plastic-bar', 'coal', 'apm_coal_crushed', 2)
apm.lib.utils.recipe.ingredient.replace('explosives', 'coal', 'apm_coal_crushed', 2)
apm.lib.utils.recipe.ingredient.replace('grenade', 'coal', 'apm_coal_crushed', 1)
apm.lib.utils.recipe.ingredient.replace('slowdown-capsule', 'coal', 'apm_coal_crushed', 2)
apm.lib.utils.recipe.ingredient.replace('poison-capsule', 'coal', 'apm_coal_crushed', 1)

apm.lib.utils.recipe.ingredient.mod('stone-brick', 'apm_stone_brick_raw', 1)
apm.lib.utils.recipe.ingredient.mod('stone-brick', 'stone', 0)

apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'iron-gear-wheel', 'apm_gearing', 1)
apm.lib.utils.recipe.ingredient.replace('automation-science-pack', 'copper-plate', 'apm_electromagnet', 2)
apm.lib.utils.recipe.ingredient.mod('automation-science-pack', 'apm_treated_wood_planks', 2)

apm.lib.utils.recipe.ingredient.mod('electronic-circuit', 'apm_wood_board', 1)

apm.lib.utils.recipe.category.change("copper-cable", "crafting")

apm.lib.utils.recipe.remove("steel-plate")

if apm.lib.features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod("assembling-machine-1", "apm_assembling_machine_1", 1)

	apm.power.machine_frame_addition('assembling-machine-1', 3, 2, 3, 3)
end

local features = apm.lib.features
if features.frames_recycling and features.reuse_previous_tier and features.frames_overhaul then
	apm.power.try_set_frames_to_recipe_results("apm_assembling_machine_1")
	apm.power.try_set_frames_to_recipe_results("apm_crusher_machine_1")
	apm.power.try_set_frames_to_recipe_results("apm_crusher_machine_2")
	apm.power.try_set_frames_to_recipe_results("apm_press_machine_1")
	apm.power.try_set_frames_to_recipe_results("apm_press_machine_2")
	apm.power.try_set_frames_to_recipe_results("apm_greenhouse_1")
	apm.power.try_set_frames_to_recipe_results("apm_greenhouse_2")
	apm.power.try_set_frames_to_recipe_results("apm_centrifuge_1")
	apm.power.try_set_frames_to_recipe_results("apm_centrifuge_2")
	apm.power.try_set_frames_to_recipe_results("apm_lab_1")
	apm.power.try_set_frames_to_recipe_results("apm_steelworks_1")
	apm.power.try_set_frames_to_recipe_results("apm_coking_plant_1")
	apm.power.try_set_frames_to_recipe_results("apm_coking_plant_2")
	apm.power.try_set_frames_to_recipe_results("apm_air_cleaner_machine_1")
end

if features.reuse_previous_tier then
	apm.lib.utils.recipe.ingredient.mod("pump", "apm_pump_0", 1)
	apm.lib.utils.recipe.ingredient.mod("offshore-pump", "apm_offshore_pump_1", 1)
end


if mods["space-age"] then
	local recipe = 'offshore-pump'
	apm.lib.utils.recipe.ingredient.remove_all(recipe)

	apm.lib.utils.recipe.ingredient.mod(recipe, 'electric-engine-unit', 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_rubber', 30)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'tungsten-plate', 10)
	apm.lib.utils.recipe.ingredient.mod(recipe, 'processing-unit', 6)

	apm.lib.utils.recipe.category.create("apm_light_metallurgy")

	local foundry_indtegration = {
		"iron-gear-wheel",
		"transport-belt",
		"splitter",
		"underground-belt",
		"fast-underground-belt",
		"fast-splitter",
		"fast-transport-belt",
	}

	for _, recipe_name in ipairs(foundry_indtegration) do
		apm.lib.utils.recipe.category.change(recipe_name, "apm_light_metallurgy")
	end

	local assembling_with_light_metallurgy = {
		"apm_assembling_machine_0",
		"apm_assembling_machine_1",
		"assembling-machine-1",
		"assembling-machine-2",
		"assembling-machine-3",
		"foundry",
	}

	for _, assemnling_machine_name in ipairs(assembling_with_light_metallurgy) do
		apm.lib.utils.assembler.add.crafting_categories(assemnling_machine_name, { "apm_light_metallurgy" })
	end

	apm.lib.utils.character.crafting_category.add("character", "apm_light_metallurgy")
end
