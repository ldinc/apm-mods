local apm_power_compat_bob_overhaul_machine_frames = settings.startup["apm_power_compat_bob_overhaul_machine_frames"]
		.value

--- [bobpower]
if mods.bobpower then
	if apm.lib.utils.setting.get.starup('bobmods-power-steam') then
		apm.lib.utils.recipe.remove('apm_boiler_2')
		apm.lib.utils.recipe.remove('apm_steam_engine_2')
	end

	apm.lib.utils.recipe.ingredient.mod('bob-steam-engine-2', 'apm_electromagnet', 6)
	apm.lib.utils.recipe.ingredient.mod('bob-steam-engine-3', 'apm_electromagnet', 6)
	apm.lib.utils.recipe.ingredient.mod('bob-steam-engine-4', 'apm_electromagnet', 6)
	apm.lib.utils.recipe.ingredient.mod('bob-steam-engine-5', 'apm_electromagnet', 6)
	apm.lib.utils.recipe.ingredient.mod('bob-steam-turbine-2', 'apm_electromagnet', 12)
	apm.lib.utils.recipe.ingredient.mod('bob-steam-turbine-3', 'apm_electromagnet', 12)
	apm.lib.utils.recipe.ingredient.mod('bob-fluid-generator', 'apm_electromagnet', 12)
	apm.lib.utils.recipe.ingredient.mod('bob-fluid-generator-2', 'apm_electromagnet', 12)
	apm.lib.utils.recipe.ingredient.mod('bob-fluid-generator-3', 'apm_electromagnet', 12)
	apm.lib.utils.recipe.ingredient.mod('bob-hydrazine-generator', 'apm_electromagnet', 12)
end

--- [boblogistics]
if mods.boblogistics then
	if apm.lib.utils.setting.get.starup('bobmods-logistics-inserteroverhaul') then
		apm.lib.utils.recipe.ingredient.mod('fast-inserter', 'apm_gearing', 0)
		if mods.bobores and mods.bobplates then
			apm.lib.utils.recipe.ingredient.replace('inserter', 'iron-plate', 'bob-tin-plate')
		end
	else
		if mods.bobores and mods.bobplates then
			apm.lib.utils.recipe.ingredient.replace('inserter', 'iron-plate', 'bob-tin-plate')
		end
	end

	if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
		apm.lib.utils.recipe.ingredient.replace('logistic-science-pack', 'basic-transport-belt', 'transport-belt')
	end
end

