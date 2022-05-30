if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.genAssembler = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local logic, inserter = tier.logic, tier.inserter
    local engine = tier.engineUnit
    if recipe == 'assembling-machine-6' then
        apm.bob_rework.lib.override.genAssembler6(recipe, tier)
        return
    end

    if recipe == 'assembling-machine-2' or recipe == 'assembling-machine-1' then
        logic = apm.bob_rework.lib.entities.logicContact
        inserter = apm.bob_rework.lib.entities.yellowInserter
        engine = apm.bob_rework.lib.entities.electricEngineUnit
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3*tier.level)
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
    apm.lib.utils.recipe.ingredient.mod(recipe, inserter, 4 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, tier.level*4 + 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5 +tier.level*2)
end

apm.bob_rework.lib.override.genAssembler6 = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.engineUnit, 4 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungstenCarbide, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.refinedConcrete, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.inserter, 5 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, tier.level*10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5 +tier.level*2)
end

local buildAdvancedAssembler = function (recipe, base, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local logic, inserter = tier.logic, tier.inserter
    local engine = tier.engineUnit
    if recipe == 'assembling-machine-2' or recipe == 'assembling-machine-1' then
        logic = apm.bob_rework.lib.entities.logicContact
        inserter = apm.bob_rework.lib.entities.yellowInserter
        engine = apm.bob_rework.lib.entities.electricEngineUnit
    end

    -- apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 2 )
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, inserter, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5 +tier.level*2)
end

local buildElectronicAssembler = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    local logic, inserter = tier.logic, tier.inserter
    if tier.level == 1 and recipe == 'electronics-machine-1' then
        logic = apm.bob_rework.lib.entities.logicContact
        inserter = apm.bob_rework.lib.entities.yellowInserter
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5+3*tier.level)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 5+3*tier.level)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, inserter, 5 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic, tier.level*4)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 5 +tier.level*2)
end

apm.bob_rework.lib.override.assemblers = function ()
    apm.bob_rework.lib.override.genAssembler('apm_assembling_machine_0', apm.bob_rework.lib.tier.bronze)
    apm.bob_rework.lib.override.genAssembler('apm_assembling_machine_1', apm.bob_rework.lib.tier.brass)
    apm.bob_rework.lib.override.genAssembler('assembling-machine-1', apm.bob_rework.lib.tier.brass)
    buildAdvancedAssembler('assembling-machine-2', 'assembling-machine-1', apm.bob_rework.lib.tier.brass)
    apm.bob_rework.lib.override.genAssembler('assembling-machine-3', apm.bob_rework.lib.tier.monel)
    apm.bob_rework.lib.override.genAssembler('assembling-machine-4', apm.bob_rework.lib.tier.steel)
    apm.bob_rework.lib.override.genAssembler('assembling-machine-5', apm.bob_rework.lib.tier.aluminium)
    apm.bob_rework.lib.override.genAssembler('assembling-machine-6', apm.bob_rework.lib.tier.titanium)

    buildElectronicAssembler('electronics-machine-1', apm.bob_rework.lib.tier.brass)
    buildElectronicAssembler('electronics-machine-2', apm.bob_rework.lib.tier.steel)
    buildElectronicAssembler('electronics-machine-3', apm.bob_rework.lib.tier.titanium)
end