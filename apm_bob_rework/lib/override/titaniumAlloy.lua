if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

local update = function()
    local drop = apm.bob_rework.lib.entities.titaniumPlate
    local alloy = apm.bob_rework.lib.entities.titaniumAlloy

    local recipe = apm.bob_rework.lib.entities.titaniumBearingBall
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, drop, 0)

    recipe = apm.bob_rework.lib.entities.titaniumBearing
    apm.lib.utils.recipe.ingredient.mod(recipe, alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, drop, 0)
end

update()
