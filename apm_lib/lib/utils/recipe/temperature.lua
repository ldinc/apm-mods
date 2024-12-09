if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.ingredient then apm.lib.utils.recipe.ingredient = {} end

--- [ingredient_mod_temperature]
---@param recipe_name string
---@param base data.IngredientPrototype[]
---@param ingredient_name string
---@param condition_temperature number
---@param target_temperature number
---@return any
local function ingredient_mod_temperature(
		recipe_name,
		base,
		ingredient_name,
		condition_temperature,
		target_temperature
)
	for _, ingredient in pairs(base) do
		if ingredient[1] == ingredient_name or ingredient.name == ingredient_name then
			if ingredient.temperature == condition_temperature then
				ingredient.temperature = target_temperature

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'ingredient.mod_temperature()',
						tostring(recipe_name) ..
						'" change temperature for: "' ..
						tostring(ingredient_name) ..
						'" from: ' .. tostring(condition_temperature) .. ' to: ' .. tostring(target_temperature)
					))
				end
			end
		end
	end
	return base
end

--- [recipe.ingredient.mod_temperature]
---@param recipe_name string
---@param ingredient_name string
---@param condition_temperature number
---@param target_temperature number
function apm.lib.utils.recipe.ingredient.mod_temperature(
		recipe_name,
		ingredient_name,
		condition_temperature,
		target_temperature
)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if not apm.lib.utils.item.exist(ingredient_name) then
		return
	end

	local type_name = apm.lib.utils.item.get_type(ingredient_name)

	if type_name ~= 'fluid' then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'ingredient.mod_temperature()',
				'ingredient: "' .. tostring(ingredient_name) .. '" is not a fluid.'
			))
		end

		return
	end


	if recipe.ingredients then
		recipe.ingredients = ingredient_mod_temperature(
			recipe_name,
			recipe.ingredients,
			ingredient_name,
			condition_temperature,
			target_temperature
		)
	end
end

--- [result_mod_temperature]
---@param recipe_name string
---@param base data.IngredientPrototype[]
---@param ingredient_name string
---@param condition_temperature number
---@param target_temperature number
---@return any
local function result_mod_temperature(
		recipe_name,
		base,
		ingredient_name,
		condition_temperature,
		target_temperature
)
	for _, ingredient in pairs(base) do
		if ingredient[1] == ingredient_name or ingredient.name == ingredient_name then
			if ingredient.temperature == condition_temperature then
				ingredient.temperature = target_temperature

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'result.mod_temperature()',
						tostring(recipe_name) ..
						'" change temperature for: "' ..
						tostring(ingredient_name) ..
						'" from: ' .. tostring(condition_temperature) .. ' to: ' .. tostring(target_temperature)
					))
				end
			end
		end
	end
	return base
end

--- [recipe.result.mod_temperature]
---@param recipe_name string
---@param result_name string
---@param condition_temperature number
---@param target_temperature number
function apm.lib.utils.recipe.result.mod_temperature(recipe_name, result_name, condition_temperature, target_temperature)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if not apm.lib.utils.item.exist(result_name) then
		return
	end

	local type_name = apm.lib.utils.item.get_type(result_name)

	if type_name ~= 'fluid' then
		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING(
				'result.mod_temperature()', 'result: "' .. tostring(result_name) .. '" is not a fluid.'
			))
		end

		return
	end

	if recipe.results then
		recipe.results = result_mod_temperature(
			recipe_name,
			recipe.results,
			result_name,
			condition_temperature,
			target_temperature
		)
	end
end
