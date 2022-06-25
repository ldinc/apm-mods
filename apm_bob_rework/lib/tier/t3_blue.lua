if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.entities.base')
local wire = require('lib.entities.wires')
local pump = require('lib.entities.pumps')

local blueTier = {
    level = 3,
    constructionAlloy = apm.bob_rework.lib.entities.titaniumAlloy,
    extraConstructionAlloy = apm.bob_rework.lib.entities.tungstenCarbide,
    heatAlloy = apm.bob_rework.lib.entities.copperTungsten,
    logic = apm.bob_rework.lib.entities.logicProcessing,
    extraLogic = apm.bob_rework.lib.entities.logicAPU,
    pipe = apm.bob_rework.lib.pipe.titaniumAlloy,
    heatPipe = apm.bob_rework.lib.entities.ceramicPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperTungstenPipe,
    basement = apm.bob_rework.lib.entities.refinedConcrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.titaniumGearWheel,
    bearing = apm.bob_rework.lib.entities.titaniumBearing,
    inserter = apm.bob_rework.lib.entities.blueInserter,
    filterInserter = apm.bob_rework.lib.entities.blueFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.blueStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.blueFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t3,
    underBelt = apm.bob_rework.lib.entities.underBelt_t3,
    splitter = apm.bob_rework.lib.entities.splitter_t3,
    loader = apm.bob_rework.lib.entities.loader_t3,
    pump = pump.blue,
    wire=wire.gilded.copper,
    battery=apm.bob_rework.lib.entities.silverZincBattery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe_t3,
}

apm.bob_rework.lib.tier.blue = blueTier
apm.bob_rework.lib.tier.list[3] = blueTier