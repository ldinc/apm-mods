apm.lib.utils.recipe.disable("kr-wind-turbine")
apm.lib.utils.recipe.disable("firearm-magazine")
apm.lib.utils.recipe.disable("apm_steam_science_pack")

apm.lib.utils.recipe.ingredient.remove_all("firearm-magazine")
apm.lib.utils.recipe.ingredient.mod("firearm-magazine", "iron-plate", 1)
apm.lib.utils.recipe.ingredient.mod("firearm-magazine", "apm_gun_powder", 2)

apm.lib.utils.recipe.ingredient.remove_all("kr-basic-tech-card")
apm.lib.utils.recipe.ingredient.mod("kr-basic-tech-card", "apm_industrial_science_pack", 5)

apm.lib.utils.recipe.ingredient.replace("kr-rifle-magazine", "coal", "apm_gun_powder", 2)
apm.lib.utils.recipe.ingredient.mod("shotgun-shell", "apm_gun_powder", 2)

apm.lib.utils.recipe.ingredient.replace_all(
	"kr-coke",
	"apm_coke"
)

apm.lib.utils.recipe.result.replace_all(
	"kr-coke",
	"apm_coke"
)

apm.lib.utils.recipe.remove("kr-coke")

apm.lib.utils.recipe.ingredient.mod("automation-science-pack", "apm_steam_science_pack", 2)

apm.lib.utils.recipe.set.hidden("kr-crusher", true)
