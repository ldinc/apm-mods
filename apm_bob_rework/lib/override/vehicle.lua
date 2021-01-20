if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildOverdriveMotor = function (recipe, tier, k)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 15*k)

end

local update = function ()
    buildOverdriveMotor('vehicle-motor', apm.bob_rework.lib.tier.steel, 1)
    buildOverdriveMotor('vehicle-engine', apm.bob_rework.lib.tier.titanium, 2)
end

update()