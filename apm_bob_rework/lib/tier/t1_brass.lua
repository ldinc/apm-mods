if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local brassTier = {
    level = 1,
    main = {
        alloy = apm.bob_rework.lib.entities.brass,
        lightAlloy = apm.bob_rework.lib.entities.copper,
        logic = apm.bob_rework.lib.entities.logicSteam,
        pipe = apm.bob_rework.lib.entities.brassPipe,
        frame = apm.bob_rework.lib.entities.steamMachineFrame,
        basement = apm.bob_rework.lib.entities.stoneBrick,
        basementK = 1,
        engineUnit = apm.bob_rework.lib.entities.steamEngineUnit,
        gearWheel = apm.bob_rework.lib.entities.brassGearWheel,
        bearing = apm.bob_rework.lib.entities.brassBearing,
        inserter = apm.bob_rework.lib.entities.steamInserter,
        filterInserter = nil,
        stackInserter = nil,
        stackFilterInserter = nil,
        belt = apm.bob_rework.lib.entities.belt_t1,
        underBelt = apm.bob_rework.lib.entities.underBelt_t1,
        splitter = apm.bob_rework.lib.entities.splitter_t1,
        loader = apm.bob_rework.lib.entities.loader_t1,
        pump = apm.bob_rework.lib.entities.burnerPump,
    }
}

apm.bob_rework.lib.tier.brass = brassTier
apm.bob_rework.lib.tier.list[1] = brassTier