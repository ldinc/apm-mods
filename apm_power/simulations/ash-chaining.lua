-- Tips and tricks simulation: ash moves along a chain of burner machines.
-- The first machine holds 250 ash, the second none. After 3 s the inserter between them is
-- built: the whole batch moves into the second machine's burnt-result slot at once. At the
-- end of the chain, two burner inserters with filters sort the gears and the ash into two chests.
-- Runs as a console command inside the simulation (no require). The behaviour comes from
-- apm_lib's own runtime script, loaded through `mods = { "apm_lib_ldinc" }` in the tip; this
-- file only builds the scene, adds labels with the slot contents (fuel and ash are not
-- visible otherwise) and replays the scene in a loop.

game.simulation.camera_position = { 0.5, 0.5 }

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
---@plates integer?
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


local a = machine(-3.5, 20, 0)
local b = machine(0.5, 20)

local gears_chest = surface.create_entity({ name = "wooden-chest", position = { 3.5, -0.5 }, force = "player" })
local ash_chest = surface.create_entity({ name = "wooden-chest", position = { 3.5, 1.5 }, force = "player" })
---@cast gears_chest -nil
---@cast ash_chest -nil

---@param y number
---@param item string
local function filter_inserter(y, item)
	local e = surface.create_entity({
		name = "burner-inserter",
		position = { 2.5, y },
		direction = inserter_direction(2.5, b.position.x),
		force = "player",
	})
	---@cast e -nil
	e.use_filters = true
	e.set_filter(1, item)
	return e
end

filter_inserter(-0.5, "iron-gear-wheel")
filter_inserter(1.5, "apm_generic_ash")

storage.apm = {
	t = 0,
	a = a,
	b = b,
	gears_chest = gears_chest,
	ash_chest = ash_chest,
	labels = { label(a), label(b), label(ash_chest, -1.0) },
}

local function reset()
	local s = storage.apm

	for _, e in pairs(surface.find_entities_filtered({ position = { -1.5, 0.5 }, radius = 0.4 })) do
		if e.name == "burner-inserter" or e.name == "entity-ghost" then e.destroy() end
	end

	s.gears_chest.clear_items_inside()
	s.ash_chest.clear_items_inside()

	for _, e in pairs({ s.a, s.b }) do
		e.get_output_inventory().clear()
		e.burner.burnt_result_inventory.clear()
		e.get_fuel_inventory().insert({ name = "coal", count = 5 })
	end

	s.b.insert({ name = "iron-plate", count = 100 })

	-- a batch of ash (a batch is 10% of the ash stack)
	s.a.burner.burnt_result_inventory.insert({ name = "apm_generic_ash", count = 250 })

	s.ghost = inserter_ghost(-1.5, s.a.position.x)
	s.t = 0
end

reset()
if remote.interfaces["apm_inserter"] then remote.call("apm_inserter", "rescan") end
enable()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15

	if s.t == 60 * 3 then build(s.ghost) end
	if s.t >= 60 * 60 then reset() end

	s.labels[1].text = "[item=apm_generic_ash] " .. count(s.a.burner.burnt_result_inventory, "apm_generic_ash")
	s.labels[2].text = "[item=apm_generic_ash] " .. count(s.b.burner.burnt_result_inventory, "apm_generic_ash")
	s.labels[3].text = "[item=apm_generic_ash] " ..
			count(s.ash_chest.get_inventory(defines.inventory.chest), "apm_generic_ash")
	check_script()
end)
