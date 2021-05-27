if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

local steelTier = {
    level = 3,
    constructionAlloy = apm.bob_rework.lib.entities.steel,
    extraConstructionAlloy = apm.bob_rework.lib.entities.siliconNitride,
    heatAlloy = apm.bob_rework.lib.entities.siliconNitride,
    logic = apm.bob_rework.lib.entities.logicAdvanced,
    pipe = apm.bob_rework.lib.entities.steelPipe,
    heatPipe = apm.bob_rework.lib.entities.ceramicPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperPipe,
    basement = apm.bob_rework.lib.entities.concrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.steelGearWheel,
    bearing = apm.bob_rework.lib.entities.ceramicBearing,
    inserter = apm.bob_rework.lib.entities.blueInserter,
    filterInserter = apm.bob_rework.lib.entities.blueFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.blueStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.blueFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t3,
    underBelt = apm.bob_rework.lib.entities.underBelt_t3,
    splitter = apm.bob_rework.lib.entities.splitter_t3,
    loader = apm.bob_rework.lib.entities.loader_t3,
    pump = apm.bob_rework.lib.entities.pump_t3,
    wire=apm.bob_rework.lib.entities.tinnedCopperCable,
    battery=apm.bob_rework.lib.entities.lithiumIonBattery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe,
}

apm.bob_rework.lib.tier.steel = steelTier
apm.bob_rework.lib.tier.list[3] = steelTier