if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local asmbl = require('lib.entities.buildings.assemblers')
local t = require('lib.tier.base')

apm.bob_rework.lib.override.genAssembler = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engine, 1 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3 * tier.level)
    if tier.extraConstructionAlloy then
        local count = 20
        if tier.level == 1 then
            count = 10
        end
        if tier.level > 1 then
            count = 15
        end
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, count)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 1 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level * 4 + 1)
    if tier.extraLogic then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, tier.level * 4 + 1)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5 + tier.level * 2)
end

apm.bob_rework.lib.override.assemblers = function()
    local gen = apm.bob_rework.lib.override.genAssembler
    gen(asmbl.burner, t.gray)
    gen(asmbl.steam, t.steam)
    gen(asmbl.yellow, t.yellow)
    gen(asmbl.red, t.red)
    gen(asmbl.blue, t.blue)
end
