if not apm.lib.utils then apm.lib.utils = {} end
if not apm.lib.utils.patch then apm.lib.utils.patch = {} end
if not apm.lib.utils.patch.entity then apm.lib.utils.patch.entity = {} end

require('__apm_lib_ldinc__.lib.log')

--- all items in the entity's inventories, per quality
---@param entity LuaEntity
---@return {name: string, count: integer, quality: string}[]
local function collect_contents(entity)
	local items = {}
	for index = 1, entity.get_max_inventory_index() do
		local inventory = entity.get_inventory(index --[[@as defines.inventory]])
		if inventory and inventory.valid then
			for _, item in pairs(inventory.get_contents()) do
				items[#items + 1] = { name = item.name, count = item.count, quality = item.quality }
			end
		end
	end
	return items
end

---@param surface LuaSurface
---@param position MapPosition
---@param force LuaForce
---@param stack ItemStackDefinition
local function spill(surface, position, force, stack)
	surface.spill_item_stack({ position = position, stack = stack, enable_looted = true, force = force, allow_belts = false })
end

--- Replace entities by another entity, keeping direction, quality and inventory contents.
--- If the new entity can't be placed, its item and the old contents are spilled on the ground.
---@param tag string
---@param old_entity_name string
---@param old_entity_filter EntitySearchFilters?
---@param new_entity_name string
function apm.lib.utils.patch.entity.replace(tag, old_entity_name, old_entity_filter, new_entity_name)
	local new_prototype = prototypes.entity[new_entity_name]
	if not new_prototype then return end
	local new_item = new_prototype.items_to_place_this and new_prototype.items_to_place_this[1]

	for _, surface in pairs(game.surfaces) do
		local filter = old_entity_filter or { name = old_entity_name }
		local entities = surface.find_entities_filtered(filter)

		if #entities > 0 and APM_CAN_LOG_INFO then
			log(APM_MSG_INFO("patching [" .. tag .. "]", "replace (" .. old_entity_name .. ") -> (" .. new_entity_name .. ")"))
		end

		for _, entity in pairs(entities) do
			if entity.valid then
				local position = { x = entity.position.x, y = entity.position.y }
				local force = entity.force
				local direction = entity.direction
				local quality = entity.quality.name
				local contents = collect_contents(entity)

				if not entity.destroy() then
					log(APM_MSG_ERROR("patching [" .. tag .. "]", "failed to remove old entity (" .. old_entity_name .. ")"))
				else
					local new_entity = surface.create_entity({
						name = new_entity_name,
						position = position,
						direction = direction,
						quality = quality,
						force = force,
						raise_built = true,
					})

					if not new_entity then
						log(APM_MSG_ERROR("patching [" .. tag .. "]", "failed to place new entity (" .. new_entity_name .. "), spilled its item"))
						if new_item then
							spill(surface, position, force, { name = new_item.name, count = new_item.count, quality = quality })
						end
					end

					for _, item in pairs(contents) do
						local inserted = new_entity and new_entity.valid and new_entity.insert(item) or 0
						if inserted < item.count then
							spill(surface, position, force, { name = item.name, count = item.count - inserted, quality = item.quality })
						end
					end
				end
			end
		end
	end
end
