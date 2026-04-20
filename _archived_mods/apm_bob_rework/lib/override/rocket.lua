local rocket  = require "lib.entities.new.rocket"
local plates  = require "lib.entities.plates"
local product = require "lib.entities.product"
local combat  = require "lib.entities.combat"
local energy  = require "lib.entities.buildings.energy"
local logic   = require "lib.entities.logic"
local fluids  = require "lib.entities.fluids"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local alloys = require "lib.entities.alloys"
local t = require('lib.tier.base')

local patchRocketSilo = function()
    local name = 'rocket-silo'
    local entity = data.raw['rocket-silo'][name]

    entity.fluid_boxes = {
        {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 1000,
            base_level = -1,
            pipe_connections = { { type = "input", position = { 2, -5 } } },
            secondary_draw_orders = { north = -1 }
        },
        {
            production_type = "input",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 1000,
            base_level = -1,
            pipe_connections = { { type = "input", position = { 5, -0 } } },
            secondary_draw_orders = { west = -1 }
        },
    }

    local recipe = 'rocket-part'
    apm.lib.utils.recipe.ingredient.replace(recipe, 'rocket-fuel', fluids.hydrazine, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, fluids.hydrazine, 2000)
    apm.lib.utils.recipe.ingredient.mod(recipe, fluids.dinitrogen.tetroxide, 1000)

end

local update = function()
    local recipe = rocket.silo
    local tier = t.blue
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 400)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)

    local recipe = rocket.engine
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.copper, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.aluminium, 1)

    local recipe = combat.ammo.rocket.base
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, rocket.body, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, rocket.warhead, 1)

    recipe = 'satellite'
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.battery.III, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, combat.equip.generator.solar.advance, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, logic.rocket, 80)
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.low.density.structure, 50)
    apm.lib.utils.recipe.ingredient.mod(recipe, combat.radar.base, 4)

    patchRocketSilo()
end

update()
