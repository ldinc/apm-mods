local frames = require "lib.entities.frames"
local materials = require "lib.entities.materials"
local pipes     = require "lib.entities.pipes"
local alloys    = require "lib.entities.alloys"
local logic     = require "lib.entities.logic"
local product   = require "lib.entities.product"
local energy = require "lib.entities.energy"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local p = require('lib.entities.product')

local buildBurnerEGen = function()
    local recipe = energy.generator.burner
    local tier = t.yellow

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 9)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 6)
    end
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 2)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, p.engine.burner, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.egenerator, 2)

    -- fix fuel_category
    local generator = data.raw['burner-generator'][recipe]
    generator.burner.fuel_categories = { 'chemical', 'apm_refined_chemical' }
    generator.burner.burnt_inventory_size = 1
end

local buildSteamGenerator = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 2)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, p.engine.steam, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.egenerator, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 9 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 7 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 8 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 4 + 3 * tier.level)
end

local buildFluidGenerator = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 2)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, p.egenerator, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 6 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 6 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 8 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5 + tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 12 + 2 * tier.level)
end


local buildBoilers = function ()
    local recipe = ''
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function(itm, cnt) apm.lib.utils.recipe.ingredient.mod(recipe, itm, cnt) end

    recipe = energy.boiler.basic
    clear()
    local tier = t.steam
    add(tier.constructionAlloy, 10)
    add(tier.heatAlloy, 10)
    add(tier.heatPipe, 5)
    add(tier.basement, 10)
    add(tier.frame, 3)

    recipe = energy.boiler.advance
    clear()
    add(alloys.cobalt.steel, 10)
    add(alloys.monel, 10)
    add(pipes.base.steel, 5)
    add(materials.concrete, 10)
    add(frames.basic, 3)

    recipe = energy.boiler.advance
    clear()
    add(alloys.cobalt.steel, 10)
    add(alloys.monel, 15)
    add(pipes.base.steel, 5)
    add(pipes.base.ceramic, 5)
    add(materials.refined.concrete, 10)
    add(frames.basic, 3)
    add(logic.circuit.basic, 5)

end

local buildFluidBoiler = function(recipe, base, pipe, k)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, base, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, k)
end

local buildTurbine = function(recipe, tier, energyK)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 8)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, p.egenerator, 1 * energyK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8 + 4 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 10 + 3 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20 + 10 * tier.level)
    if tier.extraConstructionAlloy then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 20)
    end
end

apm.bob_rework.lib.override.electricGenerators = function()
    buildBurnerEGen()
    --
    buildSteamGenerator(energy.generator.steam.basic, t.steam, 2)
    buildSteamGenerator(energy.generator.steam.advance, t.red, 4)
    --
    buildFluidGenerator(energy.generator.fluid.basic, t.red, 4)
    buildFluidGenerator(energy.generator.fluid.hydrazine, t.red, 10)
    --
    buildBoilers()
    --
    buildFluidBoiler(energy.boiler.fluid.basic, energy.boiler.basic, pipes.base.brass, 10)
    buildFluidBoiler(energy.boiler.fluid.advance, energy.boiler.advance, pipes.base.ceramic, 15)
    --
    buildTurbine(energy.turbine.steam, t.red, 14)
end