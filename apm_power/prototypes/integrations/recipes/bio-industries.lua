apm.lib.utils.recipe.remove("bi-stone-crusher")
apm.lib.utils.recipe.remove("bi-charcoal-1")
apm.lib.utils.recipe.remove("bi-charcoal-2")
apm.lib.utils.recipe.remove("bi-ash-1")
apm.lib.utils.recipe.remove("bi-ash-2")

local replace_all = function(old, new)
	apm.lib.utils.recipe.ingredient.replace_all(old, new)
	apm.lib.utils.recipe.result.replace_all(old, new)
end

replace_all("stone-crushed", "apm_crushed_stone")
replace_all("bi-ash", "apm_generic_ash")
replace_all("bi-charcoal", "apm_charcoal")
replace_all("wood-charcoal", "apm_charcoal")

apm.lib.utils.recipe.remove("bi-wood-fuel-brick")
apm.lib.utils.recipe.remove("bi-cokery")
apm.lib.utils.recipe.remove("bi-resin-pulp")
apm.lib.utils.recipe.remove("bi-resin-wood")
apm.lib.utils.recipe.remove("bi-woodpulp")

apm.lib.utils.recipe.remove("bi-bio-greenhouse")
apm.lib.utils.recipe.remove("apm_tree_seeds")
apm.lib.utils.recipe.remove("apm_fertiliser_1")
apm.lib.utils.recipe.remove("apm_fertiliser_2")

replace_all("resin", "apm_resin")
replace_all("bi-woodpulp", "apm_wood_pellets")
replace_all("bi-pellet-coke", "apm_coke_brick")
replace_all("pellet-coke", "apm_coke_brick")

replace_all("bi-bio-greenhouse", "apm_greenhouse_2")

apm.lib.utils.recipe.ingredient.replace("bi-rail-wood", "wood", "apm_treated_wood_planks")

-- apm.lib.utils.recipe.ingredient.replace("bi_recipe_wood_pipe", "wood", "apm_treated_wood_planks")

apm.lib.utils.recipe.ingredient.mod("bi-wood-pipe", "apm_sealing_rings", 1)

apm.lib.utils.recipe.ingredient.replace("bi-wooden-pole-big", "wood", "apm_treated_wood_planks")
apm.lib.utils.recipe.ingredient.replace("bi-wooden-pole-huge", "wood", "apm_treated_wood_planks")

-- apm.lib.utils.recipe.result.mod("bi-seed-1", "bi-seed", 40 / 5)
-- apm.lib.utils.recipe.result.mod("bi-seed-2", "bi-seed", 50 / 5)
-- apm.lib.utils.recipe.result.mod("bi-seed-3", "bi-seed", 60 / 5)
-- apm.lib.utils.recipe.result.mod("bi-seed-4", "bi-seed", 80 / 5)

-- apm.lib.utils.recipe.ingredient.mod("bi-seedling-1", "bi-seed", 20 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi-seedling-2", "bi-seed", 20 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi-seedling-3", "bi-seed", 20 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi-seedling-1", "bi-seed", 20 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi_recipe_seed_bomb_basic", "bi-seed", 400 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi_recipe_seed_bomb_standard", "bi-seed", 400 / 5)
-- apm.lib.utils.recipe.ingredient.mod("bi_recipe_seed_bomb_advanced", "bi-seed", 400 / 5)

apm.lib.utils.recipe.ingredient.replace("bi-plastic-1", "wood", "apm_wood_pellets", 2)

replace_all("wood-bricks", "apm_wood_briquette")

-- apm.lib.utils.recipe.ingredient.mod("bi_recipe_rail_wood", "apm_crushed_stone", 0)
-- apm.lib.utils.recipe.ingredient.mod("rail", "apm_crushed_stone", 0)
apm.lib.utils.recipe.ingredient.replace("bi_recipe_mineralized_sulfuric_waste", "wood-charcoal", "apm_charcoal")

apm.lib.utils.recipe.remove("apm_wood_0")
apm.lib.utils.recipe.remove("apm_wood_1")
apm.lib.utils.recipe.remove("apm_wood_2")
