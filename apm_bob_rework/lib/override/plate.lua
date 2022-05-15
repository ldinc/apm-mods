if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.plate = function ()
    local recipe = 'copper-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedCopperOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-ore', 0)
    local recipe = 'iron-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedIronOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'tin-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedTinOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tin-ore', 0)
    local recipe = 'lead-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedLeadOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'lead-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedLeadOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'lead-oxide-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedLeadOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'apm_zinc'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedZincOre, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'zinc-ore', 0)
    local recipe = 'bob-zinc-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedZincOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'zinc-ore', 0)
    local recipe = 'silver-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedSilverOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'silver-ore', 0)
    local recipe = 'bob-gold-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedGoldOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'gold-ore', 0)
    local recipe = 'cobalt-oxide-from-copper'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedCopperOre, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-ore', 0)
    local recipe = 'cobalt-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedCobaltOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'cobalt-ore', 0)
    local recipe = 'alumina'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedAluminiumOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'bauxite-ore', 0)
    local recipe = 'bob-nickel-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedNickelOre, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'nickel-ore', 0)
    local recipe = 'bob-titanium-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedTitaniumOre, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rutile-ore', 0)
    local recipe = 'tungstic-acid'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedTungstenOre, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tungsten-ore', 0)
    local recipe = 'apm_steel_0'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedIronOre, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'apm_steel_1'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedIronOre, 18)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'apm_steel_2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.EnrichedIronOre, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
end