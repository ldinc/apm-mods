if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local pump = require('lib.entities.pumps')
local alloy = require('lib.entities.alloys')
local mat = require('lib.entities.materials')
local logic = require('lib.entities.logic')
local pipe = require('lib.entities.pipes')
local p = require('lib.entities.product')
local ins = require('lib.entities.buildings.inserters')
local delivery = require('lib.entities.buildings.delivery')
local frame = require('lib.entities.frames')

local grayTier = {
    level = 0,
    frame = nil,
    constructionAlloy = alloy.bronze,
    extraConstructionAlloy = mat.wood,
    heatAlloy = alloy.bronze,
    logic = logic.mechanical,
    extraLogic = nil,
    pipe = pipe.base.bronze,
    heatPipe = pipe.base.bronze,
    exchangePipe = pipe.base.copper,
    basement = mat.stone,
    basementK = 2,
    engineUnit = p.engine.burner,
    gearWheel = p.gearwheel.bronze,
    bearing = p.bearing.bronze,
    inserter = ins.basic.burner,
    filterInserter = ins.filter.burner,
    stackInserter = nil,
    stackFilterInserter = nil,
    belt = delivery.belt.gray,
    underBelt = delivery.underground.belt.gray,
    splitter = delivery.splitter.gray,
    loader = delivery.loader.gray,
    pump = pump.burner,
    wire = nil,
    battery = nil,
    heatProvider = nil,
}

apm.bob_rework.lib.tier.gray = grayTier
apm.bob_rework.lib.tier.list[0] = grayTier

local steamTier = {
    level = 1,
    frame = frame.steam,
    frameK = 1,
    constructionAlloy = alloy.brass,
    extraConstructionAlloy = mat.planks,
    heatAlloy = alloy.brass,
    logic = logic.steam,
    extraLogic = nil,
    pipe = pipe.base.brass,
    heatPipe = pipe.under.brass,
    exchangePipe = pipe.base.copper,
    basement = mat.brick,
    basementK = 1,
    engineUnit = p.engine.steam,
    gearWheel = p.gearwheel.brass,
    bearing = p.bearing.brass,
    inserter = ins.basic.steam,
    filterInserter = nil,
    stackInserter = nil,
    stackFilterInserter = nil,
    belt = delivery.belt.yellow,
    underBelt = delivery.underground.belt.yellow,
    splitter = delivery.splitter.yellow,
    loader = delivery.loader.yellow,
    pump = pump.burner,
    wire = nil,
    battery = nil,
    heatProvider = nil,
}

apm.bob_rework.lib.tier.steam = steamTier
