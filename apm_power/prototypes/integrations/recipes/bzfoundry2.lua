-- use APM coke everywhere before the bzfoundry2 coke goes away
apm.lib.utils.recipe.ingredient.replace_all("coke", "apm_coke")
apm.lib.utils.recipe.result.replace_all("coke", "apm_coke")
apm.lib.utils.recipe.remove("coke")
