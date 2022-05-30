if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.beacon = function ()
    local recipe = 'beacon-3'
    -- apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'beacon-2', 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'beacon', 2)
end