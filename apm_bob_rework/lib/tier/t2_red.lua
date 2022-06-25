if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.entities.base')

local wire = require('lib.entities.wires')
local pump = require('lib.entities.pumps')

local redTier = {
    level  = 2,
    constructionAlloy = apm.bob_rework.lib.entities.invar,
    extraConstructionAlloy = apm.bob_rework.lib.entities.steel,
    heatAlloy = apm.bob_rework.lib.entities.monel,
    logic = apm.bob_rework.lib.entities.logicAdvanced,
    pipe = apm.bob_rework.lib.pipe.steel,
    heatPipe = apm.bob_rework.lib.pipe.iron,
    exchangePipe = apm.bob_rework.lib.pipe.copper,
    basement = apm.bob_rework.lib.entities.concrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.steelGearWheel,
    bearing = apm.bob_rework.lib.entities.steelBearing,
    inserter = apm.bob_rework.lib.entities.redInserter,
    filterInserter = apm.bob_rework.lib.entities.redFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.redStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.redFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t2,
    underBelt = apm.bob_rework.lib.entities.underBelt_t2,
    splitter = apm.bob_rework.lib.entities.splitter_t2,
    loader = apm.bob_rework.lib.entities.loader_t2,
    pump = pump.red,
    wire=wire.unsulated,
    battery=apm.bob_rework.lib.entities.lithiumIonBattery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe_t2,
}

apm.bob_rework.lib.tier.red = redTier
apm.bob_rework.lib.tier.list[2] = redTier