if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

require('lib.utils.debug')
require('lib.utils.grid')

local t         = require('lib.tier.base')
local transport = require "lib.entities.transport"
local product   = require "lib.entities.product"
local plates    = require "lib.entities.plates"
local energy    = require "lib.entities.buildings.energy"

local setNewGridSizeAndHPToWagon = function(recipe, hp, w, h)
    local wagon = data.raw["cargo-wagon"][recipe]
    if wagon then
        wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildCargoWagon = function(recipe, tier, hp, w, h, armoured)
    setNewGridSizeAndHPToWagon(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 30)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12)
end

buildCargoWagon(transport.wagon.cargo.basic, t.yellow, 2000, 10, 6, false)
buildCargoWagon(transport.wagon.cargo.heavy, t.red, 4000, 14, 6, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToFluidWagon = function(recipe, hp, w, h)
    local wagon = data.raw["fluid-wagon"][recipe]
    if wagon then
        wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildFluidWagon = function(recipe, tier, hp, w, h, armoured)
    setNewGridSizeAndHPToFluidWagon(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.rubber, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 8)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 12)
end

buildFluidWagon(transport.wagon.fluid.basic, t.yellow, 2000, 8, 6, false)
buildFluidWagon(transport.wagon.fluid.heavy, t.red, 4000, 14, 6, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToLocomotive = function(recipe, hp, w, h)
    local locomotive = data.raw.locomotive[recipe]
    if locomotive then
        locomotive.max_health = hp
        local equipmentGridName = locomotive.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local fixNulcearLocomotive = function(recipe)

    local fg = { 'apm_nuclear_uranium', 'apm_nuclear_mox', 'apm_nuclear_neptunium', 'apm_nuclear_thorium',
        'apm_nuclear_deuterium', 'deuterium' }

    local locomotive = data.raw.locomotive[recipe]
    if locomotive then
        locomotive.burner.fuel_category = ''
        locomotive.burner.fuel_categories = fg
        locomotive.max_speed = 1.6
        locomotive.max_power = '5MW'
        locomotive.weight = 20000
    end

    local generator = data.raw['generator-equipment']['nuclear-generator-rampant-arsenal']
    if generator then
        generator.burner.fuel_category = ''
        generator.burner.fuel_categories = fg
    end
end

local buildNuclearLocomotive = function(recipe, tier, armoured)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 60)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.lead, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraLogic, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pipe, 6)
    apm.lib.utils.recipe.ingredient.mod(recipe, energy.heat.pipe.extra, 50)
    local engine = product.engine.steam
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 20 + 5 * tier.level)

    fixNulcearLocomotive(recipe)
end

local buildLocomotive = function(recipe, tier, hp, w, h, armoured)
    setNewGridSizeAndHPToLocomotive(recipe, hp, w, h)
    if recipe == 'nuclear-train-vehicle-rampant-arsenal' then
        buildNuclearLocomotive(recipe, tier, armoured)
        return
    end

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if armoured then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 20)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    local engine = product.engine.basic
    if tier.level <= 1 then
        engine = product.engine.burner
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 20 + 5 * tier.level)
end


buildLocomotive(transport.locomotive.basic, t.yellow, 3000, 10, 6, false)
buildLocomotive(transport.locomotive.heavy, apm.bob_rework.lib.tier.red, 4500, 14, 8, true)
buildLocomotive(transport.locomotive.nuclear, apm.bob_rework.lib.tier.blue, 8000, 18, 8, true)

-------------------------------------------------------------------------------

local setNewGridSizeAndHPToArtillery = function(recipe, hp, w, h)
    local wagon = data.raw['artillery-wagon'][recipe]
    if wagon then
        wagon.max_health = hp
        local equipmentGridName = wagon.equipment_grid
        apm.bob_rework.lib.utils.grid.set(equipmentGridName, w, h)
    end
end

local buildArtilleryWagon = function(recipe, tier, hp, w, h)
    setNewGridSizeAndHPToArtillery(recipe, hp, w, h)

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.extraConstructionAlloy, 40)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 30)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 60)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.bearing, 16)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.gearWheel, 36)
    local engine = product.engine.basic
    apm.lib.utils.recipe.ingredient.mod(recipe, engine, 40 + 10 * tier.level)
end

buildArtilleryWagon(transport.wagon.artillery, t.red, 3000, 12, 8)
