local combat = require "lib.entities.combat"
local modules= require "lib.entities.modules"
local plates = require "lib.entities.plates"
local logic  = require "lib.entities.logic"
local product= require "lib.entities.product"
local alloys = require "lib.entities.alloys"
local materials = require "lib.entities.materials"
local gems      = require "lib.entities.gems"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local t = require('lib.tier.base')

apm.bob_rework.lib.override.armor = function()
    local recipe = ''
    local add = function(i, c) apm.lib.utils.recipe.ingredient.mod(recipe, i, c)end
    local clear = function() apm.lib.utils.recipe.ingredient.remove_all(recipe) end

	recipe = combat.armor.shield.I
	clear()
    add(plates.steel, 5)
    add(alloys.brass, 10)
    add(logic.circuit.basic, 10)
    add(materials.glass, 10)

	recipe = combat.armor.shield.II
	clear()
	add(plates.steel, 10)
    add(plates.cobalt, 10)
    add(logic.circuit.advanced, 15)
    add(materials.glass, 20)

	recipe = combat.armor.shield.III
	clear()
    add(alloys.cobalt.steel, 20)
    add(alloys.invar, 10)
    add(logic.PU, 20)
    add(materials.glass, 30)
    add(gems.ruby.polished, 5)
    add(product.battery.LiIon, 10)
    add(modules.speed.pure.IV, 5)
    add(modules.productivity.pure.IV, 5)

    recipe = combat.armor.shield.IV
	clear()
    add(alloys.titanium, 20)
    add(alloys.tungstenCarbide, 10)
    add(logic.PU, 20)
    add(logic.APU, 20)
    add(materials.glass, 50)
    add(gems.sapphire.polished, 5)
    add(product.battery.AgZn, 10)
    add(modules.speed.pure.VIII, 5)
    add(modules.productivity.pure.VIII, 5)

    recipe = combat.armor.modular
    clear()
    add(plates.steel, 50)
    add(logic.circuit.basic, 20)
    add(product.engine.electric, 15)
    add(alloys.brass, 20)

    recipe = combat.armor.power.basic
    clear()
    add(alloys.cobalt.steel, 200)
    add(alloys.invar, 100)
    add(product.engine.electric, 50)
    add(logic.circuit.advanced, 50)
    add(modules.effectivity.I,10)
    add(modules.speed.I, 10)
    add(modules.productivity.I, 10)

    recipe = combat.armor.power.advance
    clear()
    add(alloys.cobalt.steel, 500)
    add(alloys.invar, 200)
    add(product.engine.electric, 100)
    add(logic.circuit.advanced, 100)
    add(modules.effectivity.IV, 10)
    add(modules.speed.IV, 10)
    add(modules.productivity.IV, 10)

    recipe = combat.armor.power.extra
    clear()
    add(alloys.titanium, 400)
    add(alloys.tungstenCarbide, 200)
    add(product.engine.electric, 200)
    add(alloys.low.density.structure, 100)
    add(logic.PU, 200)
    add(logic.APU, 200)
    add(modules.speed.VIII, 20)
    add(modules.effectivity.VIII, 20)
    add(modules.productivity.VIII, 20)
end
