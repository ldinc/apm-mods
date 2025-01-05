local recipies = {
	["apm_steel_0"] = {
		energy = 35 - 20,
		icons = {},
	},
	["apm_steel_1"] = {
		energy = 30 - 20,
		icons = {},
	}
}

local steel = "steel-plate"
local hot_steel = "hot-steel-plate"

for recipe, config in pairs(recipies) do
	apm.lib.utils.recipe.result.replace(recipe, steel, hot_steel)
	apm.lib.utils.recipe.energy_required.mod(recipe, config.energy)

	local recipe_proto, ok = apm.lib.utils.recipe.get.by_name(recipe)

	if ok then
		apm.lib.utils.icon.layer.replace(recipe_proto, 1, '__hot-metals__/graphics/icons/hot-steel-plate.png', 64, 0.5)
	end
end
