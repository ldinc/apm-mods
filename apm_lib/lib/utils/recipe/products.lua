if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.has then apm.lib.utils.recipe.has = {} end

--- [recipe.has.main_product]
---@param recipe_name string
---@return boolean
function apm.lib.utils.recipe.has.main_product(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return false
	end

	if recipe.main_product then return true end

	return false
end

--- [recipe.set.always_show_products]
---@param recipe_name string
---@param bool boolean
---@param category_condition string?
function apm.lib.utils.recipe.set.always_show_products(recipe_name, bool, category_condition)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if category_condition and recipe.category ~= category_condition then
		return
	end

	recipe.always_show_products = bool

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('set.always_show_products()', 'set true for recipe: "' .. tostring(recipe_name) .. '"'))
	end
end

--- [recipe.get.main_product]
---@param recipe_name string
---@return string?
function apm.lib.utils.recipe.get.main_product(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return nil
	end

	if recipe.main_product then
		return recipe.main_product
	end

	return nil
end

--- [recipe.set.main_product]
---@param recipe_name string
---@param result_old string
---@param result_new string
---@param force boolean?
function apm.lib.utils.recipe.set.main_product(recipe_name, result_old, result_new, force)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	local done = false

	if not force then
		if not apm.lib.utils.recipe.has.main_product(recipe_name) then
			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'set.main_product()',
					'can not set main_product for: "' ..
					tostring(recipe_name) .. '" to: "' .. tostring(result_new) .. '" recipe does not have this property'
				))
			end

			return
		end
	end

	if recipe.main_product == result_old then
		recipe.main_product = result_new
		done = true
	end


	if done then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'set.main_product()',
				'set main_product for: "' ..
				tostring(recipe_name) .. '" from: "' .. tostring(result_old) .. '" to "' .. tostring(result_new) .. '"'
			))
		end
	end
end

-- Function -------------------------------------------------------------------
--
-- force_mainproduct: bool ignores the present of an icon and allways set the mainproduct
-- ----------------------------------------------------------------------------

--- [recipe.add_mainproduct_if_needed]
---@param recipe_name string
---@param force_mainproduct boolean?
function apm.lib.utils.recipe.add_mainproduct_if_needed(recipe_name, force_mainproduct)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if apm.lib.utils.recipe.has.main_product(recipe_name) then
		return
	end

	if not force_mainproduct and (recipe.icon or recipe.icons) then
		return
	end

	if recipe.results then
		for _, result in pairs(recipe.results) do
			local main_product = result.name

			recipe.main_product = main_product

			if APM_CAN_LOG_INFO then
				log(APM_MSG_INFO(
					'add_mainproduct_if_needed()',
					'in (simple.results): "' ..
					tostring(recipe_name) .. '" set main product to: "' .. tostring(main_product) .. '"'
				))
			end

			break
		end
	end
end
