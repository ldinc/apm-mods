if not apm.lib.utils.recipe then apm.lib.utils.recipe = {} end
if not apm.lib.utils.recipe.has then apm.lib.utils.recipe.has = {} end
if not apm.lib.utils.recipe.ingredient.get then apm.lib.utils.recipe.ingredient.get = {} end

--- [has_ingredient]
---@param base data.IngredientPrototype[]
---@param ingredient_name string
---@return boolean
local function has_ingredient(base, ingredient_name)
	for _, ingredient in pairs(base) do
		if ingredient[1] == ingredient_name or ingredient.name == ingredient_name then
			return true
		end
	end

	return false
end

--- [recipe.has.ingredient]
---@param recipe_name string
---@param ingredient_name string
---@return boolean
function apm.lib.utils.recipe.has.ingredient(recipe_name, ingredient_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return false
	end

	if not apm.lib.utils.item.exist(ingredient_name) then
		return false
	end

	if recipe.ingredients then
		if has_ingredient(recipe.ingredients, ingredient_name) then return true end
	end

	return false
end

--- [recipe.has.ingredient]
---@param recipe data.RecipePrototype
---@param ingredient_name string
---@return boolean
function apm.lib.utils.recipe.has.ingredient_by_ref(recipe, ingredient_name)
	if not apm.lib.utils.item.exist(ingredient_name) then
		return false
	end

	if recipe.ingredients then
		if has_ingredient(recipe.ingredients, ingredient_name) then return true end
	end

	return false
end

--- [recipe.ingredient.remove_all]
---@param recipe_name string
function apm.lib.utils.recipe.ingredient.remove_all(recipe_name)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	if recipe.ingredients then
		recipe.ingredients = {}
	end
end

--- [add_ingredient]
---@param base_dn any
---@param type_name any
---@param ingredient_name any
---@param ingredient_amount any
local function add_ingredient(base_dn, type_name, ingredient_name, ingredient_amount)
	if not ingredient_amount or ingredient_amount == 0 then
		return
	end

	table.insert(base_dn, { type = type_name, name = ingredient_name, amount = ingredient_amount })
end

--- [convert_ingredients]
---@param ingredients data.IngredientPrototype[]
---@return data.IngredientPrototype[]
local function convert_ingredients(ingredients)
	---@type data.IngredientPrototype[]
	local t_new = {}

	for _, v in pairs(ingredients) do
		local i_name
		local i_type
		local i_amount

		if v.name == nil then
			i_name = v[1]
			i_type = apm.lib.utils.item.get_type(i_name)
			i_amount = v[2]

			table.insert(t_new, { type = i_type, name = i_name, amount = i_amount })
		else
			table.insert(t_new, v)
		end
	end

	return t_new
end

--- [ingredient_mod]
---@param recipe_name string
---@param base data.IngredientPrototype[]
---@param ingredient_name string
---@param ingredient_amount number
---@return data.IngredientPrototype[]
local function ingredient_mod(recipe_name, base, ingredient_name, ingredient_amount)
	local ingredients_convert = convert_ingredients(base)
	base = ingredients_convert
	local type_name = apm.lib.utils.item.get_type(ingredient_name)

	local amount = ingredient_amount


	local seen = false
	for k, v in pairs(base) do
		if v.name == ingredient_name then
			seen = true
			if amount == 0 then
				table.remove(base, k)

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'ingredient.mod()',
						'removed from recipe: "' .. tostring(recipe_name) .. '" -> "' .. tostring(ingredient_name) .. '"'
					))
				end
			else
				base[k].amount = amount

				if APM_CAN_LOG_INFO then
					log(APM_MSG_INFO(
						'ingredient.mod()',
						'recipe: "' ..
						tostring(recipe_name) ..
						'" -> "' .. tostring(ingredient_name) .. '" set amount to: ' .. tostring(amount)
					))
				end
			end
		end
	end
	if seen ~= true then
		add_ingredient(base, type_name, ingredient_name, amount)

		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'ingredient.mod()',
				'add to recipe: "' ..
				tostring(recipe_name) .. '" -> "' .. tostring(ingredient_name) .. '" with amount: ' .. tostring(amount)
			))
		end
	end

	return base
end

--- [recipe.ingredient.mod_by_ref]
---@param recipe data.RecipePrototype
---@param ingredient_name string
---@param ingredient_amount number
function apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, ingredient_name, ingredient_amount)
	if not apm.lib.utils.item.exist(ingredient_name) then return end

	-- simple recipe
	if recipe.ingredients then
		recipe.ingredients = ingredient_mod(recipe.name, recipe.ingredients, ingredient_name, ingredient_amount)
	end
end

--- [recipe.ingredient.mod]
---@param recipe_name string
---@param ingredient_name string
---@param ingredient_amount number
function apm.lib.utils.recipe.ingredient.mod(recipe_name, ingredient_name, ingredient_amount)
	local recipe, ok = apm.lib.utils.recipe.get.by_name(recipe_name)

	if not ok then
		return
	end

	apm.lib.utils.recipe.ingredient.mod_by_ref(recipe, ingredient_name, ingredient_amount)
