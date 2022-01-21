if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

local titaniumTier = {
    level = 5,
    constructionAlloy = apm.bob_rework.lib.entities.titanium,
    extraConstructionAlloy = apm.bob_rework.lib.entities.tungstenCarbide,
    heatAlloy = apm.bob_rework.lib.entities.copperTungsten,
    logic = apm.bob_rework.lib.entities.logicAPU,
    pipe = apm.bob_rework.lib.entities.titaniumPipe,
    heatPipe = apm.bob_rework.lib.entities.copperTungstenPipe,
    exchangePipe = apm.bob_rework.lib.entities.copperTungstenPipe,
    basement = apm.bob_rework.lib.entities.refinedConcrete,
    basementK = 1,
    engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
    gearWheel = apm.bob_rework.lib.entities.titaniumGearWheel,
    bearing = apm.bob_rework.lib.entities.titaniumBearing,
    inserter = apm.bob_rework.lib.entities.greenInserter,
    filterInserter = apm.bob_rework.lib.entities.greenFilterInserter,
    stackInserter = apm.bob_rework.lib.entities.greenStackInserter,
    stackFilterInserter = apm.bob_rework.lib.entities.greenFilterStackInserter,
    belt = apm.bob_rework.lib.entities.belt_t5,
    underBelt = apm.bob_rework.lib.entities.underBelt_t5,
    splitter = apm.bob_rework.lib.entities.splitter_t5,
    loader = apm.bob_rework.lib.entities.loader_t5,
    pump = apm.bob_rework.lib.entities.pump_t5,
    wire=apm.bob_rework.lib.entities.gildedCopperCable,
    battery=apm.bob_rework.lib.entities.silverZincBattery,
    heatProvider=apm.bob_rework.lib.entities.heatPipe_t3,
}

apm.bob_rework.lib.tier.titanium = titaniumTier
apm.bob_rework.lib.tier.list[5] = titaniumTier