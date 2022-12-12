local plates = require "lib.entities.plates"
local alloys = require "lib.entities.alloys"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

require('lib.entities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.plate = function ()
    local recipe = 'copper-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.copper, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-ore', 0)
    local recipe = 'iron-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'tin-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.tin, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tin-ore', 0)
    local recipe = 'lead-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.lead, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'lead-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.lead, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'lead-oxide-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.lead, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)
    local recipe = 'apm_zinc'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.zinc, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'zinc-ore', 0)
    local recipe = 'bob-zinc-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.zinc, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'zinc-ore', 0)
    local recipe = 'silver-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.silver, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'silver-ore', 0)
    local recipe = 'bob-gold-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.gold, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'gold-ore', 0)
    local recipe = 'cobalt-oxide-from-copper'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.copper, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-ore', 0)
    local recipe = 'cobalt-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.cobalt, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'cobalt-ore', 0)
    local recipe = 'alumina'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.aluminium, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'bauxite-ore', 0)
    local recipe = 'bob-nickel-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.nickel, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'nickel-ore', 0)
    local recipe = 'bob-titanium-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.titanium, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rutile-ore', 0)
    local recipe = 'tungstic-acid'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.tungsten, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tungsten-ore', 0)
    local recipe = 'apm_steel_0'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'apm_steel_1'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 18)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = 'apm_steel_2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'iron-ore', 0)
    local recipe = alloys.cobalt.steel
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.cobalt, 3)

end 