local combat = require "lib.entities.combat"
local materials = require "lib.entities.materials"
local plates    = require "lib.entities.plates"
local product   = require "lib.entities.product"
local logic     = require "lib.entities.logic"
local alloys    = require "lib.entities.alloys"
local pipes     = require "lib.entities.pipes"

local update = function ()
    local recipe = ''
    local reset = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end
    local add = function (i, c) apm.lib.utils.recipe.ingredient.mod(recipe, i, c) end

    recipe = combat.turret.gun.basic
    reset()
    add(materials.wood, 5)
    add(alloys.bronze, 2)
    add(logic.mechanical, 1)

    recipe = combat.turret.gun.advance
    reset()
    add(materials.planks, 5)
    add(alloys.brass, 2)
    add(product.gearwheel.brass, 1)
    add(logic.steam, 1)

    recipe = combat.turret.gun.sniper
    reset()
    add(combat.turret.gun.advance, 1)
    add(pipes.base.brass, 2)
    add(logic.steam, 1)

    recipe = combat.turret.shotgun
    reset()
    add(materials.planks, 5)
    add(alloys.brass, 2)
    add(product.gearwheel.brass, 1)
    add(logic.steam, 2)

	recipe = combat.turret.launcher.capsule
    reset()
    local tier = apm.bob_rework.lib.tier.red
    add(tier.constructionAlloy, 30)
    add(tier.pipe, 10)
	add(tier.logic, 20)
	add(tier.gearWheel, 10)
	add(tier.bearing, 4)
	add(product.engine.electric, 4)
	add(tier.basement, 20)

    recipe = combat.artillery.light
    reset()
    add(product.engine.steam, 20)
    add(alloys.brass, 40)
    add(materials.planks, 100)
    add(product.gearwheel.brass, 10)
    add(product.bearing.brass, 15)
    add(pipes.base.brass)
    add(logic.steam, 10)

    recipe = combat.artillery.basic
    reset()
    add(tier.constructionAlloy, 100)
    add(tier.extraConstructionAlloy, 50)
    add(tier.logic, 30)
    add(tier.bearing, 20)
    add(tier.gearWheel, 30)
    add(tier.basement, 50 * tier.level)
    add(product.engine.basic, 20 + 20 * tier.level)

    recipe = combat.artillery.remote.light
    reset()
    add(combat.radar.sentinel, 1)
    add(logic.circuit.basic, 1)
end

update()