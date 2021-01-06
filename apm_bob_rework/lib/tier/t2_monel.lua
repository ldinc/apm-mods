if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

require('lib.enities.base')

local monelTier = {
    level = 2,
    main = {
        alloy = apm.bob_rework.lib.entities.monel,
        lightAlloy = apm.bob_rework.lib.entities.invar,
        logic = apm.bob_rework.lib.entities.logicElectronic,
        pipe = apm.bob_rework.lib.entities.ironPipe,
        frame = apm.bob_rework.lib.entities.advancedMachineFrame,
        basement = apm.bob_rework.lib.entities.stoneBrick,
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
    }
}

apm.bob_rework.lib.tier.monel = monelTier
apm.bob_rework.lib.tier.list[2] = monelTier
