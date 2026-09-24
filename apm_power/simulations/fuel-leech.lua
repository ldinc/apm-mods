-- Tips and tricks simulation: burner inserters refuel from the machine they serve.
--
-- Scene: input chest (iron plates) -> burner inserter -> basic assembling machine (iron gear
-- wheels) -> burner inserter -> output chest. Nothing has fuel: the inserters only have the
-- small energy buffer they get when they are built, the machine has none. After a delay the
-- machine gets 10 coal; both inserters take fuel for themselves from the machine's fuel slot
-- (apm_lib leaves at least one coal in the slot), and the gears start to arrive in the output
-- chest. The scene is rebuilt every 40 s.
--
-- Runs as a console command inside the simulation (no require). The refuelling comes from
-- apm_lib's own runtime script, loaded through `mods = { "apm_lib_ldinc" }` in the tip; this
-- file only builds the scene, labels the slot contents (fuel is not visible otherwise) and
-- replays the scene.

game.simulation.camera_position = { 0.5, 0.5 }

local surface = game.surfaces[1]

local COAL_DELAY = 60 * 5 -- ticks until the machine gets its coal
local COAL_COUNT = 10
local LOOP = 60 * 40      -- ticks until the scene is rebuilt

local INPUT_CHEST = { -2.5, 0.5 }
local INPUT_INSERTER = { -1.5, 0.5 }
local MACHINE = { 0.5, 0.5 } -- 3x3: x from -1 to 2
local OUTPUT_INSERTER = { 2.5, 0.5 }
local OUTPUT_CHEST = { 3.5, 0.5 }

-- A simulation's script cannot change its map settings, so the inserter functions are
-- switched on through apm_lib's remote interface.
local function enable()
	if remote.interfaces["apm_inserter"] and remote.interfaces["apm_inserter"]["set_enabled"] then
		remote.call("apm_inserter", "set_enabled", true)
	end
end

--- An inserter's direction points to its pickup side (vanilla tips: an inserter moving items
--- from west to east has direction west).
---@param x number
---@param from_x number
---@return defines.direction
local function inserter_direction(x, from_x)
	if from_x < x then
		return defines.direction.west
	end
	return defines.direction.east
end

--- A freshly built burner inserter: no fuel, only the energy buffer of a new inserter.
---@param position MapPosition
---@param from_x number
---@return LuaEntity
local function build_inserter(position, from_x)
	local e = surface.create_entity({
		name = "burner-inserter",
		position = position,
		direction = inserter_direction(position[1], from_x),
		force = "player",
		raise_built = true, -- apm_lib starts tracking it
	})
	---@cast e -nil
	return e
end

---@param target LuaEntity
---@param dy number
---@return LuaRenderObject
local function label(target, dy)
	return rendering.draw_text({
		text = "",
		surface = surface,
		target = { entity = target, offset = { 0, dy } },
		color = { 1, 1, 1 },
		scale = 1.1,
		alignment = "center",
		use_rich_text = true,
	})
end

---@param inv LuaInventory?
---@param name string
---@return integer
local function count(inv, name)
	return inv and inv.get_item_count(name) or 0
end

---@param e LuaEntity
---@return string
local function status_name(e)
	local status = e.status
	for name, value in pairs(defines.entity_status) do
		if value == status then return name end
	end
	return tostring(status)
end

-- shown only when the scene cannot work
local warning = rendering.draw_text({
	text = "", surface = surface, target = { 0.5, -3.5 }, color = { 1, 0.3, 0.3 }, scale = 1.2, alignment = "center",
})

local function check_script()
	local text = ""
	local interface = remote.interfaces["apm_inserter"]
	if not interface then
		text = "apm_lib's script is not running in this simulation"
	elseif not interface["set_enabled"] then
		text = "apm_lib is older than 0.32.19 (apm_inserter.set_enabled is missing)"
	elseif not remote.call("apm_inserter", "is_enabled") then
		text = "apm_lib's inserter functions are off"
	end
	warning.text = text
end

-- the fixed part of the scene: chests and the machine
local input_chest = surface.create_entity({ name = "wooden-chest", position = INPUT_CHEST, force = "player" })
local output_chest = surface.create_entity({ name = "wooden-chest", position = OUTPUT_CHEST, force = "player" })
local machine = surface.create_entity({ name = "apm_assembling_machine_0", position = MACHINE, force = "player" })
---@cast input_chest -nil
---@cast output_chest -nil
---@cast machine -nil
machine.set_recipe("iron-gear-wheel")

storage.apm = {
	t = 0,
	input_chest = input_chest,
	output_chest = output_chest,
	machine = machine,
	machine_label = label(machine, -2.2),
	output_label = label(output_chest, -1.0),
}

--- Rebuilds the moving part of the scene: new inserters without fuel, an empty machine.
local function reset()
	local s = storage.apm

	for _, key in pairs({ "input_inserter", "output_inserter" }) do
		if s[key] and s[key].valid then s[key].destroy() end
	end

	s.input_chest.clear_items_inside()
	s.input_chest.insert({ name = "iron-plate", count = 200 })
	s.output_chest.clear_items_inside()

	s.machine.clear_items_inside()
	s.machine.set_recipe("iron-gear-wheel")
	if s.machine.burner then s.machine.burner.remaining_burning_fuel = 0 end
	s.machine.energy = 0

	s.input_inserter = build_inserter(INPUT_INSERTER, INPUT_CHEST[1])
	s.output_inserter = build_inserter(OUTPUT_INSERTER, MACHINE[1])

	s.input_label = label(s.input_inserter, -1.2)
	s.output_inserter_label = label(s.output_inserter, -1.2)
	-- what apm_lib sees: helps when an inserter does not refuel
	s.debug_label = rendering.draw_text({
		text = "",
		surface = surface,
		target = { entity = s.input_inserter, offset = { 0, 1.2 } },
		color = { 0.7, 0.7, 0.7 },
		scale = 0.8,
		alignment = "center",
	})

	if remote.interfaces["apm_inserter"] then
		remote.call("apm_inserter", "rescan")
	end
	enable()

	s.t = 0
end

reset()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15

	if s.t == COAL_DELAY then
		s.machine.get_fuel_inventory().insert({ name = "coal", count = COAL_COUNT })
	end

	if s.t >= LOOP then
		reset()
	end

	s.machine_label.text = "[item=coal] " .. count(s.machine.get_fuel_inventory(), "coal")
	s.output_label.text = "[item=iron-gear-wheel] " ..
			count(s.output_chest.get_inventory(defines.inventory.chest), "iron-gear-wheel")

	if s.input_inserter.valid and s.output_inserter.valid then
		s.input_label.text = "[item=coal] " .. count(s.input_inserter.get_fuel_inventory(), "coal")
		s.output_inserter_label.text = "[item=coal] " .. count(s.output_inserter.get_fuel_inventory(), "coal")

		local tracked = remote.interfaces["apm_inserter"] and remote.call("apm_inserter", "count_inserter") or 0
		s.debug_label.text = status_name(s.input_inserter) .. ", apm_lib tracks " .. tostring(tracked)
	end

	check_script()
end)
