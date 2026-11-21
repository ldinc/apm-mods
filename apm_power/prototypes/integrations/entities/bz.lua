if mods["bzsilicon"] or mods["bzsilicon2"] then
	local categories = { "basic-crushing" }

	if categories then
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_0", categories)
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_1", categories)
		apm.lib.utils.assembler.add.crafting_categories("apm_crusher_machine_2", categories)
	end
end

if mods["bzcarbon"] or mods["bzsilicon2"] then
	-- patch steam miner to extract carbon with flui
	---@type MiningDrillPrototype, boolean
	local miner, ok = apm.lib.utils.entity.get.by_name("apm_steam_mining_drill", "mining-drill") ---[[@as MiningDrillPrototype]]

	if ok then
		miner.input_fluid_box = {
			volume = 200,
			pipe_connections =
			{
				{ direction = defines.direction.south, position = { 0, 1 } }
			},
			production_type = "input",
			filter = "steam"
		}

		miner.energy_source.fluid_box.pipe_connections = {
			{
				flow_direction = "input-output",
				direction = defines.direction.east,
				position = { 1, 0 },
			},
			{
				flow_direction = "input-output",
				direction = defines.direction.west,
				position = { -1, 0 },
			},
		}
	end
end
