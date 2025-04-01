if not apm.lib.utils then apm.lib.utils = {} end
if not apm.lib.utils.patch then apm.lib.utils.patch = {} end
if not apm.lib.utils.patch.entity then apm.lib.utils.patch.entity = {} end

require('__apm_lib_ldinc__.lib.log')

---@param tag string
---@param old_entity_name string
---@param old_entity_filter EntitySearchFilters?
---@param new_entity_name string
function apm.lib.utils.patch.entity.replace(tag, old_entity_name, old_entity_filter, new_entity_name)
	for _, surface in pairs(game.surfaces) do
		if not old_entity_filter then
			--- TODO: add type ssearch by name?
			filter = {
				name = old_entity_name,
			}
		else
			filter = old_entity_filter
		end

		local entities = surface.find_entities_filtered(filter)

		if #entities > 0 and APM_CAN_LOG_INFO then
			log(
				APM_MSG_INFO(
					"patching [" .. tag .. "]", "replace (" .. old_entity_name .. ") -> (" .. new_entity_name .. ")"
				)
			)
		end

		for _, entity in pairs(entities) do
			local old_position = { x = entity.position.x, y = entity.position.y }
			local old_force = entity.force

			local ok = entity.destroy()

			if not ok then
				log(
					APM_MSG_ERROR(
						"patching [" .. tag .. "]", "failed to remove old entity (" .. old_entity_name .. ")"
					)
				)
			else
				local new_entity = surface.create_entity {
					name = new_entity_name,
					position = old_position,
					raise_built = true,
					force = old_force,
				}

				if not new_entity then
					log(
						APM_MSG_ERROR(
							"patching [" .. tag .. "]", "failed to place new entity(" .. new_entity_name .. ")"
						)
					)
				end
			end
		end
	end
end
