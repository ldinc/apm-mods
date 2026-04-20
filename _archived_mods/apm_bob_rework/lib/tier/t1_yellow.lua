if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local wire = require('lib.entities.wires')
local pump = require('lib.entities.pumps')
local alloy = require('lib.entities.alloys')
local mat = require('lib.entities.materials')
local logic = require('lib.entities.logic')
local pipe = require('lib.entities.pipes')
local p = require('lib.entities.product')
local ins = require('lib.entities.buildings.inserters')
local delivery = require('lib.entities.buildings.delivery')
local e = require('lib.entities.buildings.energy')
local frame = require('lib.entities.frames')

local yellowTier = {
    level = 1,
    frame = frame.steam,
    constructionAlloy = alloy.brass,
    extraConstructionAlloy = mat.planks,
    heatAlloy = alloy.brass,
    logic = logic.circuit.basic,
    extraLogic = nil,
    pipe = pipe.base.brass,
    heatPipe = pipe.base.brass,
    exchangePipe = pipe.base.copper,
    basement = mat.brick,
    basementK = 1,
    engineUnit = p.engine.electric,
    gearWheel = p.gearwheel.brass,
    bearing = p.bearing.brass,
    inserter = ins.basic.yellow,
    filterInserter = ins.filter.yellow,
    stackInserter = nil,
    stackFilterInserter = nil,
    belt = delivery.belt.yellow,
    underBelt = delivery.underground.belt.yellow,
    splitter = delivery.splitter.yellow,
    loader = delivery.loader.yellow,
    stacker = delivery.stacker.yellow,
    pump = pump.yellow,
    wire = wire.copper,
    battery = p.battery.basic,
    heatProvider = e.heat.pipe.basic,
}

apm.bob_rework.lib.tier.yellow = yellowTier
apm.bob_rework.lib.tier.list[1] = yellowTier
