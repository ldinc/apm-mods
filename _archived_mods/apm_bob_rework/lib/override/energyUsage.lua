local types = require "lib.entities.types"
local assemblers = require "lib.entities.buildings.assemblers"
local miners     = require "lib.entities.buildings.miners"
local chemistry  = require "lib.entities.buildings.chemistry"
local pumpjacks  = require "lib.entities.buildings.pumpjacks"
local furnaces   = require "lib.entities.buildings.furnaces"
local labs       = require "lib.entities.buildings.labs"
local beacons    = require "lib.entities.buildings.beacons"

if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

local function kW(value)
    return tostring(value) .. "kW"
end

local setEnergyUsage = function (entity, base, k)
    entity.energy_usage = kW(base * k)
end

local updateAssembler = function (name, base, k)
    local entity = data.raw[types.assemblers][name]

    setEnergyUsage(entity, base, k)
end

local updateMiners = function (name, base, k)
    setEnergyUsage(data.raw[types.mining][name], base, k)
end

local updateFurnace = function (name, base, k)
    setEnergyUsage(data.raw[types.furnace][name], base, k)
end

local updateLab = function (name, base, k)
    setEnergyUsage(data.raw[types.lab][name], base, k)
end


apm.bob_rework.lib.override.updateEnergyUsage = function()
    local k = {
        I = 1.0,
        II = 1.8,
        III = 2.2,
    }

    local base = 150

    updateAssembler(assemblers.yellow, base, 1)
    updateAssembler(assemblers.red, base, 2)
    updateAssembler(assemblers.blue, base, 4)

    base = 300

    updateMiners(miners.basic, base, 1)
    updateMiners(miners.red, base, 2)
    updateMiners(miners.blue, base, 4)

    base = 100

    updateAssembler(chemistry.pump.basic, base, k.I)
    updateAssembler(chemistry.pump.advance, base, k.II)

    base = 250

    updateAssembler(chemistry.compressor.basic, base, k.I)
    updateAssembler(chemistry.compressor.advance, base, k.II)

    base = 2000

    updateMiners(pumpjacks.burner, 2000, 1)
    updateMiners(pumpjacks.basic, 5000, 1)
    updateMiners(pumpjacks.advanced, 7500, 1)

    base = 800

    updateAssembler(furnaces.chemical.electric, base, k.I)
    updateAssembler(furnaces.mixing.electric, base, k.I)
    updateAssembler(furnaces.multipurpose, base, 1.5)

    updateFurnace('electric-incinerator', 600, 1)

    updateLab(labs.basic, 2000, 1)
    updateLab(labs.advanced, 5000, 1)
    updateLab(labs.module, 5000, 1)

    setEnergyUsage(data.raw[types.rocket.silo]['rocket-silo'], 250000, 1)

    updateAssembler(chemistry.oil.refinery.basic, 3000, 1)
    updateAssembler(chemistry.oil.refinery.advanced, 4500, 1)

    base = 650

    updateAssembler(chemistry.plant.yellow, base, k.I)
    updateAssembler(chemistry.plant.red, base, k.II)
    updateAssembler(chemistry.plant.blue, base, k.III)

    setEnergyUsage(data.raw[types.beacon][beacons.basic], 2500, 1)
    setEnergyUsage(data.raw[types.beacon][beacons.advance], 5000, 1)

end