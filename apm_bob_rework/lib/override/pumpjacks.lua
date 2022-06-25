if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildPumpjack = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20 + 5*tier.level)
    local logic = tier.logic
    if tier.level == 1 then 
        logic = apm.bob_rework.lib.entities.logicContact
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 6 + 3*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 20 + 5*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.electricEngineUnit, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.ironStick, 12)
end

apm.bob_rework.lib.override.pumpjacks = function ()
    buildPumpjack('pumpjack', apm.bob_rework.lib.tier.yellow)
    buildPumpjack('bob-pumpjack-1', apm.bob_rework.lib.tier.red)
    -- buildPumpjack('bob-pumpjack-2', apm.bob_rework.lib.tier.steel)
    -- buildPumpjack('bob-pumpjack-3', apm.bob_rework.lib.tier.aluminium)
    -- buildPumpjack('bob-pumpjack-4', apm.bob_rework.lib.tier.titanium)

    buildPumpjack('water-miner-1', apm.bob_rework.lib.tier.yellow)
    buildPumpjack('water-miner-2', apm.bob_rework.lib.tier.red)
    -- buildPumpjack('water-miner-3', apm.bob_rework.lib.tier.steel)
    -- buildPumpjack('water-miner-4', apm.bob_rework.lib.tier.aluminium)
    -- buildPumpjack('water-miner-5', apm.bob_rework.lib.tier.titanium)
end