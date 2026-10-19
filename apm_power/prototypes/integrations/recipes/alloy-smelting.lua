if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.recipe.ingredient.replace_all(
	"coke",
	"apm_coke"
)

apm.lib.utils.recipe.result.replace_all(
	"coke",
	"apm_coke"
)

apm.lib.utils.recipe.ingredient.replace_all("brick-kiln", "apm_coking_plant_0")
apm.lib.utils.recipe.ingredient.replace_all("electric-kiln", "apm_coking_plant_2")

apm.lib.utils.recipe.remove("coke")
apm.lib.utils.recipe.remove("brick-kiln")
apm.lib.utils.recipe.remove("electric-kiln")
apm.lib.utils.recipe.remove("coke-from-crushed-coal")
