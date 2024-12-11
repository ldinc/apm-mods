if not apm.lib.utils.technology then apm.lib.utils.technology = {} end
if not apm.lib.utils.technology.add then apm.lib.utils.technology.add = {} end

--- [technology.check_if_recipe_is_in_unlock]
---@param technology_name string
---@param recipe_name string
---@return boolean
function apm.lib.utils.technology.check_if_recipe_is_in_unlock(technology_name, recipe_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return false
	end

	if not apm.lib.utils.recipe.exist(recipe_name) then
		return false
	end

	if technology.effects then
		for _, entry in pairs(technology.effects) do
			if entry.type == 'unlock-recipe' and entry.recipe == recipe_name then
				return true
			end
		end
	end

	return false
end

--- [technology.add.recipe_for_unlock]
---@param technology_name string
---@param recipe_name string
function apm.lib.utils.technology.add.recipe_for_unlock(technology_name, recipe_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	if not apm.lib.utils.recipe.exist(recipe_name) then
		return
	end


	if apm.lib.utils.technology.check_if_recipe_is_in_unlock(technology_name, recipe_name) then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'add.recipe_for_unlock()',
				'recipe: "' ..
				tostring(recipe_name) .. '" is allready in effects for unlock in "' .. tostring(technology_name) .. '"'
			))
		end

		return
	end

	if technology and technology.effects then
		table.insert(technology.effects, { type = 'unlock-recipe', recipe = recipe_name })

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'add.recipe_for_unlock()',
				'added recipe: "' .. tostring(recipe_name) .. '" to "' .. tostring(technology_name) .. '" for unlock'
			))
		end
	end
end

--- [technology.remove.recipe_from_unlock]
---@param technology_name string
---@param recipe_name string
function apm.lib.utils.technology.remove.recipe_from_unlock(technology_name, recipe_name)
	local technology, ok = apm.lib.utils.technology.get.by_name(technology_name)

	if not ok then
		return
	end

	if not apm.lib.utils.recipe.exist(recipe_name) then
		return
	end

	if not apm.lib.utils.technology.check_if_recipe_is_in_unlock(technology_name, recipe_name) then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'remove.recipe_from_unlock()',
				'recipe: "' ..
				tostring(recipe_name) .. '" is not in effects for unlock at: "' .. tostring(technology_name) .. '"'
			))
		end

		return
	end

	if technology and technology.effects then
		for k, r in pairs(technology.effects) do
			if r.recipe == recipe_name then
				table.remove(technology.effects, k)

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'remove.recipe_from_unlock()',
						'removed recipe: "' ..
						tostring(recipe_name) .. '" in "' .. tostring(technology_name) .. '" for unlock'
					))
				end

				return
			end
		end
	end
end

-- Function -------------------------------------------------------------------
-- recipe_name: string of recipe name
-- tech_name: string of ignored technology
-- ----------------------------------------------------------------------------

--- [technology.remove.recipe_recursive]
---@param recipe_name string recipe name
---@param tech_name string? ignored technology
function apm.lib.utils.technology.remove.recipe_recursive(recipe_name, tech_name)
	if not apm.lib.utils.recipe.exist(recipe_name) then return end

	local technologies = data.raw.technology
	for technology_name, _ in pairs(technologies) do
		if technology_name ~= tech_name then
			if technologies[technology_name].effects ~= nil then
				for i, effect in pairs(technologies[technology_name].effects) do
					if effect.type == 'unlock-recipe' and effect.recipe == recipe_name then
						table.remove(data.raw.technology[technology_name].effects, i)
					end
				end
			end
		end
	end
end

--- [technology.force.recipe_for_unlock]
--- This function forces the unlocking of a recipe with a specific technology.
--- The recipe is removed from any other technology and deactivated.
---@param technology_name string
---@param recipe_name string
function apm.lib.utils.technology.force.recipe_for_unlock(technology_name, recipe_name)
	if not apm.lib.utils.technology.exist(technology_name) then
		return
	end

	if not apm.lib.utils.recipe.exist(recipe_name) then
		return
	end

	apm.lib.utils.technology.remove.recipe_recursive(recipe_name, technology_name)
	apm.lib.utils.technology.add.recipe_for_unlock(technology_name, recipe_name)
	apm.lib.utils.recipe.disable(recipe_name)
end
