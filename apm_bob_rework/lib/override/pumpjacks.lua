if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

local buildPumpjack = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
    local logic = tier.logic
    if tier.level == 1 then 
        logic = apm.bob_rework.lib.entities.logicContact
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 10)
end

apm.bob_rework.lib.override.pumpjacks = function ()
    buildPumpjack('pumpjack', apm.bob_rework.lib.tier.brass)
    buildPumpjack('bob-pumpjack-1', apm.bob_rework.lib.tier.monel)

    buildPumpjack('water-miner-1', apm.bob_rework.lib.tier.brass)
    buildPumpjack('water-miner-2', apm.bob_rework.lib.tier.monel)
end