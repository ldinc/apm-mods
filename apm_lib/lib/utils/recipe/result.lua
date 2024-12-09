if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.has then apm.lib.utils.recipe.has = {} end

--- [has_result]
---@param base data.ProductPrototype[]
---@param result_name string
---@return boolean
local function has_result(base, result_name)
	for _, result in pairs(base) do
		if result[1] == result_name or result.name == result_name then
			return true
		end
	end

	return false
end

--- [recipe.has.result]
---@param recipe_name string
---@param result_name string
---@return boolean
function apm.lib.utils.recipe.has.result(recipe_name, result_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return false
	end

	if not apm.lib.utils.item.exist(result_name) then
		return false
	end

	if recipe.results then
		if has_result(recipe.results, result_name) then return true end
	end

	return false
end

--- [recipe.result.count]
---@param recipe_name string
---@return number?
function apm.lib.utils.recipe.result.count(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return nil
	end

	if recipe.results then
		return #recipe.results
	end

	return nil
end

--- [recipe.result.get_first_result]
---@param recipe_name string
---@return string?
function apm.lib.utils.recipe.result.get_first_result(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return nil
	end

	if recipe.results then
		for _, result in pairs(recipe.results) do
			return result.name
		end
	end

	return nil
end

--- [recipe.result.replace]
---@param recipe_name string
---@param result_old string
---@param result_new string
---@param amount_multi number?
function apm.lib.utils.recipe.result.replace(recipe_name, result_old, result_new, amount_multi)
	if not apm.lib.utils.recipe.exist(recipe_name) then
		return
	end

	if not apm.lib.utils.item.exist(result_old) then
		return
	end

	if not apm.lib.utils.item.exist(result_new) then
		return
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'result.replace()',
			'trying to replace result in: "' ..
			tostring(recipe_name) .. '": "' .. tostring(result_old) .. '" -> "' .. tostring(result_new) .. '"'
		))
	end

	local recipe = data.raw.recipe[recipe_name]
	local type_name = apm.lib.utils.item.get_type(result_new)

	if not amount_multi then
		amount_multi = 1
	end

	-- simple recipe (results)
	if recipe.results ~= nil and recipe.normal == nil and recipe.expensive == nil then
		for k, v in pairs(recipe.results) do
			if v[1] == result_old or v.name == result_old then
				recipe.results[k].type = type_name
				recipe.results[k].name = result_new

				if recipe.results[k].amount then
					recipe.results[k].amount = recipe.results[k].amount * amount_multi
				else
					recipe.results[k].amount = amount_multi
				end

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'result.replace()',
						'in (simple.results): "' ..
						tostring(recipe_name) ..
						'" result: "' .. tostring(result_old) .. '" -> "' .. tostring(result_new) .. '"'
					))
				end

				apm.lib.utils.recipe.set.main_product(recipe_name, result_old, result_new)
			end
		end
	end
end

-- Function -------------------------------------------------------------------
-- replace 'ingredient_old' with 'ingredient_new' in all recipes
--
-- ----------------------------------------------------------------------------

--- [recipe.result.replace_all]
---@param result_old string
---@param result_new string
function apm.lib.utils.recipe.result.replace_all(result_old, result_new)
	if not apm.lib.utils.item.exist(result_old) then
		return
	end

	if not apm.lib.utils.item.exist(result_new) then
		return
	end

	for recipe, _ in pairs(data.raw.recipe) do
		if apm.lib.utils.recipe.has.result(recipe, result_old) then
			apm.lib.utils.recipe.result.replace(recipe, result_old, result_new)
		end
	end
end

--- [recipe.result.add_with_probability]
---@param recipe_name string
---@param result_name string
---@param result_amount_min number?
---@param result_amount_max number?
---@param probability number?
function apm.lib.utils.recipe.result.add_with_probability(
		recipe_name,
		result_name,
		result_amount_min,
		result_amount_max,
		probability
)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return nil
	end

	if not apm.lib.utils.item.exist(result_name) then return end

	local type_name = apm.lib.utils.item.get_type(result_name)

	-- simple recipe (results)
	if recipe.results then
		table.insert(
			recipe.results,
			---@type data.ProductPrototype
			{
				type = type_name,
				name = result_name,
				amount_min = result_amount_min,
				amount_max = result_amount_max,
				probability = probability
			}
		)

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'result.add_with_probability()',
				'in (simple.results): "' ..
				tostring(recipe_name) ..
				'" add: "' .. tostring(result_name) .. '"  with probability: "' .. tostring(probability) .. '"'
			))
		end
	end

	apm.lib.utils.recipe.add_mainproduct_if_needed(recipe_name)
	--check_for_completness_of_the_recipe(recipe_name)
end

--- [check_for_probability]
---@param base_dn data.ProductPrototype
---@param result_amount number?
local function check_for_probability(base_dn, result_amount)
	if base_dn.probability and result_amount >= 1 then
		base_dn.probability = nil
		base_dn.amount_min = nil
		base_dn.amount_max = nil
	end
end

--- [recipe.result.mod]
---@param recipe_name string
---@param result_name string
---@param result_amount number?
function apm.lib.utils.recipe.result.mod(recipe_name, result_name, result_amount)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if not apm.lib.utils.item.exist(result_name) then
		return
	end

	local type_name = apm.lib.utils.item.get_type(result_name)


	-- simple recipe (results)
	if recipe.results then
		local seen_result = false
		for k, v in pairs(recipe.results) do
			if v[1] == result_name or v.name == result_name then
				seen_result = true

				if result_amount == 0 then
					if recipe.main_product == result_name then
						recipe.main_product = nil
					end

					table.remove(recipe.results, k)

					if APM_CAN_LOG_INFO then
						log(APM_MSG_INFO(
							'result.mod()',
							'in (simple.results): "' ..
							tostring(recipe_name) .. '" remove result: "' .. tostring(result_name) .. '"'
						))
					end
				else
					check_for_probability(recipe.results[k], result_amount)

					recipe.results[k].amount = result_amount

					if APM_CAN_LOG_INFO then
						log(APM_MSG_INFO(
							'result.mod()',
							'in (simple.results): "' ..
							tostring(recipe_name) ..
							'" change result: "' .. tostring(result_name) .. '" -> "' .. tostring(result_amount) .. '"'
						))
					end
				end
			end
		end
		if seen_result ~= true then
			table.insert(recipe.results, { type = type_name, name = result_name, amount = result_amount })

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'result.mod()',
					'in (simple.results): "' ..
					tostring(recipe_name) ..
					'" add result: "' .. tostring(result_name) .. '" -> "' .. tostring(result_amount) .. '"'
				))
			end
		end
	end

	apm.lib.utils.recipe.add_mainproduct_if_needed(recipe_name)
end

--- [recipe.result.remove_all]
---@param result_name string
function apm.lib.utils.recipe.result.remove_all(result_name)
	if not apm.lib.utils.item.exist(result_name) then
		return
	end

	for _, recipe in pairs(data.raw.recipe) do
		if apm.lib.utils.recipe.has.result(recipe.name, result_name) then
			apm.lib.utils.recipe.result.mod(recipe.name, result_name, 0)
		end
	end
end
