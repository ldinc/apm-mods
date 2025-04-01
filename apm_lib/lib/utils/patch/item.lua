if not apm.lib.utils then apm.lib.utils = {} end
if not apm.lib.utils.patch then apm.lib.utils.patch = {} end
if not apm.lib.utils.patch.item then apm.lib.utils.patch.item = {} end

require('__apm_lib_ldinc__.lib.utils.prototypes')
require('__apm_lib_ldinc__.lib.log')

---@param tag string
---@param old_item_name string
---@param new_item_name string
function apm.lib.utils.patch.item.replace(tag, old_item_name, new_item_name)
	local ok = apm.lib.utils.prototypes.item.exists(old_item_name)

	if not ok then
		return
	end

	local replacement_valid = apm.lib.utils.prototypes.item.exists(new_item_name)

	for _, surface in pairs(game.surfaces) do
		--- @type EntitySearchFilters
		local filter = {
			has_item_inside = old_item_name,
		}

		local entities = surface.find_entities_filtered(filter)

		for _, entity in pairs(entities) do
			local count = entity.get_item_count(old_item_name)
			local missing = count

			while missing > 0 do
				local removed = entity.remove_item(old_item_name)

				if APM_CAN_LOG_INFO then
					log(
						APM_MSG_INFO(
							"patching [" .. tag .. "]",
							entity.name ..
							": remove " .. old_item_name .. " (" .. tostring(missing) .. ") -> (" .. tostring(removed) .. ")"
						))
				end

				missing = entity.get_item_count(old_item_name)
			end

			if replacement_valid then
				entity.insert({ name = new_item_name, count = count })
			end

			if APM_CAN_LOG_INFO then
				log(
					APM_MSG_INFO(
						"patching [" .. tag .. "]",
						entity.name ..
						": add " .. new_item_name .. " (" .. tostring(count) .. ")"
					))
			end
		end
	end
end
