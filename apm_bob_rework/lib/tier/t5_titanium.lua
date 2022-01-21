if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

local titaniumTier = {
    level = 6,
    main = {
        alloy = apm.bob_rework.lib.entities.tungsten,
        lightAlloy = apm.bob_rework.lib.entities.titanium,
        logic = apm.bob_rework.lib.entities.logicElectronicProcessing,
        pipe = apm.bob_rework.lib.entities.titaniumPipe,
        frame = apm.bob_rework.lib.entities.advancedMachineFrame,
        basement = apm.bob_rework.lib.entities.refinedConcrete,
        basementK = 1,
        engineUnit = apm.bob_rework.lib.entities.electricEngineUnit,
        gearWheel = apm.bob_rework.lib.entities.titanuimGearWheel,
        bearing = apm.bob_rework.lib.entities.titaniumBearing,
        inserter = apm.bob_rework.lib.entities.greenInserter,
        filterInserter = apm.bob_rework.lib.entities.greenFilterInserter,
        stackInserter = apm.bob_rework.lib.entities.greenStackInserter,
        stackFilterInserter = apm.bob_rework.lib.entities.greenFilterStackInserter,
        belt = apm.bob_rework.lib.entities.belt_t6,
        underBelt = apm.bob_rework.lib.entities.underBelt_t6,
        splitter = apm.bob_rework.lib.entities.splitter_t6,
        loader = apm.bob_rework.lib.entities.loader_t6,
        pump = apm.bob_rework.lib.entities.pump_t6,
    }
}

apm.bob_rework.lib.tier.titanium = titaniumTier
apm.bob_rework.lib.tier.list[2] = titaniumTier
