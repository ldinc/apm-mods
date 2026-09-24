-- Tips and tricks simulation: crusher and sieve.
-- Top: stone -> crusher -> crushed stone. Bottom: dry mud and iron sieves -> sieve (steam from
-- an infinity pipe) -> iron ore. The labels count the chest contents. The scene is refilled
-- every 60 s. Only vanilla behaviour, so no mod script is needed in the simulation.

game.simulation.camera_position = { -1.5, 0.5 }
game.simulation.camera_alt_info = true

game.forces.player.enable_all_recipes()

local surface = game.surfaces[1]

local DIRECTION_VECTOR = {
	[defines.direction.north] = { 0, -1 },
	[defines.direction.east] = { 1, 0 },
	[defines.direction.south] = { 0, 1 },
	[defines.direction.west] = { -1, 0 },
}

--- Direction for an inserter at x that picks up on the side of from_x. Read from the
--- prototype's pickup vector (for direction north), because it differs between inserters:
--- vanilla inserters pick up to the north, the APM steam inserters to the west.
---@param name string
---@param x number
---@param from_x number
---@return defines.direction
local function inserter_direction(name, x, from_x)
	local v = prototypes.entity[name].inserter_pickup_position
	local vx, vy = v.x or v[1], v.y or v[2]
	for _, dir in pairs({ defines.direction.north, defines.direction.east, defines.direction.south, defines.direction.west }) do
		local px, py = vx, vy
		for _ = 1, dir / 4 do px, py = -py, px end -- quarter turns clockwise
		if math.abs(py) < 0.5 and (px < 0) == (from_x < x) then
			return dir
		end
	end
	return defines.direction.north
end

---@param name string
---@param position MapPosition
---@param direction defines.direction?
---@return LuaEntity
local function create(name, position, direction)
	local e = surface.create_entity({ name = name, position = position, direction = direction, force = "player" })
	---@cast e -nil
	return e
end

---@param name string
---@param x number
---@param y number
---@param from_x number
---@return LuaEntity
local function create_inserter(name, x, y, from_x)
	return create(name, { x, y }, inserter_direction(name, x, from_x))
end

--- Tiles next to the pipe connections of an entity that faces north, read from its prototype
--- (fluid boxes and the fluid energy source).
---@param entity LuaEntity
---@return MapPosition[]
local function connection_targets(entity)
	local proto = entity.prototype
	local boxes = {}
	for _, box in pairs(proto.fluidbox_prototypes or {}) do boxes[#boxes + 1] = box end
	if proto.fluid_energy_source_prototype then
		boxes[#boxes + 1] = proto.fluid_energy_source_prototype.fluid_box
	end

	local targets = {}
	for _, box in pairs(boxes) do
		for _, connection in pairs(box.pipe_connections or {}) do
			local p = connection.positions and connection.positions[1]
			local v = DIRECTION_VECTOR[connection.direction]
			if p and v and connection.connection_type == "normal" then
				local px, py = p.x or p[1], p.y or p[2]
				targets[#targets + 1] = {
					x = math.floor(entity.position.x + px + v[1]) + 0.5,
					y = math.floor(entity.position.y + py + v[2]) + 0.5,
				}
			end
		end
	end
	return targets
end

--- Places an infinity pipe on the first free tile next to a pipe connection of the entity
--- and fills it with the fluid.
---@param entity LuaEntity
---@param fluid string
---@param temperature number?
---@return LuaEntity? pipe
local function feed_fluid(entity, fluid, temperature)
	for _, target in pairs(connection_targets(entity)) do
		if #surface.find_entities_filtered({ position = target }) == 0 then
			local pipe = surface.create_entity({ name = "infinity-pipe", position = target, force = "player" })
			if pipe then
				pipe.set_infinity_pipe_filter({ name = fluid, percentage = 1, mode = "at-least", temperature = temperature })
				return pipe
			end
		end
	end
	return nil
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

---@param text string
---@param position MapPosition
local function warning(text, position)
	rendering.draw_text({
		text = text, surface = surface, target = position, color = { 1, 0.3, 0.3 }, scale = 1.2, alignment = "center",
	})
end

---@param e LuaEntity
---@param name string
---@return integer
local function chest_count(e, name)
	return e.get_inventory(defines.inventory.chest).get_item_count(name)
end

---@param y number
---@param machine_name string
---@param recipe string
---@return LuaEntity input_chest, LuaEntity machine, LuaEntity output_chest
local function row(y, machine_name, recipe)
	local input_chest = create("wooden-chest", { -4.5, y })
	local input_inserter = create_inserter("burner-inserter", -3.5, y, -4.5)
	local machine = create(machine_name, { -1.5, y }) -- 3x3: x from -3 to 0
	machine.set_recipe(recipe)
	local output_inserter = create_inserter("burner-inserter", 0.5, y, -1.5)
	local output_chest = create("wooden-chest", { 1.5, y })
	for _, ins in pairs({ input_inserter, output_inserter }) do
		ins.get_fuel_inventory().insert({ name = "coal", count = 10 })
	end
	return input_chest, machine, output_chest
end

local stone_chest, crusher, crushed_chest = row(-1.5, "apm_crusher_machine_0", "apm_crushed_stone")
local mud_chest, sieve, ore_chest = row(2.5, "apm_sieve_0", "apm_dry_mud_sifting_iron")

crusher.get_fuel_inventory().insert({ name = "coal", count = 20 })
if not feed_fluid(sieve, "steam", 165) then
	warning("no free steam connection found on the sieve", { -1.5, 5.5 })
end

storage.apm = {
	t = 0,
	stone_chest = stone_chest,
	crushed_chest = crushed_chest,
	mud_chest = mud_chest,
	ore_chest = ore_chest,
	labels = {
		label(stone_chest, -1.0), label(crushed_chest, -1.0), label(mud_chest, -1.0), label(ore_chest, -1.0),
	},
}

local function reset()
	local s = storage.apm
	for _, chest in pairs({ s.stone_chest, s.crushed_chest, s.mud_chest, s.ore_chest }) do
		chest.clear_items_inside()
	end
	s.stone_chest.insert({ name = "stone", count = 100 })
	s.mud_chest.insert({ name = "apm_dry_mud", count = 200 })
	s.mud_chest.insert({ name = "apm_sieve_iron", count = 10 })
	s.t = 0
end

reset()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15
	if s.t >= 60 * 60 then reset() end

	s.labels[1].text = "[item=stone] " .. chest_count(s.stone_chest, "stone")
	s.labels[2].text = "[item=apm_crushed_stone] " .. chest_count(s.crushed_chest, "apm_crushed_stone")
	s.labels[3].text = "[item=apm_dry_mud] " .. chest_count(s.mud_chest, "apm_dry_mud") ..
			"  [item=apm_sieve_iron] " .. chest_count(s.mud_chest, "apm_sieve_iron")
	s.labels[4].text = "[item=iron-ore] " .. chest_count(s.ore_chest, "iron-ore") ..
			"  [item=apm_sieve_iron] " .. chest_count(s.ore_chest, "apm_sieve_iron")
end)
