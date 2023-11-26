local plates = require "lib.entities.plates"
local alloys = require "lib.entities.alloys"
local ores   = require "lib.entities.ores"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

require('lib.entities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.plate = function()
    local setResult = function (recipe, item, count)
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.result.mod(recipe, item, count)
    end

    local update = function(recipe, item, count, energy, energy_exp, milti)
        if milti == nil then
            apm.lib.utils.recipe.ingredient.remove_all(recipe)
        end
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)

        local v = data.raw.recipe[recipe]
        local result = v.result

        if result == nil then
            -- apm.lib.utils.debug.object(v)
            -- result = v.results[0].name
        else
            apm.lib.utils.recipe.result.mod(recipe, result, count)
        end

        if energy == nil then
            energy = 1
        end

        if energy_exp == nil then
            energy_exp = energy
        end

        apm.lib.utils.recipe.energy_required.mod(recipe, energy, energy_exp)
        apm.lib.utils.recipe.set.always_show_products(recipe, true)
    end

    update(plates.copper, apm.bob_rework.lib.entities.enriched.ore.copper, 10, 32)
    update(plates.iron, apm.bob_rework.lib.entities.enriched.ore.iron, 10, 32)
    update(plates.tin, apm.bob_rework.lib.entities.enriched.ore.tin, 10, 32)
    update(plates.lead, apm.bob_rework.lib.entities.enriched.ore.lead, 10, 32)
    update('bob-zinc-plate', apm.bob_rework.lib.entities.enriched.ore.zinc, 10, 32)
    update(plates.silver, apm.bob_rework.lib.entities.enriched.ore.silver, 10, 32)
    update('bob-gold-plate', apm.bob_rework.lib.entities.enriched.ore.gold, 10, 32)
    update('cobalt-oxide', apm.bob_rework.lib.entities.enriched.ore.cobalt, 10, 32)
    update(plates.cobalt, 'cobalt-oxide', 10, 32)
    update('lithium', 'lithium-chloride', 10, 32)
    update('bob-aluminium-plate', apm.bob_rework.lib.entities.enriched.ore.aluminium, 10, 32)
    update('bob-titanium-plate', apm.bob_rework.lib.entities.enriched.ore.titanium, 10, 32)

    local recipe = ''
    local set = function(item, count)
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)
    end

    local setEnergy = function(normal, expensive)
        if normal == nil then
            normal = 1
        end

        if expensive == nil then
            expensive = normal
        end

        apm.lib.utils.recipe.energy_required.mod(recipe, normal, expensive)
    end

    recipe = 'bob-nickel-plate'
    set(ores.nickel, 0)
    set(apm.bob_rework.lib.entities.enriched.ore.nickel, 10)
    set('oxygen', 80)
    setResult(recipe, plates.nickel, 10)
    setEnergy(32)

    recipe = 'apm_steel_0'
    set('iron-ore', 0)
    set(apm.bob_rework.lib.entities.enriched.ore.iron, 10)
    setResult(recipe, plates.steel, 8)
    -- update(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 10, 15, 15, false)
    -- setEnergy(15)

    recipe = 'apm_steel_1'
    set('iron-ore', 0)
    set(apm.bob_rework.lib.entities.enriched.ore.iron, 10)
    setResult(recipe, plates.steel, 8)
    -- -- set(apm.bob_rework.lib.entities.enriched.ore.iron, 12)
    -- update(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 10, 10, 10, false)
    -- setEnergy(10)

    recipe = 'apm_steel_2'
    set('iron-ore', 0)
    set(apm.bob_rework.lib.entities.enriched.ore.iron, 8)
    setResult(recipe, plates.steel, 8)
    -- -- set(apm.bob_rework.lib.entities.enriched.ore.iron, 10)
    -- update(recipe, apm.bob_rework.lib.entities.enriched.ore.iron, 10, 7.5, 7.5, false)
    -- setEnergy(7.5)

    local recipe = 'cobalt-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, 'limestone', 10)
    local recipe = plates.cobalt
    apm.lib.utils.recipe.ingredient.mod(recipe, 'sulfuric-acid', 10)

    local recipe = 'lead-oxide'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.lead, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)

    local recipe = 'lead-oxide-2'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.lead, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'lead-ore', 0)

    local recipe = 'apm_zinc'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.zinc, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'zinc-ore', 0)

    local recipe = 'cobalt-oxide-from-copper'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.copper, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'copper-ore', 0)

    local recipe = 'alumina'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.aluminium, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'bauxite-ore', 0)

    local recipe = 'bob-titanium-plate'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.titanium, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'rutile-ore', 0)

    local recipe = 'tungstic-acid'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.tungsten, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tungsten-ore', 0)


    local recipe = alloys.cobalt.steel
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.cobalt, 3)
end
