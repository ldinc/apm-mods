if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.set then apm.lib.utils.recipe.set = {} end

---@param recipe_name string
function apm.lib.utils.recipe.allow_productivity(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	recipe.allow_productivity = true
end

--- [recipe.set.always_show_made_in]
---@param recipe_name string
---@param bool boolean
---@param category_condition string?
function apm.lib.utils.recipe.set.always_show_made_in(recipe_name, bool, category_condition)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if category_condition and recipe.category ~= category_condition then
		return
	end

	recipe.always_show_made_in = bool

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO('set.always_show_made_in()', 'set true for recipe: "' .. tostring(recipe_name) .. '"'))
	end
end

--- [recipe.set.icons]
---@param recipe_name string
---@param icons any
function apm.lib.utils.recipe.set.icons(recipe_name, icons)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	apm.lib.utils.icon.set.icons(recipe, icons)
end

--- [recipe.set.icon]
---@param recipe_name string
---@param icon_path any
function apm.lib.utils.recipe.set.icon(recipe_name, icon_path)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if apm.lib.utils.recipe.has.main_product(recipe_name) then
		local main_product_name = apm.lib.utils.recipe.get.main_product(recipe_name)

		local main_product = data.raw.item(main_product_name) or data.raw.fluid(main_product_name)


		recipe.subgroup = main_product.subgroup
		recipe.order = main_product.order

		if recipe.main_product then
			recipe.main_product = nil
		end
	end

	if not recipe.icons then
		recipe.icon = icon_path
	else
		recipe.icons = { icon = icon_path }
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'set.icon()',
			'set icon for: "' .. tostring(recipe_name) .. '" to: "' .. tostring(icon_path) .. '"'
		))
	end
end

--- [recipe.set.hidden]
---@param recipe_name string
---@param bool boolean
function apm.lib.utils.recipe.set.hidden(recipe_name, bool)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	recipe.hidden = bool
	recipe.hidden_in_factoriopedia = bool

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'set.hidden()', 'set hidden for: "' .. tostring(recipe_name) .. '" to: "' .. tostring(bool)
		))
	end
end
