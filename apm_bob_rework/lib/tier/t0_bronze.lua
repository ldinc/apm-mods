if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local bronzeTier = {
    level = 0,
    main = {
        alloy = apm.bob_rework.lib.entities.bronze,
        lightAlloy = apm.bob_rework.lib.entities.copper,
        logic = apm.bob_rework.lib.entities.logicBasic,
        pipe = apm.bob_rework.lib.entities.bronzePipe,
        frame = apm.bob_rework.lib.entities.machineFrame,
        basement = apm.bob_rework.lib.entities.stone,
        basementK = 3,
        engineUnit = apm.bob_rework.lib.entities.simpleEngineUnit,
        gearWheel = apm.bob_rework.lib.entities.bronzeGearWheel,
        bearing = apm.bob_rework.lib.entities.bronzeBearing,
        inserter = apm.bob_rework.lib.entities.burnerInserter,
        filterInserter = apm.bob_rework.lib.entities.burnerFilterInserter,
        stackInserter = nil,
        stackFilterInserter = nil,
        belt = apm.bob_rework.lib.entities.belt_t0,
        underBelt = apm.bob_rework.lib.entities.underBelt_t0,
        splitter = apm.bob_rework.lib.entities.splitter_t0,
        loader = apm.bob_rework.lib.entities.loader_t0,
        pump = apm.bob_rework.lib.entities.burnerPump,
    }
}

apm.bob_rework.lib.tier.bronze = bronzeTier
apm.bob_rework.lib.tier.list[0] = bronzeTier
