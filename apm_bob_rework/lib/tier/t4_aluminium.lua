if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

-- TODO
local aluminiumTier = {
    level = 4,
    constructionAlloy = apm.bob_rework.lib.entities.aluminium,
    extraConstructionAlloy = nil,
    heatAlloy = apm.bob_rework.lib.entities.siliconNitride,
    logic = apm.bob_rework.lib.entities.logicProcessing,
    pipe = apm.bob_rework.lib.entities.steelPipe,
    heatPipe = apm.bob_rework.lib.entities.ceramicPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperPipe,
    basement = apm.bob_rework.lib.entities.refinedConcrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.steelGearWheel,
    bearing = apm.bob_rework.lib.entities.ceramicBearing,
    inserter = apm.bob_rework.lib.entities.purpleInserter,
    filterInserter = apm.bob_rework.lib.entities.purpleFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.purpleStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.purpleFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t4,
    underBelt = apm.bob_rework.lib.entities.underBelt_t4,
    splitter = apm.bob_rework.lib.entities.splitter_t4,
    loader = apm.bob_rework.lib.entities.loader_t4,
    pump = apm.bob_rework.lib.entities.pump_t4,
    wire=apm.bob_rework.lib.entities.insulatedCable,
    battery=apm.bob_rework.lib.entities.silverZincBattery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe_t2,
}

apm.bob_rework.lib.tier.aluminium = aluminiumTier
apm.bob_rework.lib.tier.list[4] = aluminiumTier