if not rampant_heavy_wall then rampant_heavy_wall = {} end
if not rampant_heavy_wall.lib then rampant_heavy_wall.lib = {} end
if not rampant_heavy_wall.lib.utils then rampant_heavy_wall.lib.utils = {} end

---@param str string?
---@return data.IngredientPrototype[]?
function rampant_heavy_wall.lib.utils.create_ingredients_from_string(str)
	if not string or string == "" then
		return nil
	end

	local items = {}

	for token in str:gmatch("%S+") do
		local name, amount = token:match("^([%a_][%w%-_]+)=(%d+)$")

		if name and amount then
			items[#items + 1] = {
				type = "item",
				name = name,
				amount = tonumber(amount)
			}
		end
	end

	return #items > 0 and items or nil
end
