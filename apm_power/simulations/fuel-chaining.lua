-- Tips and tricks simulation: fuel chaining.
-- A chain of burner machines stands without fuel (no-fuel icons). After 5 s the inserter at
-- the coal chest is built; the first machine gets coal, and the inserters of the chain pass
-- it on from machine to machine.
-- Runs as a console command inside the simulation (no require). The behaviour comes from
-- apm_lib's own runtime script, loaded through `mods = { "apm_lib_ldinc" }` in the tip; this
-- file only builds the scene, adds labels with the slot contents (fuel and ash are not
-- visible otherwise) and replays the scene in a loop.

game.simulation.camera_position = { -1, 0.5 }

local surface = game.surfaces[1]

-- A simulation's script cannot change its map settings, so the inserter functions are
-- switched on through apm_lib's remote interface.
local function enable()
	if remote.interfaces["apm_inserter"] and remote.interfaces["apm_inserter"]["set_enabled"] then
		remote.call("apm_inserter", "set_enabled", true)
	end
end

---@param x number
---@param fuel integer?
---@param plates integer?
---@return LuaEntity
local function machine(x, fuel, plates)
	local m = surface.create_entity({ name = "apm_assembling_machine_0", position = { x, 0.5 }, force = "player" })
	---@cast m -nil
	m.set_recipe("iron-gear-wheel")
	if (plates or 100) > 0 then
		m.insert({ name = "iron-plate", count = plates or 100 })
	end
	if fuel and fuel > 0 then
		m.get_fuel_inventory().insert({ name = "coal", count = fuel })
	end
	return m
end

--- Direction of an inserter at x whose pickup is on the side of from_x. An inserter's
--- direction points to its pickup side (vanilla tips: an inserter moving items from west to
--- east has direction west).
---@param x number
---@param from_x number
---@return defines.direction
local function inserter_direction(x, from_x)
	if from_x < x then
		return defines.direction.west
	end

	return defines.direction.east
end

---@param name string
---@param x number
---@param y number
---@param from_x number
---@return LuaEntity
local function inserter(name, x, y, from_x)
	local e = surface.create_entity({
		name = name, position = { x, y }, direction = inserter_direction(x, from_x), force = "player",
	})
	---@cast e -nil
	return e
end

--- A ghost that the scene "builds" later with revive (like a construction robot would).
---@param x number
---@param from_x number
---@return LuaEntity
local function inserter_ghost(x, from_x)
	local g = surface.create_entity({
		name = "entity-ghost",
		inner_name = "burner-inserter",
		position = { x, 0.5 },
		direction = inserter_direction(x, from_x),
		force = "player",
	})
	---@cast g -nil
	return g
end

---@param ghost LuaEntity?
local function build(ghost)
	if ghost and ghost.valid then
		ghost.revive({ raise_revive = true })
	end
	-- make sure apm_lib tracks the new inserter
	if remote.interfaces["apm_inserter"] then
		remote.call("apm_inserter", "rescan")
		enable()
	end
end

---@param target LuaEntity
---@param dy number?
---@return LuaRenderObject
local function label(target, dy)
	return rendering.draw_text({
		text = "",
		surface = surface,
		target = { entity = target, offset = { 0, dy or -2.2 } },
		color = { 1, 1, 1 },
		scale = 1.1,
		alignment = "center",
		use_rich_text = true,
	})
end

-- shown only when the scene cannot work
local warning = rendering.draw_text({
	text = "", surface = surface, target = { 0, -4 }, color = { 1, 0.3, 0.3 }, scale = 1.2, alignment = "center",
})

local function check_script()
	local text = ""
	if not remote.interfaces["apm_inserter"] then
		text = "apm_lib's script is not running in this simulation"
	elseif remote.interfaces["apm_inserter"]["is_enabled"] and not remote.call("apm_inserter", "is_enabled") then
		text = "apm_lib's inserter functions are off"
	end
	warning.text = text
end

---@param inv LuaInventory?
---@param name string
---@return integer
local function count(inv, name)
	return inv and inv.get_item_count(name) or 0
end

---@param e LuaEntity
local function empty_fuel(e)
	e.get_fuel_inventory().clear()
	if e.burner then e.burner.remaining_burning_fuel = 0 end
	e.energy = 0
end

local chest = surface.create_entity({ name = "wooden-chest", position = { -6.5, 0.5 }, force = "player" })
---@cast chest -nil
local a, b, c = machine(-3.5), machine(0.5), machine(4.5)
inserter("burner-inserter", -1.5, 0.5, a.position.x)
inserter("burner-inserter", 2.5, 0.5, b.position.x)

storage.apm = {
	t = 0,
	chest = chest,
	machines = { a, b, c },
	labels = { label(a), label(b), label(c) },
}

local function reset()
	local s = storage.apm

	for _, e in pairs(surface.find_entities_filtered({ position = { -5.5, 0.5 }, radius = 0.4 })) do
		if e.name == "burner-inserter" or e.name == "entity-ghost" then e.destroy() end
	end

	s.chest.clear_items_inside()
	s.chest.insert({ name = "coal", count = 50 })

	for _, m in pairs(s.machines) do
		empty_fuel(m)
		m.get_output_inventory().clear()
		m.burner.burnt_result_inventory.clear()
		m.insert({ name = "iron-plate", count = 100 })
	end

	s.ghost = inserter_ghost(-5.5, s.chest.position.x)
	s.t = 0
end

reset()
if remote.interfaces["apm_inserter"] then remote.call("apm_inserter", "rescan") end

enable()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15

	if s.t == 60 * 5 then build(s.ghost) end
	if s.t >= 60 * 45 then reset() end

	for i, m in pairs(s.machines) do
		s.labels[i].text = "[item=coal] " .. count(m.get_fuel_inventory(), "coal")
	end
	check_script()
end)
