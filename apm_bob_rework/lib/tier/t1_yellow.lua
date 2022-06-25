if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local wire = require('lib.entities.wires')
local pump = require('lib.entities.pumps')

local yellowTier = {
    level = 1,
    constructionAlloy = apm.bob_rework.lib.entities.brass,
    extraConstructionAlloy=apm.bob_rework.lib.entities.woodPlanks,
    heatAlloy = apm.bob_rework.lib.entities.brass,
    logic = apm.bob_rework.lib.entities.logicElectronic,
    pipe = apm.bob_rework.lib.entities.brassPipe,
    heatPipe = apm.bob_rework.lib.entities.brassPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperPipe,
    basement = apm.bob_rework.lib.entities.stoneBrick,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.brassGearWheel,
    bearing = apm.bob_rework.lib.entities.brassBearing,
    inserter = apm.bob_rework.lib.entities.yellowInserter,
    filterInserter = apm.bob_rework.lib.entities.yellowFilterInserter,
    stackInserter = nil,
    stackFilterInserter = nil,
    belt = apm.bob_rework.lib.entities.belt_t1,
    underBelt = apm.bob_rework.lib.entities.underBelt_t1,
    splitter = apm.bob_rework.lib.entities.splitter_t1,
    loader = apm.bob_rework.lib.entities.loader_t1,
    pump = pump.yellow,
    wire=wire.copper,
    battery=apm.bob_rework.lib.entities.battery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe,
}

apm.bob_rework.lib.tier.yellow = yellowTier
apm.bob_rework.lib.tier.list[1] = yellowTier