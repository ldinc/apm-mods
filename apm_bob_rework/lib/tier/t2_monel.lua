if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

local monelTier = {
    level = 2,
    constructionAlloy = apm.bob_rework.lib.entities.invar,
    extraConstructionAlloy = apm.bob_rework.lib.entities.iron,
    heatAlloy = apm.bob_rework.lib.entities.monel,
    logic = apm.bob_rework.lib.entities.logicElectronic,
    pipe = apm.bob_rework.lib.entities.ironPipe,
    heatPipe = apm.bob_rework.lib.entities.ironPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperPipe,
    basement = apm.bob_rework.lib.entities.concrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.ironGearWheel,
    bearing = apm.bob_rework.lib.entities.steelBearing,
    inserter = apm.bob_rework.lib.entities.redInserter,
    filterInserter = apm.bob_rework.lib.entities.redFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.redStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.redFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t2,
    underBelt = apm.bob_rework.lib.entities.underBelt_t2,
    splitter = apm.bob_rework.lib.entities.splitter_t2,
    loader = apm.bob_rework.lib.entities.loader_t2,
    pump = apm.bob_rework.lib.entities.pump_t2,
    wire=apm.bob_rework.lib.entities.copperCable,
    battery=apm.bob_rework.lib.entities.battery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe,
}



apm.bob_rework.lib.tier.monel = monelTier
apm.bob_rework.lib.tier.list[2] = monelTier