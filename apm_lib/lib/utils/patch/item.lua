if not apm.lib.utils then apm.lib.utils = {} end
if not apm.lib.utils.patch then apm.lib.utils.patch = {} end
if not apm.lib.utils.patch.item then apm.lib.utils.patch.item = {} end

require("__apm_lib_ldinc__.lib.utils.prototypes")
require("__apm_lib_ldinc__.lib.log")

---@param tag string
---@param entity LuaEntity
---@param inventory LuaInventory
---@param old_item_name string
---@param new_item_name string
---@param quality string
local function replace_in_inventory(tag, entity, inventory, old_item_name, new_item_name, quality)
	local old_item = { name = old_item_name, quality = quality }
	local count = inventory.get_item_count(old_item)
	if count <= 0 then return end

	local removed = inventory.remove({ name = old_item_name, quality = quality, count = count })
	if removed <= 0 then return end

	-- same inventory first (keeps fuel in the fuel slots), whatever does not fit is spilled next to the entity
	local inserted = inventory.insert({ name = new_item_name, quality = quality, count = removed })
	local left = removed - inserted
	if left > 0 then
		entity.surface.spill_item_stack({
			position = entity.position,
			stack = { name = new_item_name, quality = quality, count = left },
			enable_looted = true,
			force = entity.force,
			allow_belts = false,
		})
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("patching [" .. tag .. "]",
			entity.name .. ": " .. old_item_name .. " -> " .. new_item_name .. " (" .. quality .. "): " ..
			tostring(removed) .. (left > 0 and (", spilled " .. tostring(left)) or "")))
	end
end

--- Replace an item by another one in every entity inventory on every surface, per quality.
---@param tag string
---@param old_item_name string
---@param new_item_name string
function apm.lib.utils.patch.item.replace(tag, old_item_name, new_item_name)
	if not apm.lib.utils.prototypes.item.exists(old_item_name) then return end
	-- without a replacement the items would only be deleted
	if not apm.lib.utils.prototypes.item.exists(new_item_name) then return end

	for quality in pairs(prototypes.quality) do
		for _, surface in pairs(game.surfaces) do
			-- has_item_inside with a plain name only matches normal quality: search per quality
			local entities = surface.find_entities_filtered({
				has_item_inside = { name = old_item_name, quality = quality },
			})

			for _, entity in pairs(entities) do
				for index = 1, entity.get_max_inventory_index() do
					local inventory = entity.get_inventory(index --[[@as defines.inventory]])
					if inventory and inventory.valid then
						replace_in_inventory(tag, entity, inventory, old_item_name, new_item_name, quality)
					end
				end
			end
		end
	end
end
