local energy = require "lib.entities.buildings.energy"
local frames = require "lib.entities.frames"
local materials = require "lib.entities.materials"
local pipes     = require "lib.entities.pipes"
local alloys    = require "lib.entities.alloys"
local logic     = require "lib.entities.logic"
local chemistry = require "lib.entities.buildings.chemistry"
local product   = require "lib.entities.product"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.energy')
local p = require('lib.entities.product')

local buildBurnerEGen = function()
    local recipe = b.generator.burner
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

local buildBoiler = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 3)
end

local buildBoilers = function ()
    local recipe = energy.boiler.basic
    local tier = t.steam
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 3)

    local recipe = energy.boiler.advance
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.cobalt.steel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.monel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.concrete, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, frames.basic, 3)

    local recipe = energy.boiler.advance
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.cobalt.steel, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.monel, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.steel, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, pipes.base.ceramic, 5)
    apm.lib.utils.recipe.ingredient.mod(recipe, materials.refined.concrete, 10)
    apm.lib.utils.recipe.ingredient.mod(recipe, frames.basic, 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic.circuit.basic, 5)

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
    buildSteamGenerator(b.generator.steam.basic, t.steam, 2)
    buildSteamGenerator(b.generator.steam.advance, t.red, 4)
    -- buildSteamGenerator(b.generator.steam.extra, t.blue, 5)
    --
    buildFluidGenerator(b.generator.fluid.basic, t.red, 5)
    buildFluidGenerator(b.generator.fluid.hydrazine, t.blue, 12)
    --
    buildBoilers()
    -- buildBoiler(b.boiler.basic, t.steam)
    -- buildBoiler(b.boiler.advance, t.yellow)
    -- buildBoiler(b.boiler.extra, t.red)
    --
    buildFluidBoiler(b.boiler.fluid.basic, b.boiler.advance, pipes.base.brass, 10)
    buildFluidBoiler(b.boiler.fluid.advance, b.boiler.extra, pipes.base.ceramic, 15)
    --
    buildTurbine(b.turbine.steam, t.red, 14)
end
