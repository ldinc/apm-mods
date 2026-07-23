if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end

--- [recipe.clone]
---@param recipe_name string
---@param recipe_name_new string
---@return data.RecipePrototype?
function apm.lib.utils.recipe.clone(recipe_name, recipe_name_new)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return nil
	end

	local new_recipe = table.deepcopy(recipe)

	new_recipe.name = recipe_name_new

	if not new_recipe.localised_name and (new_recipe.icon or new_recipe.icons) then
		new_recipe.localised_name = { "recipe-name." .. recipe_name }
	end

	data:extend({ new_recipe })

	return new_recipe
end

--- [recipe.remove]
---@param recipe_name string
function apm.lib.utils.recipe.remove(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	apm.lib.utils.technology.remove.recipe_recursive(recipe_name)

	recipe.hidden = true
	recipe.enabled = false
	recipe.hidden_in_factoriopedia = true
end

--- [recipe.disable]
---@param recipe_name string
function apm.lib.utils.recipe.disable(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	recipe.enabled = false
end

--- [recipe.enable]
---@param recipe_name string
function apm.lib.utils.recipe.enable(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	recipe.enabled = true
end

--- [recipe.category.create]
---@param category_name string
function apm.lib.utils.recipe.category.create(category_name)
	---@type data.RecipeCategory
	local recipe_category = {
		type = "recipe-category",
		name = category_name,
	}

	data:extend({ recipe_category })

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"category.add()", 'created category with name: "' .. tostring(category_name) .. '"'
		))
	end
end

--- [recipe.category.add] add  category for recipe
---@param recipe data.RecipePrototype
---@param category_name string
function apm.lib.utils.recipe.category.add(recipe, category_name)
	if not recipe.categories then
		-- recipes without explicit categories default to { "crafting" } on load
		recipe.categories = { "crafting", category_name }
	elseif #recipe.categories == 0 then
		recipe.categories = { category_name }
	else
		table.insert(recipe.categories, category_name)
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"category.add()",
			'category of: "' .. tostring(recipe.name) .. '" added: "' .. tostring(category_name) .. '"'
		))
	end
end

--- [recipe.category.change] set single category for recipe!
---@param recipe data.RecipePrototype
---@param category_name string
function apm.lib.utils.recipe.category.change(recipe, category_name)
	recipe.categories = { category_name }

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			"category.change()",
			'category of: "' .. tostring(recipe.name) .. '" to: "' .. tostring(category_name) .. '"'
		))
	end
end

--- [recipe.category.replace]
--- Replace one specific category in a recipe's category list, leaving other
--- categories intact. Returns true if at least one replacement was made.
---@param recipe data.RecipePrototype
---@param category_old string
---@param category_new string
---@return boolean
function apm.lib.utils.recipe.category.replace(recipe, category_old, category_new)
	if not recipe.categories then return false end

	local changed = false

	for i, c in ipairs(recipe.categories) do
		if c == category_old then
			recipe.categories[i] = category_new
			changed = true
		end
	end

	if changed and APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("category.replace()",
			'in "' .. tostring(recipe.name) .. '" replaced "' .. tostring(category_old) ..
			'" with "' .. tostring(category_new) .. '"'))
	end

	return changed
end

--- [recipe.category.overwrite_all]
---@param category_name_old string
---@param category_name_new string
function apm.lib.utils.recipe.category.overwrite_all(category_name_old, category_name_new)
	for _, recipe in pairs(data.raw.recipe) do
		apm.lib.utils.recipe.category.replace(recipe, category_name_old, category_name_new)
	end
end

--- [recipe.energy_required.mod]
---@param recipe_name any
---@param value any
function apm.lib.utils.recipe.energy_required.mod(recipe_name, value)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	local _value = value

	if recipe.ingredients then
		recipe.energy_required = _value

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				"energy_required.mod()",
				'for: "' .. tostring(recipe_name) .. '" (simple) to: "' .. tostring(value) .. '"'
			))
		end
	end
end

--- [recipe.overwrite.group]
---@param recipe_name string
---@param subgroup string
---@param order string?
function apm.lib.utils.recipe.overwrite.group(recipe_name, group, subgroup, order)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	recipe.subgroup = subgroup
	recipe.order = order

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO("overwrite.group()", 'item with name: "' .. tostring(recipe_name) .. '" changed.'))
	end
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.recipe.overwrite.localised_name(recipe_name, localised_name)
	if not apm.lib.utils.recipe.exist(recipe_name) then return end
	local recipe = data.raw.recipe[recipe_name]

	recipe.localised_name = localised_name
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function apm.lib.utils.recipe.overwrite.localised_description(recipe_name, localised_description)
	if not apm.lib.utils.item.exist(recipe_name) then return end
	local recipe = data.raw.recipe[recipe_name]

	recipe.localised_description = localised_description
end
