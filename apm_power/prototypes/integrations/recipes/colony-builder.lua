apm.lib.utils.recipe.remove("colony-farming-arboriculture")

local recipe_name = "colony-farming-agriculture"

apm.lib.utils.recipe.ingredient.remove_all(recipe_name)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "water", 12000)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "apm_wet_mud", 200)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "apm_crushed_stone", 50)