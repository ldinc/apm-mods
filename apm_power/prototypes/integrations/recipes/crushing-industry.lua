if not apm.lib.features.power.compat.safthelamb then
	return
end

apm.lib.utils.recipe.ingredient.replace_all(
	"crushed-coal",
	"apm_coal_crushed"
)

apm.lib.utils.recipe.result.replace_all(
	"crushed-coal",
	"apm_coal_crushed"
)

apm.lib.utils.recipe.ingredient.replace_all(
	"electric-crusher",
	"apm_crusher_machine_2"
)

apm.lib.utils.recipe.result.replace_all(
	"electric-crusher",
	"apm_crusher_machine_2"
)

apm.lib.utils.recipe.remove("crushed-coal")

apm.lib.utils.recipe.remove("burner-crusher")
apm.lib.utils.recipe.remove("electric-crusher")
