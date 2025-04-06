if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.get then apm.lib.utils.recipe.get = {} end

--- [recipe.exist]
---@param recipe_name string
---@return boolean
function apm.lib.utils.recipe.exist(recipe_name)
	if data.raw.recipe[recipe_name] then
		return true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'recipe: "' .. tostring(recipe_name) .. '" doesnt exist.'))
	end

	return false
end

--- [recipe.get.by_name]
---@param recipe_name string
---@return data.RecipePrototype
---@return boolean
function apm.lib.utils.recipe.get.by_name(recipe_name)
	local recipe = data.raw["recipe"][recipe_name]

	if recipe then
		return recipe, true
	end

	if APM_CAN_LOG_WARN then
		log(APM_MSG_WARNING('exist()', 'recipe: "' .. tostring(recipe_name) .. '" doesnt exist.'))
	end

	return {}, false
end
