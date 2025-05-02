---@param category_id data.RecipeCategoryID
---@return boolean
function apm.lib.utils.recipe.category.exists(category_id)
	local category = data.raw["recipe-category"][category_id]

	return category ~= nil
end
