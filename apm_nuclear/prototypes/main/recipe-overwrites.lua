require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_nuclear/prototypes/main/recipe-overwrites.lua"

APM_LOG_HEADER(self)

apm.lib.utils.recipe.ingredient.mod("uranium-rounds-magazine", "uranium-238", 0)
apm.lib.utils.recipe.ingredient.mod("uranium-rounds-magazine", "apm_depleted_uranium_ingots", 5)

apm.lib.utils.recipe.ingredient.mod("uranium-cannon-shell", "uranium-238", 0)
apm.lib.utils.recipe.ingredient.mod("uranium-cannon-shell", "apm_depleted_uranium_ingots", 5)

apm.lib.utils.recipe.ingredient.mod("explosive-uranium-cannon-shell", "uranium-238", 0)
apm.lib.utils.recipe.ingredient.mod("explosive-uranium-cannon-shell", "apm_depleted_uranium_ingots", 5)

apm.lib.utils.recipe.ingredient.mod("nuclear-fuel", "uranium-235", 0)
apm.lib.utils.recipe.ingredient.mod("nuclear-fuel", "rocket-fuel", 0)
apm.lib.utils.recipe.ingredient.mod("nuclear-fuel", "apm_oxide_pellet_pu239", 2)
apm.lib.utils.recipe.ingredient.mod("nuclear-fuel", "rocket-fuel", 10)
apm.lib.utils.recipe.result.mod("nuclear-fuel", "nuclear-fuel", 10)

apm.lib.utils.recipe.ingredient.mod("atomic-bomb", "uranium-235", 0)
apm.lib.utils.recipe.ingredient.mod("atomic-bomb", "apm_oxide_pellet_pu239", 15)

apm.lib.utils.recipe.ingredient.mod("fusion-reactor-equipment", "apm_depleted_uranium_ingots", 5)
--apm.lib.utils.recipe.ingredient.mod("fusion-reactor-equipment", "water", 5, 50)

apm.lib.utils.recipe.ingredient.mod("satellite", "apm_rtg_radioisotope_thermoelectric_generator", 25)

apm.lib.utils.recipe.remove("nuclear-fuel-reprocessing")
apm.lib.utils.recipe.remove("uranium-fuel-cell")
apm.lib.utils.recipe.remove("uranium-processing")
apm.lib.utils.recipe.remove("kovarex-enrichment-process")

if mods["bobplates"] then
	local name = "apm_fuel_cell_neptunium_recovery_stage_b"
	local recipe = data.raw.recipe[name]
	table.insert(recipe.results, { type = "item", name = "bob-fusion-catalyst", amount = 1 })

	local name = "apm_fuel_cell_thorium_recovery_stage_b"
	local recipe = data.raw.recipe[name]
	table.insert(recipe.results, { type = "item", name = "bob-fusion-catalyst", amount = 1 })

	local name = "apm_breeder_thorium_seperation_process_b"
	local recipe = data.raw.recipe[name]
	table.insert(recipe.results, { type = "item", name = "bob-fusion-catalyst", amount = 1 })

	local name = "apm_fuel_rod_uranium_recovery_stage_b"
	local recipe = data.raw.recipe[name]
	table.insert(recipe.results, { type = "item", name = "bob-fusion-catalyst", amount = 1 })
end

--- [space-age]
if mods["space-age"] then
	local recipe_name = "apm_nuclear_breeder"

	apm.lib.utils.recipe.ingredient.replace(recipe_name, "productivity-module-3", "productivity-module-2", 1)
end
