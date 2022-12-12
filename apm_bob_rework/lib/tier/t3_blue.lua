if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local wire = require('lib.entities.wires')
local pump = require('lib.entities.pumps')
local alloy = require('lib.entities.alloys')
local plate = require('lib.entities.plates')
local mat = require('lib.entities.materials')
local logic = require('lib.entities.logic')
local pipe = require('lib.entities.pipes')
local p = require('lib.entities.product')
local ins = require('lib.entities.buildings.inserters')
local delivery = require('lib.entities.buildings.delivery')
local e = require('lib.entities.buildings.energy')
local frame = require('lib.entities.frames')

local blueTier = {
    level = 3,
    frame = frame.advanced,
    constructionAlloy = alloy.titanium,
    extraConstructionAlloy = alloy.tungstenCarbide,
    heatAlloy = alloy.copper.tungsten,
    logic = logic.PU,
    extraLogic = logic.APU,
    pipe = pipe.base.titaniumAlloy,
    heatPipe = pipe.base.ceramic,
    exchangePipe = pipe.base.copperTungsten,
    basement = mat.refined.concrete,
    basementK = 1,
    engineUnit = p.engine.electric,
    gearWheel = p.gearwheel.titanium,
    bearing = p.bearing.titanium,
    inserter = ins.basic.blue,
    filterInserter = ins.filter.blue,
    stackInserter = ins.stack.blue,
    stackFilterInserter = ins.filter.stack.blue,
    belt = delivery.belt.blue,
    underBelt = delivery.underground.belt.blue,
    splitter = delivery.splitter.blue,
    loader = delivery.loader.blue,
    pump = pump.blue,
    wire = wire.gilded.copper,
    battery = p.battery.Z,
    heatProvider = e.heat.pipe.extra,
}

apm.bob_rework.lib.tier.blue = blueTier
apm.bob_rework.lib.tier.list[3] = blueTier
