local crushers    = require "lib.entities.buildings.crushers"
local types       = require "lib.entities.types"
local greenhouses = require "lib.entities.buildings.greenhouses"
local presses     = require "lib.entities.buildings.presses"
local centrifuges = require "lib.entities.buildings.centrifuges"
local steelworks  = require "lib.entities.buildings.steelworks"
local chemistry   = require "lib.entities.buildings.chemistry"
local furnaces    = require "lib.entities.buildings.furnaces"
local miners      = require "lib.entities.buildings.miners"
local pumpjacks   = require "lib.entities.buildings.pumpjacks"
if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

apm.bob_rework.lib.override.slots = function()
    local slots = {
        burner = 1,
        steam = 2,
        yellow = 3,
        red = 4,
        blue = 5,
    }

    local set = function(name, count, type)
        if type == nil then
            type = types.assemblers
        end

        local group = data.raw[type]

        if group == nil then
            apm.lib.utils.debug.object({
                tag = 'error',
                fn = 'apm.bob_rework.lib.override.slots',
                msg = 'no group',
                name = name,
                type = type,
                count = count,
            })
            return
        end

        local entity = group[name]

        if entity ~= nil then
            if type == types.assemblers then
                apm.lib.utils.assembler.mod.module_specification(name, count)
            else
                entity.module_specification.module_slots = count
            end
        else
            apm.lib.utils.debug.object({
                tag = 'error',
                fn = 'apm.bob_rework.lib.override.slots',
                msg = 'no entity',
                name = name,
                type = type,
                count = count,
            })
        end
    end

    set(crushers.basic, slots.red)
    set(greenhouses.basic, slots.red)
    set(presses.basic, slots.red)
    set(centrifuges.basic, slots.red)
    set('apm_coking_plant_2', slots.red)
    set(steelworks.basic, slots.yellow)

    set(chemistry.electrolyser.yellow, slots.yellow)
    set(chemistry.electrolyser.red, slots.red)
    set(chemistry.electrolyser.blue, slots.blue)

    set(chemistry.distillery.yellow, slots.yellow, types.furnace)
    set(chemistry.distillery.red, slots.red, types.furnace)
    set(chemistry.distillery.blue, slots.blue, types.furnace)

    set(chemistry.oil.refinery.basic, slots.red)
    set(chemistry.oil.refinery.advanced, slots.blue)

    set(chemistry.plant.yellow, slots.yellow)
    set(chemistry.plant.red, slots.red)
    set(chemistry.plant.blue, slots.blue)

    set(furnaces.chemical.electric, slots.red)
    set(furnaces.mixing.electric, slots.red)
    set(furnaces.multipurpose, slots.blue)

    set(miners.red, slots.red, types.mining)
    set(miners.blue, slots.blue, types.mining)

    set(pumpjacks.burner, slots.yellow, types.mining)
    set(pumpjacks.basic, slots.red, types.mining)
    set(pumpjacks.advanced, slots.blue, types.mining)

    set(chemistry.pump.basic, slots.red)
    set(chemistry.pump.advance, slots.blue)

    set(chemistry.compressor.basic, slots.red)
    set(chemistry.compressor.advance, slots.blue)
end
