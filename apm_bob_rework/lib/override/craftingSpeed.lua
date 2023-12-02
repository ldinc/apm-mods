local assemblers  = require "lib.entities.buildings.assemblers"
local crushers    = require "lib.entities.buildings.crushers"
local presses     = require "lib.entities.buildings.presses"
local sieves      = require "lib.entities.buildings.sieves"
local cokings     = require "lib.entities.buildings.coking-plant"
local centrifuges = require "lib.entities.buildings.centrifuges"
local aircleaners = require "lib.entities.buildings.aircleaners"
local steelworks  = require "lib.entities.buildings.steelworks"
local chemistry   = require "lib.entities.buildings.chemistry"
local types       = require "lib.entities.types"


if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.craftingSpeed = function()
    local set = function(name, speed, t)
        if t == nil then
            t = types.assemblers
        end

        local group = data.raw[t]

        if group == nil then
            apm.lib.utils.debug.object({ ["no_type"] = t })
            return
        end

        local entity = group[name]

        if entity ~= nil then
            entity.crafting_speed = speed
        else
            apm.lib.utils.debug.object({["info"] = "apm.bob_rework.lib.override.craftingSpeed", name = name, t = t})
        end
    end

    local gray = 0.75
    local steam = 1.0
    local yellow = 1.0
    local red = 2.0
    local blue = 3.0

    set(assemblers.burner, gray)
    set(crushers.burner, gray)
    set(presses.burner, gray)
    set(sieves.basic, gray)
    set(centrifuges.burner, gray)
    set(cokings.basic, 1.0)
    set(steelworks.pudding.furnace, 1.0)

    set(assemblers.steam, steam)
    set(crushers.steam, steam)
    set(presses.steam, steam)
    set(sieves.steam, steam)
    set(centrifuges.steam, steam)
    set(cokings.steam, 1.5)
    set(aircleaners.basic, steam)

    set(assemblers.yellow, yellow)
    set(crushers.basic, red)
    set(presses.basic, red)
    set(centrifuges.basic, red)
    set(aircleaners.advanced, red)
    set(cokings.advanced, 2.0)
    set(steelworks.basic, 2.0)
    set(chemistry.plant.yellow, yellow)
    set(chemistry.electrolyser.yellow, yellow)
    set(chemistry.distillery.yellow, yellow, types.furnace)
    set(chemistry.compressor.basic, yellow)
    set(chemistry.pump.basic, yellow)

    set(assemblers.red, red)
    set(steelworks.advanced, 3.0)
    set(chemistry.plant.red, red)
    set(chemistry.electrolyser.red, red)
    set(chemistry.distillery.red, red, types.furnace)
    set(chemistry.oil.refinery.basic, red)

    set(assemblers.blue, blue)
    set(chemistry.plant.blue, blue)
    set(chemistry.electrolyser.blue, blue)
    set(chemistry.distillery.blue, blue, types.furnace)
    set(chemistry.compressor.advance, blue)
    set(chemistry.pump.advance, blue)
    set(chemistry.oil.refinery.advanced, blue)
end
