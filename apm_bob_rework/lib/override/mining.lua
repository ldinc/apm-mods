if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local miner = require('lib.entities.buildings.miners')
local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildMiningRecipe = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*2)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 8 + 2 * tier.level)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 8 + 2 * tier.level)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 14 + 4 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 12 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12 + 3 * tier.level)
    if tier.level > 1 then
        apm.lib.utils.recipe.ingredient.mod(recipe, p.stick, 8 + 3 * tier.level)
    end
    if tier.level < 1 then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 0)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 2)
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 1)
    end
end


local buff = function(name, ms, r)
    local miner = data.raw['mining-drill'][name]
    --NOTE: This is 2.49 for electric mining drills (a 5x5 area) and 0.99 for burner mining drills (a 2x2 area).
    --      The drill searches resource outside its natural boundary box, which is 0.01 (the middle of the entity); making it 2.5 and 1.0 gives it another block radius.
    if miner then
        miner.mining_speed = ms
        miner.resource_searching_radius = r
    end
end

apm.bob_rework.lib.override.mining = function()
    buildMiningRecipe(miner.burner.basic, t.gray)
    buildMiningRecipe(miner.steam, t.steam)
    buildMiningRecipe(miner.basic, t.yellow)
    buildMiningRecipe(miner.red, t.red)
    buildMiningRecipe(miner.blue, t.blue)

    buff(miner.burner.basic, 0.6, 1.99) -- 4x4
    buff(miner.steam, 1, 2.49) -- 5x5
    buff(miner.basic, 1.2, 2.49)
    buff(miner.red, 2, 3.49)
    buff(miner.blue, 4, 4.49)

    local item = data.raw['mining-drill'][miner.basic]
    if item then
        item.next_upgrade = miner.red
        item.fast_replaceable_group = "electric-mining-drill"
    end
end
