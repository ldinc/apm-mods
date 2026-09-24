-- Tips and tricks simulation: radioactive items hurt the character that carries them.
-- Runs as a console command inside the simulation (no require). The damage comes from
-- apm_lib's own runtime script, loaded through `mods = { "apm_lib_ldinc" }` in the tip.

game.simulation.camera_position = { 0, 0 }

local player = game.simulation.create_test_player({ name = "engineer" })
game.simulation.camera_player = player

-- A simulation's script cannot change its map settings, so radiation damage is switched on
-- through apm_lib's remote interface.
if remote.interfaces["apm_radiation"] and remote.interfaces["apm_radiation"]["set_enabled"] then
	remote.call("apm_radiation", "set_enabled", true)
end

local character = player.character

if character then
	character.insert({ name = "uranium-235", count = 5 })
end

storage.apm_player = player

-- keep the engineer alive: heal every 30 s
script.on_nth_tick(60 * 30, function()
	local p = storage.apm_player
	local c = p and p.valid and p.character

	if c and c.valid then
		c.health = c.max_health
	end
end)