--- [bobplates]
if mods.bobplates then
	apm.lib.utils.recipe.ingredient.mod('bob-enriched-fuel-from-liquid-fuel', 'solid-fuel', 1)
	apm.lib.utils.recipe.ingredient.replace('bob-solid-fuel-from-hydrogen', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('bob-polishing-wheel', 'wood', 'apm_wood_pellets', 1)

	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('bob-chemical-furnace', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bob-electric-mixing-furnace', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bob-distillery', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bob-electrolyser', 3, nil, 3, nil)
	end

	if not mods.angelsrefining and not mods['aai-industry'] then
		apm.lib.utils.recipe.ingredient.mod('apm_lab_0', 'bob-glass', 5)
		apm.lib.utils.recipe.ingredient.mod('apm_lab_1', 'bob-glass', 10)
		apm.lib.utils.recipe.ingredient.mod('apm_greenhouse_0', 'bob-glass', 25)
	end
end

--- [bobtech]
if mods.bobtech then
	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('bob-lab-2', 3, 3, 8, 5)
	end

	apm.lib.utils.recipe.remove("bob-burner-lab")
end

--- [bobgreenhouse]
if mods.bobgreenhouse then
	apm.lib.utils.recipe.ingredient.mod('bob-seedling', 'wood', 0)
	apm.lib.utils.recipe.ingredient.mod('bob-seedling', 'apm_tree_seeds', 1)
	apm.lib.utils.recipe.result.mod('bob-seedling', 'bob-seedling', 10)
end

--- [bobelectronics]
if mods.bobelectronics then
	if mods.angelsrefining then
		apm.lib.utils.recipe.ingredient.mod('clarifier', 'electronic-circuit', 0)
		apm.lib.utils.recipe.ingredient.mod('clarifier', 'bob-basic-circuit-board', 4)
	end

	if not mods.boblogistics then
		apm.lib.utils.recipe.ingredient.mod('splitter', 'bob-basic-circuit-board', 0)
	elseif mods.boblogistics then
		if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
			apm.lib.utils.recipe.ingredient.mod('splitter', 'bob-basic-circuit-board', 5)
		else
			apm.lib.utils.recipe.ingredient.mod('splitter', 'bob-basic-circuit-board', 0)
		end
	end

	apm.lib.utils.recipe.ingredient.mod('electronic-circuit', 'apm_wood_board', 0)
	apm.lib.utils.recipe.ingredient.mod('repair-pack', 'bob-basic-circuit-board', 0)
	apm.lib.utils.recipe.ingredient.mod('bob-carbon', 'coal', 0)
	apm.lib.utils.recipe.ingredient.mod('bob-carbon', 'apm_coke', 1)
	apm.lib.utils.recipe.ingredient.mod('offshore-pump', 'bob-basic-circuit-board', 0)
	apm.lib.utils.recipe.ingredient.mod('rail-signal', 'bob-basic-circuit-board', 1)
	apm.lib.utils.recipe.ingredient.mod('rail-signal', 'electronic-circuit', 0)
	apm.lib.utils.recipe.ingredient.mod('rail-chain-signal', 'bob-basic-circuit-board', 1)
	apm.lib.utils.recipe.ingredient.mod('rail-chain-signal', 'electronic-circuit', 1)
	apm.lib.utils.recipe.ingredient.replace('bob-phenolic-board', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('electric-mining-drill', 'bob-basic-circuit-board', 'electronic-circuit')
end

--- [bobmining]
if mods.bobmining then
	apm.lib.utils.recipe.remove('bob-steam-mining-drill')
end

--- [bobassembly]
if mods.bobassembly then
	apm.lib.utils.recipe.remove('bob-burner-assembling-machine')
	apm.lib.utils.recipe.remove('bob-steam-assembling-machine')

	apm.power.machine_frame_addition('bob-assembling-machine-3', 3, 3, 7, 4)
	apm.lib.utils.recipe.ingredient.replace('bob-electronics-machine-1', 'iron-gear-wheel', 'apm_gearing')

	if apm_power_compat_bob_overhaul_machine_frames then
		apm.power.machine_frame_addition('bob-assembling-machine-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('bob-assembling-machine-5', 3, 3, 11, 6)
		apm.power.machine_frame_addition('bob-assembling-machine-6', 3, 3, 13, 7)

		apm.power.machine_frame_addition('bob-chemical-plant-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-chemical-plant-3', 3, 3, 7, 4)
		apm.power.machine_frame_addition('bob-chemical-plant-4', 3, 3, 9, 5)

		apm.power.machine_frame_addition('bob-electric-furnace-2', 3, 3, 7, 4)
		apm.power.machine_frame_addition('bob-electric-furnace-3', 3, 3, 9, 5)

		apm.power.machine_frame_addition('bob-electronics-machine-1', 3, nil, 3, nil)
		apm.power.machine_frame_addition('bob-electronics-machine-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-electronics-machine-3', 3, 3, 7, 4)

		apm.power.machine_frame_addition('bob-electric-chemical-mixing-furnace', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-electric-chemical-mixing-furnace-2', 3, 3, 7, 4)

		apm.power.machine_frame_addition('bob-distillery-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-distillery-3', 3, 3, 7, 4)
		apm.power.machine_frame_addition('bob-distillery-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('bob-distillery-5', 3, 3, 11, 6)

		apm.power.machine_frame_addition('bob-electrolyser-2', 3, 3, 5, 3)
		apm.power.machine_frame_addition('bob-electrolyser-3', 3, 3, 6, 4)
		apm.power.machine_frame_addition('bob-electrolyser-4', 3, 3, 9, 5)
		apm.power.machine_frame_addition('bob-electrolyser-5', 3, 3, 12, 6)

		apm.power.machine_frame_addition('bob-oil-refinery-2', 3, 3, 8, 5)
		apm.power.machine_frame_addition('bob-oil-refinery-3', 3, 3, 10, 6)
		apm.power.machine_frame_addition('bob-oil-refinery-4', 3, 3, 13, 7)
	end
end

--- [bobwarfare]
if mods.bobwarfare then
	apm.lib.utils.recipe.ingredient.replace('bob-poison-rocket-warhead', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('bob-poison-artillery-shell', 'coal', 'apm_coal_crushed', 1)
	apm.lib.utils.recipe.ingredient.replace('bob-poison-bullet-projectile', 'coal', 'apm_coal_crushed', 1)
	apm.lib.utils.recipe.ingredient.replace('bob-shotgun-poison-shell', 'coal', 'apm_coal_crushed', 2)
	apm.lib.utils.recipe.ingredient.replace('bob-gun-cotton', 'wood', 'apm_wood_pellets', 2)
	apm.lib.utils.recipe.ingredient.replace('bob-sniper-rifle', 'wood', 'apm_treated_wood_planks', 1)
end
