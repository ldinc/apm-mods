--- [bobinserters]
if mods.bobinserters then
	apm.lib.utils.technology.delete('apm_burner_long_inserter')

	apm.lib.utils.technology.add.prerequisites('bob-long-inserters-1', 'apm_puddling_furnace_0')
	apm.lib.utils.technology.remove.prerequisites('bob-long-inserters-1', 'logistics')
	apm.lib.utils.technology.add.science_pack('bob-long-inserters-1', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('bob-long-inserters-1', 'automation-science-pack')
	apm.lib.utils.technology.mod.unit_count('bob-long-inserters-1', 50)
	apm.lib.utils.technology.mod.unit_time('bob-long-inserters-1', 25)

	apm.lib.utils.technology.remove.prerequisites('bob-near-inserters', 'logistics')
	apm.lib.utils.technology.add.prerequisites('bob-near-inserters', 'apm_puddling_furnace_0')
	apm.lib.utils.technology.add.science_pack('bob-near-inserters', 'apm_industrial_science_pack', 1)
	apm.lib.utils.technology.remove.science_pack('bob-near-inserters', 'automation-science-pack')
	apm.lib.utils.technology.mod.unit_count('bob-near-inserters', 50)
	apm.lib.utils.technology.mod.unit_time('bob-near-inserters', 25)
end

--- [bobplates]
if mods.bobplates then
	apm.lib.utils.technology.add.prerequisites('bob-alloy-processing', 'apm_power_automation_science_pack')
	apm.lib.utils.technology.add.prerequisites('bib0chemical-processing-1', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('bob-electrolysis-1', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('bob-air-compressor-1', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('bob-water-bore-1', 'apm_power_electricity')
end

--- [bobmining]
if mods.bobmining then
	apm.lib.utils.technology.add.prerequisites('bob-drills-1', 'apm_electric_mining_drills')
	apm.lib.utils.technology.add.prerequisites('bob-area-drills-1', 'apm_electric_mining_drills')
	apm.lib.utils.technology.add.prerequisites('bob-water-miner-1', 'apm_electric_mining_drills')
	apm.lib.utils.technology.add.prerequisites('bob-pumpjacks-1', 'apm_electric_mining_drills')
	apm.lib.utils.technology.add.prerequisites('bob-pumpjacks-1', 'logistic-science-pack')
	apm.lib.utils.technology.add.prerequisites('bob-steel-axe-2', 'logistic-science-pack')
end

--- [bobrevamp]
if mods.bobrevamp then
	apm.lib.utils.technology.add.prerequisites('pumpjack', 'logistic-science-pack')
end

--- [boblogistics]
if mods.boblogistics then
	if not mods.bobinserters and apm.lib.utils.setting.get.starup('bobmods-logistics-inserteroverhaul') then
		apm.lib.utils.technology.delete('apm_burner_long_inserter')

		apm.lib.utils.technology.add.prerequisites('bob-long-inserters-1', 'apm_puddling_furnace_0')
		apm.lib.utils.technology.remove.prerequisites('bob-long-inserters-1', 'logistics')
		apm.lib.utils.technology.add.science_pack('bob-long-inserters-1', 'apm_industrial_science_pack', 1)
		apm.lib.utils.technology.remove.science_pack('bob-long-inserters-1', 'automation-science-pack')
		apm.lib.utils.technology.mod.unit_count('bob-long-inserters-1', 50)
		apm.lib.utils.technology.mod.unit_time('bob-long-inserters-1', 25)
	end
	if apm.lib.utils.setting.get.starup('bobmods-logistics-beltoverhaul') then
		-- logistics-0
		apm.lib.utils.technology.add.prerequisites('apm_power_steam', 'logistics-0')
		apm.lib.utils.technology.add.prerequisites('logistics-0', 'apm_rubber-1')
		apm.lib.utils.technology.add.science_pack('logistics-0', 'apm_industrial_science_pack', 1)
		apm.lib.utils.technology.remove.science_pack('logistics-0', 'automation-science-pack')
		apm.lib.utils.technology.force.recipe_for_unlock('logistics-0', 'basic-transport-belt')
		apm.lib.utils.technology.mod.order('logistics-0', 'a-a-a')

		apm.lib.utils.technology.add.prerequisites('logistics', 'logistics-0')

		-- logistics
		apm.lib.utils.technology.remove.prerequisites('apm_power_steam', 'logistics')
		apm.lib.utils.technology.add.prerequisites('logistics', 'apm_power_electricity')
		apm.lib.utils.technology.remove.prerequisites('logistics', 'apm_rubber-1')
		apm.lib.utils.technology.add.science_pack('logistics', 'automation-science-pack', 1)
		apm.lib.utils.technology.remove.science_pack('logistics', 'apm_industrial_science_pack')
		apm.lib.utils.technology.mod.unit_count('logistics', 50)
		-- logistic-science-pack
		apm.lib.utils.technology.add.prerequisites('logistic-science-pack', 'logistics')
	end

	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'bob-copper-pipe')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_water_supply-1', 'bob-copper-pipe-to-ground')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_stone_bricks', 'bob-stone-pipe')
	apm.lib.utils.technology.force.recipe_for_unlock('apm_stone_bricks', 'bob-stone-pipe-to-ground')

	if mods["aai-loaders"] then
		apm.lib.utils.technology.remove.prerequisites_all("aai-basic-loader")
		apm.lib.utils.technology.add.prerequisites("aai-basic-loader", "logistics-0")

		apm.lib.utils.technology.force.update_science_packs("aai-basic-loader")
		apm.lib.utils.technology.trigger.set.craft_item("aai-basic-loader", "bob-basic-transport-belt", 200)
	end
end

--- [bobelectronics]
if mods.bobelectronics then
	apm.lib.utils.recipe.remove('bob-wooden-board')

	apm.lib.utils.technology.remove.prerequisites('apm_water_supply-2', 'apm_power_electricity')
	apm.lib.utils.technology.add.prerequisites('apm_water_supply-2', 'electronics')

	apm.lib.utils.technology.force.recipe_for_unlock('electronics', 'bob-basic-circuit-board')
end

--- [bobtech]
if mods.bobtech then
	if not mods.PyCoalTBaA then
		apm.lib.utils.technology.mod.icon(
			'apm_power_automation_science_pack',
			'__apm_resource_pack_ldinc__/graphics/technologies/apm_power_bob_automation_science_pack.png')
	end
end

--- [bobwarfare]
if mods.bobwarfare then
	-- apm.lib.utils.technology.remove.prerequisites('radar-1', 'military')
	-- apm.lib.utils.technology.add.prerequisites('radar-1', 'military-2')
	apm.lib.utils.technology.add.prerequisites('bob-turrets-2', 'logistic-science-pack')
	apm.lib.utils.technology.add.prerequisites('bob-sniper-turrets-1', 'military-science-pack')
end

--- [bobpower]
if mods.bobpower then
	if apm.lib.utils.setting.get.starup('bobmods-power-steam') then
		apm.lib.utils.technology.delete('apm_power_boiler')
		apm.lib.utils.technology.delete('apm_steam_engine')
	end

	apm.lib.utils.technology.add.prerequisites('bob-steam-engine-2', 'apm_power_electricity')
	apm.lib.utils.technology.mod.unit_count('bob-steam-engine-2', 100)
	apm.lib.utils.technology.mod.unit_count('bob-steam-engine-3', 125)
	apm.lib.utils.technology.mod.unit_count('bob-steam-engine-4', 150)
	apm.lib.utils.technology.mod.unit_count('bob-steam-engine-5', 200)
	apm.lib.utils.technology.add.prerequisites('bob-boiler-2', 'apm_power_electricity')
	apm.lib.utils.technology.mod.unit_count('bob-boiler-2', 100)
	apm.lib.utils.technology.mod.unit_count('bob-boiler-3', 125)
	apm.lib.utils.technology.mod.unit_count('bob-boiler-4', 150)
	apm.lib.utils.technology.mod.unit_count('bob-boiler-5', 200)
	apm.lib.utils.technology.force.recipe_for_unlock('apm_power_electricity', 'bob-burner-generator')
end

--- [bobgreenhouse]
if mods.bobgreenhouse then
	apm.lib.utils.technology.add.prerequisites('bob-greenhouse', 'apm_power_electricity')
end
