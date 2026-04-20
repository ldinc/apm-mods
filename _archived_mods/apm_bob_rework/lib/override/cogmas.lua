if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.cogmas = function()
    local recipe = 'cogmas-tree'

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'apm_tree_seeds', 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'small-lamp', 10)
end