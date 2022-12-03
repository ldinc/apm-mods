if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local b = require('lib.entities.buildings.chemistry')
local p = require('lib.entities.product')
local m = require('lib.entities.materials')

local bob_chemical_plant_facing = function(tint, offset)
    return {
        layers = {
            {
                filename = "__bobassembly__/graphics/entity/chemical-plant/chemical-plant.png",
                width = 108,
                height = 148,
                y = offset * 296,
                frame_count = 24,
                line_length = 12,
                shift = util.by_pixel(1, -9),
                hr_version = {
                    filename = "__bobassembly__/graphics/entity/chemical-plant/hr-chemical-plant.png",
                    width = 220,
                    height = 292,
                    y = offset * 584,
                    frame_count = 24,
                    line_length = 12,
                    shift = util.by_pixel(0.5, -9),
                    scale = 0.5
                }
            },
            {
                filename = "__bobassembly__/graphics/entity/chemical-plant/chemical-plant-mask.png",
                width = 108,
                height = 148,
                y = offset * 296,
                frame_count = 24,
                line_length = 12,
                tint = tint,
                shift = util.by_pixel(1, -9),
                hr_version = {
                    filename = "__bobassembly__/graphics/entity/chemical-plant/hr-chemical-plant-mask.png",
                    width = 220,
                    height = 292,
                    y = offset * 584,
                    frame_count = 24,
                    line_length = 12,
                    tint = tint,
                    shift = util.by_pixel(0.5, -9),
                    scale = 0.5
                }
            },
            {
                filename = "__bobassembly__/graphics/entity/chemical-plant/chemical-plant-highlights.png",
                width = 108,
                height = 148,
                y = offset * 296,
                frame_count = 24,
                line_length = 12,
                blend_mode = "additive",
                shift = util.by_pixel(1, -9),
                hr_version = {
                    filename = "__bobassembly__/graphics/entity/chemical-plant/hr-chemical-plant-highlights.png",
                    width = 220,
                    height = 292,
                    y = offset * 584,
                    frame_count = 24,
                    line_length = 12,
                    blend_mode = "additive",
                    shift = util.by_pixel(0.5, -9),
                    scale = 0.5
                }
            },
            {
                filename = "__bobassembly__/graphics/entity/chemical-plant/chemical-plant-shadow.png",
                width = 154,
                height = 112,
                x = offset * 154,
                repeat_count = 24,
                frame_count = 1,
                shift = util.by_pixel(28, 6),
                draw_as_shadow = true,
                hr_version = {
                    filename = "__bobassembly__/graphics/entity/chemical-plant/hr-chemical-plant-shadow.png",
                    width = 312,
                    height = 222,
                    x = offset * 312,
                    repeat_count = 24,
                    frame_count = 1,
                    shift = util.by_pixel(27, 6),
                    draw_as_shadow = true,
                    scale = 0.5
                }
            }
        }
    }
end

local bob_chemical_plant_animation = function(tint)
    return {
        north = bob_chemical_plant_facing(tint, 0),
        east = bob_chemical_plant_facing(tint, 1),
        south = bob_chemical_plant_facing(tint, 2),
        west = bob_chemical_plant_facing(tint, 3)
    }
end

local buildIcon = function(item, tier)
    item.icon = tier
    item.icon_size = 64
end

local redrawChemicalPlant = function()

    local cp = data.raw["assembling-machine"]["chemical-plant"]
    local cp2 = data.raw["assembling-machine"]["chemical-plant-2"]
    local cp3 = data.raw["assembling-machine"]["chemical-plant-3"]
    cp3.animation = bob_chemical_plant_animation({ r = 0.1, g = 0.5, b = 0.7 })
    cp2.animation = bob_chemical_plant_animation({ r = 0.7, g = 0.2, b = 0.1 })
    cp.animation = bob_chemical_plant_animation({ r = 0.7, g = 0.7, b = 0.1 })
    cp.icon = "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant.png"
    cp2.icon = "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant.png"
    cp3.icon = "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant.png"

    local cp = data.raw["item"]["chemical-plant"]
    local cp2 = data.raw["item"]["chemical-plant-2"]
    local cp3 = data.raw["item"]["chemical-plant-3"]
    buildIcon(cp, "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant-y.png")
    buildIcon(cp2, "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant-r.png")
    buildIcon(cp3, "__apm_bob_rework_ldinc__/graphics/icons/chemical-plant-b.png")
end

local buildChemicalPlant = function(recipe, tier)
    apm.lib.utils.recipe.ingredient.remove_all(recipe)

    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, tier.level*3)
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 6 + 5 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.exchangePipe, 4 * tier.level)
    local count = 2
    if tier.level >= 4 then
        count = 4
    end

    apm.lib.utils.recipe.ingredient.mod(recipe, tier.pump, count)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.filter, 12)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 15)
    apm.lib.utils.recipe.ingredient.mod(recipe, m.glass, 10 + 5 * tier.level)
end

apm.bob_rework.lib.override.chemicalPlants = function()
    buildChemicalPlant(b.plant.yellow, t.yellow)
    buildChemicalPlant(b.plant.red, t.red)
    buildChemicalPlant(b.plant.blue, t.blue)
    redrawChemicalPlant()
end
