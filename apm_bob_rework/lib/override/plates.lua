local plates    = require "lib.entities.plates"
local alloys    = require "lib.entities.alloys"
local ores      = require "lib.entities.ores"
local materials = require "lib.entities.materials"
local product   = require "lib.entities.product"
local fluids    = require "lib.entities.fluids"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end

require('lib.entities.base')
require('lib.tier.base')

apm.bob_rework.lib.override.plate = function()
    local setResult = function(recipe, item, count)
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.result.mod(recipe, item, count)
    end

    local update = function(recipe, item, count, energy, energy_exp, result, clearAll)
        if clearAll == true then
            apm.lib.utils.recipe.ingredient.remove_all(recipe)
        end
        if count == nil then
            count = 1
        end

        apm.lib.utils.recipe.ingredient.mod(recipe, item, count)

        local v = data.raw.recipe[recipe]
        if result == nil then
            result = v.result
        end

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

    update(plates.copper, apm.bob_rework.lib.entities.enriched.ore.copper, 10, 32, 32, plates.copper, true)
    update(plates.iron, apm.bob_rework.lib.entities.enriched.ore.iron, 10, 32, 32, plates.iron, true)
    update(plates.tin, apm.bob_rework.lib.entities.enriched.ore.tin, 10, 32, 32, plates.tin, true)
    update(plates.lead, apm.bob_rework.lib.entities.enriched.ore.lead, 10, 32, 32, plates.lead, true)
    -- update('bob-zinc-plate', apm.bob_rework.lib.entities.enriched.ore.zinc, 10, 32)
    -- update(plates.silver, apm.bob_rework.lib.entities.enriched.ore.silver, 10, 32)
    -- update('bob-gold-plate', apm.bob_rework.lib.entities.enriched.ore.gold, 10, 32)
    -- update('cobalt-oxide', apm.bob_rework.lib.entities.enriched.ore.cobalt, 10, 32)
    -- update(plates.cobalt, 'cobalt-oxide', 10, 32)
    update('lithium', 'lithium-chloride', 10, 32)
    -- update('bob-aluminium-plate', apm.bob_rework.lib.entities.enriched.ore.aluminium, 10, 32)
    -- update('bob-titanium-plate', apm.bob_rework.lib.entities.enriched.ore.titanium, 10, 32)

    local recipe = ''
    local rm = function()
        apm.lib.utils.recipe.ingredient.remove_all(recipe)
    end
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

    recipe = 'alumina'
    set(apm.bob_rework.lib.entities.enriched.ore.aluminium, 10)
    set('sodium-hydroxide', 10)
    set('bauxite-ore', 0)
    setResult(recipe, recipe, 10)
    setEnergy(10)

    recipe = 'bob-titanium-plate'
    set(apm.bob_rework.lib.entities.enriched.ore.titanium, 10)
    set('rutile-ore', 0)
    set(materials.carbon, 5)
    set('calcium-chloride', 10)
    setResult(recipe, plates.titanium, 10)
    setEnergy(32)

    recipe = 'bob-aluminium-plate'
    set(materials.carbon, 5)
    set('alumina', 10)
    setResult(recipe, plates.aluminium, 10)
    setEnergy(32)

    recipe = 'bob-gold-plate'
    rm()
    set(apm.bob_rework.lib.entities.enriched.ore.gold, 10)
    set(fluids.chlorine, 30)
    setResult(recipe, plates.gold, 10)
    setEnergy(32)

    recipe = 'bob-zinc-plate'
    rm()
    set(apm.bob_rework.lib.entities.enriched.ore.zinc, 10)
    set(fluids.acid.sulfuric, 100)
    setResult(recipe, plates.zinc, 10)
    setEnergy(32)

    recipe = plates.cobalt
    set('cobalt-oxide', 10)
    set(fluids.acid.sulfuric, 100)
    setResult(recipe, plates.cobalt, 10)
    setEnergy(32)

    recipe = 'powdered-tungsten'
    set('tungsten-oxide', 10)
    set(fluids.hydrogen, 150)
    setResult(recipe, recipe, 10)
    setEnergy(35)

    recipe = 'salt'
    set(fluids.water, 250)
    setResult(recipe, recipe, 10)
    setEnergy(5)

    recipe = 'silicon-carbide'
    set(materials.carbon, 10)
    set('silicon-powder', 10)
    setResult(recipe, recipe, 10)
    setEnergy(70)

    recipe = 'silicon-nitride'
    set('silicon-powder', 10)
    set(fluids.nitrogen, 125)
    setResult(recipe, recipe, 10)
    setEnergy(75)

    recipe = 'tungsten-oxide'
    set('tungsten-acid', 100)
    setResult(recipe, recipe, 10)
    setEnergy(20)

    recipe = 'tungsten-carbide'
    set(materials.carbon, 5)
    set('tungsten-oxide', 5)
    setResult(recipe, recipe, 10)
    setEnergy(64)

    recipe = 'tungsten-carbide-2'
    set(materials.carbon, 5)
    set('powdered-tungsten', 5)
    setResult(recipe, 'tungsten-carbide', 10)
    setEnergy(128)

    recipe = 'quartz-glass'
    set(ores.quartz, 10)
    setResult(recipe, materials.glass, 10)
    setEnergy(32)

    recipe = plates.silver
    rm()
    set(apm.bob_rework.lib.entities.enriched.ore.silver, 10)
    setResult(recipe, recipe, 10)
    setEnergy(32)

    recipe = 'cobalt-oxide'
    rm()
    set(apm.bob_rework.lib.entities.enriched.ore.cobalt, 10)
    set('limestone', 10)
    setResult(recipe, recipe, 10)
    setEnergy(70)
    
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


    local recipe = 'tungstic-acid'
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.enriched.ore.tungsten, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, 'tungsten-ore', 0)


    local recipe = alloys.cobalt.steel
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.steel, 7)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.cobalt, 3)
end
