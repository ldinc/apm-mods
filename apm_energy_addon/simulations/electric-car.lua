-- Tips and tricks simulation: an electric car burns charged batteries and returns discharged
-- ones. A test player drives the car in a circle; the label shows the batteries in the fuel
-- slot and the discharged batteries in the burnt-result slot. Refuelled every 60 s. Only
-- vanilla behaviour, so no mod script is needed in the simulation.

game.simulation.camera_position = { 0, 0 }

local surface = game.surfaces[1]

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

local car = create("apm_electric_car", { 0, 3 })
car.get_fuel_inventory().insert({ name = "battery", count = 3 })

local player = game.simulation.create_test_player({ name = "engineer" })
player.teleport({ 0, 1 })
car.set_driver(player)
game.simulation.camera_player = player
game.simulation.camera_zoom = 1.0

storage.apm = { t = 0, car = car, player = player, label = label(car, -2.0) }

local function refuel()
	local s = storage.apm
	s.car.get_burnt_result_inventory().clear()
	s.car.get_fuel_inventory().clear()
	s.car.get_fuel_inventory().insert({ name = "battery", count = 3 })
	s.t = 0
end

script.on_nth_tick(1, function(e)
	local s = storage.apm
	if s.player.valid then
		if e.tick < 120 then
			s.player.riding_state = {
				acceleration = defines.riding.acceleration.accelerating,
				direction = defines.riding.direction.left,
			}
		else
			s.player.riding_state = {
				acceleration = defines.riding.acceleration.nothing,
				direction = defines.riding.direction.left,
			}
		end
	end
end)

script.on_nth_tick(15, function()
	local s = storage.apm
	s.t = s.t + 15
	if s.t >= 60 * 60 then refuel() end
	s.label.text = "[item=battery] " .. s.car.get_fuel_inventory().get_item_count("battery") ..
			"  [item=apm_discharged_battery] " .. s.car.get_burnt_result_inventory().get_item_count("apm_discharged_battery")
end)
