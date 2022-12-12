local rocket = require "lib.entities.new.rocket"
local plates = require "lib.entities.plates"
local product= require "lib.entities.product"
local combat = require "lib.entities.combat"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local alloys = require "lib.entities.alloys"
local t = require('lib.tier.base')

local update = function ()
    local recipe = rocket.silo
    local tier = t.blue
    apm.lib.utils.recipe.ingredient.mod(recipe, alloys.nitinol, 0)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.constructionAlloy, 400)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatPipe, 100)
    apm.lib.utils.recipe.ingredient.mod(recipe, tier.heatAlloy, 100)

    local recipe = rocket.engine
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.tungsten, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, plates.aluminium, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.gearwheel.titanium, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.bearing.titanium, 2)
    apm.lib.utils.recipe.ingredient.mod(recipe, product.stick, 1)

    local recipe = combat.ammo.rocket.base
    apm.lib.utils.recipe.ingredient.remove_all(recipe)
    apm.lib.utils.recipe.ingredient.mod(recipe, rocket.body, 1)
    apm.lib.utils.recipe.ingredient.mod(recipe, rocket.warhead, 1)
end

update()