end

--- [replace_ingredient]
---@param recipe_name string
---@param base data.IngredientPrototype[]
---@param ingredient_old string
---@param ingredient_new string
---@param amount_multi number?
---@return data.IngredientPrototype[]
local function replace_ingredient(recipe_name, base, ingredient_old, ingredient_new, amount_multi)
	local type_name_old = apm.lib.utils.item.get_type(ingredient_old)
	local type_name_new = apm.lib.utils.item.get_type(ingredient_new)
	local ingredients_convert = convert_ingredients(base)

	base = ingredients_convert

	local already_has_ingredient_new = has_ingredient(base, ingredient_new)
	local ingredient_old_key
	local ingredient_new_key
	local replaced = false
	local base_amount = 1

	if not amount_multi then
		amount_multi = 1
	end

	if type_name_old == 'item' and type_name_new == 'fluid' then
		amount_multi = amount_multi * 10
	elseif type_name_old == 'fluid' and type_name_new == 'item' then
		amount_multi = amount_multi / 10
	end

	for k, v in pairs(base) do
		if v.name == ingredient_old then
			ingredient_old_key = k
			replaced = true
		end

		if v.name == ingredient_old then
			ingredient_new_key = k
		end
	end

	if not type_name_new then
		type_name_new = "item"

		if APM_CAN_LOG_WARN then
			log(APM_MSG_WARNING("replace_ingredient()", "invalid type for replace, was used default \"item\""))
		end
	end

	if not already_has_ingredient_new and ingredient_old_key then
		base[ingredient_old_key].name = ingredient_new
		base[ingredient_old_key].type = type_name_new
		if base[ingredient_old_key].amount then
			base[ingredient_old_key].amount = base[ingredient_old_key].amount * amount_multi
		else
			base[ingredient_old_key].amount = base_amount * amount_multi
		end
	end

	if already_has_ingredient_new and ingredient_old_key and ingredient_new_key then
		if base[ingredient_old_key].amount and base[ingredient_new_key].amount then
			base[ingredient_new_key].amount = base[ingredient_new_key].amount +
					(base[ingredient_old_key].amount * amount_multi)
		else
			base[ingredient_new_key].amount = 1 + (base_amount * amount_multi)
		end
		table.remove(base, ingredient_old_key)
	end

	if replaced then
		if APM_CAN_LOG_INFO then
			log(APM_MSG_INFO(
				'ingredient.replace()',
				tostring(recipe_name) ..
				'" ingredient: "' .. tostring(ingredient_old) .. '" -> "' .. tostring(ingredient_new) .. '"'
			))
		end
	end

	return base
end

--- [recipe.ingredient.replace]
---@param recipe_name string
---@param ingredient_old string
---@param ingredient_new string
---@param amount_multi number?
function apm.lib.utils.recipe.ingredient.replace(recipe_name, ingredient_old, ingredient_new, amount_multi)
	if not apm.lib.utils.recipe.exist(recipe_name) then
		return
	end

	if not apm.lib.utils.item.exist(ingredient_old) then
		return
	end

	if not apm.lib.utils.recipe.has.ingredient(recipe_name, ingredient_old) then
		return
	end

	if not apm.lib.utils.item.exist(ingredient_new) then
		return
	end

	if APM_CAN_LOG_INFO then
		log(APM_MSG_INFO(
			'ingredient.replace()',
			'trying to replace ingredient in: "' ..
			tostring(recipe_name) .. '": "' .. tostring(ingredient_old) .. '" -> "' .. tostring(ingredient_new) .. '"'
		))
	end

	local recipe = data.raw.recipe[recipe_name]

	-- simple recipe
	if recipe.ingredients then
		recipe.ingredients = replace_ingredient(
			recipe_name,
			recipe.ingredients,
			ingredient_old,
			ingredient_new,
			amount_multi
		)
	end
end

-- Function -------------------------------------------------------------------
-- replace 'ingredient_old' with 'ingredient_new' in all recipes
--
-- ----------------------------------------------------------------------------

--- [recipe.ingredient.replace_all]
---@param ingredient_old string
---@param ingredient_new string
function apm.lib.utils.recipe.ingredient.replace_all(ingredient_old, ingredient_new)
	if not apm.lib.utils.item.exist(ingredient_old) then return end
	if not apm.lib.utils.item.exist(ingredient_new) then return end

	for recipe, _ in pairs(data.raw.recipe) do
		apm.lib.utils.recipe.ingredient.replace(recipe, ingredient_old, ingredient_new)
	end
end

--- [recipe.ingredient.get_count_by_ref]
---@param recipe data.RecipePrototype
---@param ingredient_name string
---@return integer
---@return boolean
function apm.lib.utils.recipe.ingredient.get.count_by_ref(recipe, ingredient_name)
	for _, ingredient in ipairs(recipe.ingredients) do
		if ingredient and ingredient.name == ingredient_name then
			return ingredient.amount, true
		end
	end

	return 0, false
end