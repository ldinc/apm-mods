if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.genAssembler = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 2 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.alloy, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.lightAlloy, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.basement, 20 * tier.main.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.inserter, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.assemblers = function ()
    apm.bob_rework.lib.override.genAssembler('apm_assembling_machine_0', apm.bob_rework.lib.tier.bronze)
    apm.bob_rework.lib.override.genAssembler('apm_assembling_machine_1', apm.bob_rework.lib.tier.brass)
end

apm.bob_rework.lib.override.genAssembler6 = function (recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.engineUnit, 4 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.titanium, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.tungstencarbide, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.refinedConcrete, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.inserter, 4)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.main.logic, tier.level*2 + 1)
end

apm.bob_rework.lib.override.assemblers = function ()
    apm.bob_rework.lib.override.genAssembler6('assembling-machine-6', apm.bob_rework.lib.tier.titanium)
end