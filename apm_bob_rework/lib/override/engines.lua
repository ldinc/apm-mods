local product = require "lib.entities.product"
local category= require "lib.entities.category"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')


local buildSimpleEngine = function (tier, gearWheelNeeded)
    local recipe = tier.engineUnit
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.pistions, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 1)
    if gearWheelNeeded then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 1)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 1)
end

apm.bob_rework.lib.override.simpleEngines = function ()
    buildSimpleEngine(apm.bob_rework.lib.tier.gray, false)
    buildSimpleEngine(apm.bob_rework.lib.tier.steam, true)

    local recipe = product.egenerator
    local crafftingCategory = category.crafting.with.fluid
    apm.lib.utils.recipe.category.change(recipe, crafftingCategory)
    apm.lib.utils.recipe.category.change(recipe..'-2', crafftingCategory)
    apm.lib.utils.recipe.category.change(recipe..'-3', crafftingCategory)
end
