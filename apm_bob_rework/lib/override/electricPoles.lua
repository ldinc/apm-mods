if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')

local buildEPole = function (medium, big, substation, tier, r)
    local recipe = medium
    local m = tier.level - 2
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 5+2*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 2 + 2*m)

    local recipe = big
    local rubberCount = 4
    local glassCount = 0
    if tier.level > 3 then
        rubberCount = 0
        glassCount = 4
    end
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 3*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, rubberCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, glassCount)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 4+4*m)

    local recipe = substation
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 10 + 2*tier.level)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.rubber, rubberCount*3)
    apm.lib.utils.recipe.ingredient.mod(recipe, apm.bob_rework.lib.entities.glass, glassCount*3)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.wire, 40 + 5*m)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.basement, 10 * tier.basementK)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.logic, 5*tier.level)

    -- change poles area & wire square
    local entity = data.raw["electric-pole"][substation]
    entity.maximum_wire_distance = r*2
    entity.supply_area_distance = r
    local entity = data.raw["electric-pole"][medium]
    entity.maximum_wire_distance = r*2
    entity.supply_area_distance = r*2/3
    local entity = data.raw["electric-pole"][big]
    entity.maximum_wire_distance = r/3*10
end

apm.bob_rework.lib.override.electricPoles = function ()
    buildEPole('medium-electric-pole', 'big-electric-pole', 'substation', apm.bob_rework.lib.tier.yellow, 9)
    buildEPole('medium-electric-pole-2', 'big-electric-pole-2', 'substation-2', apm.bob_rework.lib.tier.blue, 18)
    -- buildEPole('medium-electric-pole-3', 'big-electric-pole-3', 'substation-3', apm.bob_rework.lib.tier.aluminium)
    -- buildEPole('medium-electric-pole-4', 'big-electric-pole-4', 'substation-4', apm.bob_rework.lib.tier.titanium)
end