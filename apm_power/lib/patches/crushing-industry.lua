require('__apm_lib_ldinc__.lib.utils.prototypes')
require('__apm_lib_ldinc__.lib.features')
require('__apm_lib_ldinc__.lib.log')

require('lib.features.compat')

return function()
	if not apm.lib.features.power.compat.safthelamb then
		return
	end

	local original = "crushed-coal"
	local replacement = "apm_coal_crushed"

	local ok = apm.lib.utils.prototypes.item.exists(original)

	if not ok then
		return
	end

	for _, surface in pairs(game.surfaces) do
		--- @type EntitySearchFilters
		local filter = {
			has_item_inside = original,
		}

		local entities = surface.find_entities_filtered(filter)

		for _, entity in pairs(entities) do
			local count = entity.get_item_count(original)
			local missing = count

			while missing > 0 do
				local removed = entity.remove_item(original)

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						"migration for [crushing-industry]",
						entity.name .. ": from " .. tostring(missing) .. " removed " .. tostring(removed)
					))
				end

				missing = entity.get_item_count(original)
			end

			entity.insert({ name = replacement, count = count })

			if APM_CAN_LOG_INFO then
				log(
					APM_MSG_INFO(
						"migration for [crushing-industry]",
						entity.name .. ":" .. tostring(count)
					))
			end
		end
	end

	local update = function(from, to)
		for _, surface in pairs(game.surfaces) do
			--- @type EntitySearchFilters
			local filter = {
				type = "furnace",
				name = from,
			}

			local entities = surface.find_entities_filtered(filter)

			for _, entity in pairs(entities) do
				local old_position = { x = entity.position.x, y = entity.position.y }
				local old_force = entity.force

				local ok = entity.destroy()

				if not ok then
					log(APM_MSG_ERROR("migration for [crushing-industry]", "failed to remove " .. from))
				else
					local new_entity = surface.create_entity {
						name = to,
						position = old_position,
						raise_built = true,
						force = old_force,
					}

					if not new_entity then
						log(APM_MSG_ERROR("migration for [crushing-industry]", "failed to place new " .. to))
					end
				end
			end
		end
	end

	local burner = "burner-crusher"
	local electric = "electric-crusher"

	ok = apm.lib.utils.prototypes.item.exists(burner)

	if not ok then
		return
	end

	ok = apm.lib.utils.prototypes.item.exists(electric)

	if not ok then
		return
	end

	update(burner, "apm_crusher_machine_0")
	update(electric, "apm_crusher_machine_2")
end
