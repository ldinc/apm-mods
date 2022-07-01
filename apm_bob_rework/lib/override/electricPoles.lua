local plates = require "lib.entities.plates"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')
local e = require('lib.entities.buildings.energy')
local mat = require('lib.entities.materials')
local p = require('lib.entities.product')

local buildEPole = function(medium, big, substation, tier, r)
    local recipe = medium
    local m = tier.level - 2

    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5 + 2 * m)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 2 + 2 * m)

    local recipe = big
    local rubberCount = 4
    local glassCount = 0
    if tier.level > 3 then
        rubberCount = 0
        glassCount = 4
    end
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 3 * m)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, rubberCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, mat.glass, glassCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 4 + 4 * m)

    local recipe = substation
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    if tier.frame then
        apm.lib.utils.recipe.ingredient.mod(recipe, tier.frame, 4)
    end
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 2 * tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, p.rubber, rubberCount * 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, mat.glass, glassCount * 3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 40 + 5 * m)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5 * tier.level)

    -- change poles area & wire square
    local entity = data.raw["electric-pole"][substation]
    entity.maximum_wire_distance = r * 2
    entity.supply_area_distance = r
    local entity = data.raw["electric-pole"][medium]
    entity.maximum_wire_distance = r * 2
    entity.supply_area_distance = r * 2 / 3
    local entity = data.raw["electric-pole"][big]
    entity.maximum_wire_distance = r / 3 * 10
end

apm.bob_rework.lib.override.electricPoles = function()
    buildEPole(e.pole.medium.basic, e.pole.big.basic, e.sub.station.basic, t.red, 9)
    buildEPole(e.pole.medium.advance, e.pole.big.advance, e.sub.station.advance, t.blue, 18)
end
