-- Tips and tricks simulation: charging and discharging stations.
-- Discharged batteries -> charging station -> charged batteries -> discharging station ->
-- discharged batteries. A small primary power source (2 MW) runs the inserters and part of the
-- charging station; the discharging station covers the rest, so its output is visible. The
-- labels count the chests and show the batteries burning in the discharging station. Refilled every 60 s.
-- Only vanilla behaviour, so no mod script is needed in the simulation.

game.simulation.camera_position = { -1.5, 0 }
game.forces.player.enable_all_recipes()

local surface = game.surfaces[1]

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

---@param name string
---@param position MapPosition
---@param direction defines.direction?
---@return LuaEntity
local function create(name, position, direction)
	local e = surface.create_entity({ name = name, position = position, direction = direction, force = "player" })
	---@cast e -nil
	return e
end

---@param target LuaEntity|MapPosition
---@param dy number
---@param color Color?
---@return LuaRenderObject
local function label(target, dy, color)
	local t = target
	if type(target) ~= "table" or target.object_name == "LuaEntity" then
		t = { entity = target, offset = { 0, dy } }
	end
	return rendering.draw_text({
		text = "",
		surface = surface,
		target = t,
		color = color or { 1, 1, 1 },
		scale = 1.1,
		alignment = "center",
		use_rich_text = true,
	})
end

---@param e LuaEntity
---@param name string
---@return integer
local function chest_count(e, name)
	return e.get_inventory(defines.inventory.chest).get_item_count(name)
end

local power = create("apm_simulation_power", { -1, -3 })
power.power_production = 2000000 / 60 -- 2 MW
power.electric_buffer_size = 2000000
for _, x in pairs({ -5.5, -1.5, 2.5 }) do
	create("small-electric-pole", { x, -1.5 })
end

local discharged = create("wooden-chest", { -7.5, 0.5 })
create("inserter", { -6.5, 0.5 }, inserter_direction(-6.5, -7.5))
local charger = create("apm_battery_charging_station", { -4.5, 0.5 }) -- 3x3: x from -6 to -3
charger.set_recipe("apm_charging_battery")
create("inserter", { -2.5, 0.5 }, inserter_direction(-2.5, -4.5))
local charged = create("wooden-chest", { -1.5, 0.5 })
create("inserter", { -0.5, 0.5 }, inserter_direction(-0.5, -1.5))
local discharger = create("apm_battery_discharging_station", { 1.5, 0.5 }) -- 3x3: x from 0 to 3
create("inserter", { 3.5, 0.5 }, inserter_direction(3.5, 1.5))
local returned = create("wooden-chest", { 4.5, 0.5 })

storage.apm = {
	t = 0,
	discharged = discharged,
	charged = charged,
	returned = returned,
	discharger = discharger,
	labels = { label(discharged, -1.0), label(charged, -1.0), label(returned, -1.0), label(discharger, -2.2) },
}

local function reset()
	local s = storage.apm
	for _, chest in pairs({ s.discharged, s.charged, s.returned }) do chest.clear_items_inside() end
	s.discharged.insert({ name = "apm_discharged_battery", count = 60 })
	s.t = 0
end

reset()

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15
	if s.t >= 60 * 60 then reset() end

	s.labels[1].text = "[item=apm_discharged_battery] " .. chest_count(s.discharged, "apm_discharged_battery")
	s.labels[2].text = "[item=battery] " .. chest_count(s.charged, "battery")
	s.labels[3].text = "[item=apm_discharged_battery] " .. chest_count(s.returned, "apm_discharged_battery")
	-- energy_generated_last_tick exists only for generators, not for burner generators:
	-- show the batteries in the fuel slot and the energy left in the one that is burning
	local burner = s.discharger.burner
	local burning = burner and burner.remaining_burning_fuel or 0
	s.labels[4].text = string.format("[item=battery] %d  burning: %.1f MJ",
		s.discharger.get_fuel_inventory().get_item_count("battery"), burning / 1000000)
end)
