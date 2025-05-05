apm.lib.utils.recipe.remove("colony-farming-arboriculture")

local recipe_name = "colony-farming-agriculture"

apm.lib.utils.recipe.ingredient.remove_all(recipe_name)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "water", 11500)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "apm_wet_mud", 30)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "apm_crushed_stone", 50)

local apm_power_overhaul_machine_frames = settings.startup["apm_power_overhaul_machine_frames"].value

recipe_name = "colony-greenhouse"

apm.lib.utils.recipe.ingredient.remove_all(recipe_name)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "electric-engine-unit", 25)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "refined-concrete", 50)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "small-lamp", 50)
apm.lib.utils.recipe.ingredient.mod(recipe_name, "processing-unit", 50)

if apm_power_overhaul_machine_frames then
	apm.lib.utils.recipe.ingredient.mod(recipe_name, "apm_machine_frame_advanced", 12)
end

local apm_power_compat_bob = settings.startup["apm_power_compat_bob"].value

if mods.bobplates  and apm_power_compat_bob then
	apm.lib.utils.recipe.ingredient.mod(recipe_name, "bob-glass", 100)
end
