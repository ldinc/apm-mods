-- A storage tank with water drains into a sinkhole, a storage tank with steam into a small
-- sinkhole; the labels show the fluid left in the tanks. The tanks are refilled every 60 s.
-- Only vanilla behaviour and the sinkhole prototypes, so no mod script is needed.

game.simulation.camera_position = { -1.5, 3.5 }

local surface = game.surfaces[1]

local DIRECTION_VECTOR = {
	[defines.direction.north] = { 0, -1 },
	[defines.direction.east] = { 1, 0 },
	[defines.direction.south] = { 0, 1 },
	[defines.direction.west] = { -1, 0 },
}

---@param name string
---@param position MapPosition
---@param direction defines.direction?
---@return LuaEntity
local function create(name, position, direction)
	local e = surface.create_entity({ name = name, position = position, direction = direction, force = "player" })
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


-- storage tank (north): connection at its tile (1, 1) facing east -> pipe at tank + (2, 1)
-- sinkhole: connection at its tile (-1, 0) facing west -> pipe at sinkhole + (-2, 0)
local water_tank = create("storage-tank", { -4.5, 0.5 })
create("pipe", { -2.5, 1.5 })
create("pipe", { -1.5, 1.5 })
local sinkhole = create("apm_sinkhole", { 0.5, 1.5 })

-- small sinkhole: its connection faces north -> pipe above it
local steam_tank = create("storage-tank", { -4.5, 5.5 })
create("pipe", { -2.5, 6.5 })
create("pipe", { -1.5, 6.5 })
local small = create("apm_sinkhole_small", { -1.5, 7.5 })

storage.apm = {
	t = 0,
	water_tank = water_tank,
	steam_tank = steam_tank,
	water_label = label(water_tank, -2.0),
	steam_label = label(steam_tank, -2.0),
	sinkhole = sinkhole,
	small = small,
}

local function reset()
	local s = storage.apm
	s.water_tank.clear_fluid_inside()
	s.water_tank.insert_fluid({ name = "water", amount = 5000 })
	s.steam_tank.clear_fluid_inside()
	s.steam_tank.insert_fluid({ name = "steam", amount = 5000, temperature = 165 })
	s.t = 0
end

reset()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15
	if s.t >= 60 * 60 then reset() end
	s.water_label.text = "[fluid=water] " .. math.floor(s.water_tank.get_fluid_count("water"))
	s.steam_label.text = "[fluid=steam] " .. math.floor(s.steam_tank.get_fluid_count("steam"))
end)
