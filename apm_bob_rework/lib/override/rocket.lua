if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local update = function ()
    local recipe = 'rocket-silo'
    local tier = apm.bob_rework.lib.tier.titanium
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 400)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)

end

update()