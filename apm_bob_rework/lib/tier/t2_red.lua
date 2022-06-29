if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.entities.base')

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

local redTier = {
    level                  = 2,
    frame                  = frame.basic,
    constructionAlloy      = alloy.cobalt,
    extraConstructionAlloy = plate.invar,
    heatAlloy              = alloy.monel,
    logic                  = logic.circuit.advanced,
    extraLogic             = nil,
    pipe                   = pipe.base.steel,
    heatPipe               = pipe.base.iron,
    exchangePipe           = pipe.base.copper,
    basement               = mat.concrete,
    basementK              = 1,
    engineUnit             = p.engine.electric,
    gearWheel              = p.gearwheel.cobaltSteel,
    bearing                = p.bearing.cobaltSteel,
    inserter               = ins.basic.red,
    filterInserter         = ins.filter.red,
    stackInserter          = ins.stack.red,
    stackFilterInserter    = ins.filter.stack.red,
    belt                   = delivery.belt.red,
    underBelt              = delivery.underground.belt.red,
    splitter               = delivery.splitter.red,
    loader                 = delivery.loader.red,
    pump                   = pump.red,
    wire                   = wire.unsulated,
    battery                = p.battery.LiIon,
    heatProvider           = e.heat.pipe.advance,
}

apm.bob_rework.lib.tier.red = redTier
apm.bob_rework.lib.tier.list[2] = redTier
