local blueprint =
"0eNqVk91uwjAMhd/F1ymifzD6KhOq0tZApMbpkpQNob77nBaqTWUaXFWJne+c4yZXqNoeO6vIQ3EFVRtyULxfwakjyTbskdQIBchOl9I51FWr6FhqWZ8UYbmGQYCiBr+giIe9ACSvvMKJMi4uJfW6QssN4l+agM44BhgK2gEar3IBFyjSVc5SFmvV3QlO4RlLZbn5Xik/etmyJneQsZojDGLhI5l9KDoo4lJUn9D5pXp+E89G8Xt36dB79u1Cl0Vt2EXPtdajxaZUHjWXDrJ1KGDanuZxU60N+xL86cPYk/VagDbNmMpHLcrRyTxUMZ8LSSNj8dmzybAfHsRP5/hVbwltpMihZZPL/Jtf+RvFQ56qcfIAnD0P3r0Ezmew84YwOjBe1rjEvk3QR6k3z5uL05fcbWfyp+FfQX9dpjj7gQ1vJVyU4Gd+ggLOfFXGE/km2WW7Xb5N8zTbJsPwDUF8ONc="

local demo_surface = game.surfaces[1]

game.simulation.camera_position = { 0, 0.05 }

local force = game.forces.player

force.recipes["apm_sieve_iron"].enabled = true

demo_surface.create_entities_from_blueprint_string {
	string = blueprint,
	position = { 0, 0 },
}


---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
---@return LuaInventory?
local function get_a_fuel_inventory(pickup_target, drop_target)
	if pickup_target ~= nil then
		local pickup_inventory = pickup_target.get_fuel_inventory()

		if pickup_inventory ~= nil then
			return pickup_inventory
		end
	end
	if drop_target ~= nil then
		local drop_inventory = drop_target.get_fuel_inventory()

		return drop_inventory
	end

	return nil
end

--- transfer the item stack on leeching or fuel chaining
--- it decisions which method we need (filter inserter need a bypass methode, otherwise he can not pickup fuel for them self)
---@param inserter LuaEntity
---@param inventory LuaInventory
---@param item_stack ItemStackDefinition
---@return boolean
local function transfer_leeching(inserter, inventory, item_stack)
	local held_stack = inserter.held_stack
	if not held_stack.valid_for_read then
		if inserter.filter_slot_count == 0 then
			if held_stack.transfer_stack(item_stack) then
				inventory.remove(item_stack)

				return true
			end
		else
			held_stack.set_stack(item_stack)
			inventory.remove(item_stack)

			return true
		end
	end

	return false
end

--- can pickup 'fuel' for it self from pickup_target or drop_target
---@param entity LuaEntity
---@param pickup_target LuaEntity?
---@param drop_target LuaEntity?
---@return boolean
local function burner_inserter_leech(entity, pickup_target, drop_target)
	local target_inventory = get_a_fuel_inventory(pickup_target, drop_target)
	if not target_inventory then return false end


	local target_inventory_contents = target_inventory.get_contents()

	for _, item in ipairs(target_inventory_contents) do
		if item.count >= 2 then
			local stack_size = math.min(item.count - 1, 5)
			---@type ItemStackDefinition
			local item_stack = { name = item.name, count = stack_size, quality = item.quality }

			return transfer_leeching(entity, target_inventory, item_stack)
		end

		return false
	end
end

local function calc_item_count(_, __)
	return 1
end

--- chain fuel from pickup_target to drop_target
---@param t_object QueueItem
---@param pickup_inventory LuaInventory
---@param drop_target LuaEntity
---@return boolean
local function inserter_chain_fuel(t_object, pickup_inventory, drop_target)
	local pickup_inventory_contents = pickup_inventory.get_contents()

	for _, item in ipairs(pickup_inventory_contents) do
		local stack_size = calc_item_count((item.count), t_object)
		local item_stack = { name = item.name, count = stack_size }

		if drop_target.can_insert(item_stack) then
			return transfer_leeching(t_object.entity, pickup_inventory, item_stack)
		end

		return false
	end
end
-- game.simulation.camera_alt_info = true

local entities = demo_surface.find_entities({ { -10, -10 }, { 10, 10 } })

---@type LuaEntity[]
local inserters = {}

---@type LuaEntity[]
local assemblers = {}

for _, entity in ipairs(entities) do
	if entity.name == "burner-inserter" then
		table.insert(inserters, entity)
	end
	if entity.type == "assembling-machine" then
		table.insert(assemblers, entity)
	end
end

script.on_nth_tick(1, function(event)
	for _, inserter in ipairs(inserters) do
		if
				inserter.pickup_target
				and
				inserter.pickup_target.burner
				and
				inserter.drop_target
				and
				inserter.drop_target.burner
				and
				inserter.drop_target.burner.inventory.is_empty()
		then
			inserter_chain_fuel(
				{ id = 1, err = 0, entity = inserter },
				inserter.pickup_target.burner.inventory,
				inserter.drop_target
			)
		end
	end
end)

script.on_nth_tick(60 * 15, function(event)
	for _, assembler in ipairs(assemblers) do
		assembler.burner.remaining_burning_fuel = 0
		assembler.burner.burnt_result_inventory.clear()
		assembler.burner.inventory.clear()

		assembler.highlight_box_blink_interval = 100

		---@type data.HighlightBoxEntityPrototype
		local box = assembler.surface.create_entity {
			name = "highlight-box",
			position = assembler.position,
		}


		box.text
	end
end)


-- data.raw["recipe"]["apm_sieve_iron"].enabled = true

-- demo_surface.daytime = 0.5 -- Set fixed daylight
