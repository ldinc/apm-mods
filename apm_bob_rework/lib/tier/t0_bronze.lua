if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.tier == nil then apm.bob_rework.lib.tier = {} end
if apm.bob_rework.lib.tier.list == nil then apm.bob_rework.lib.tier.list = {} end

local bronzeTier = {
    level = 0,
    main = {
        alloy = apm.bob_rework.lib.entities.bronze,
        logic = apm.bob_rework.lib.entities.logicBasic,
        pipe = apm.bob_rework.lib.entities.bronzePipe,
        frame = apm.bob_rework.lib.entities.machineFrame,
        basement = apm.bob_rework.lib.entities.stone,
        basementK = 3,
        engineUnit = apm.bob_rework.lib.entities.simpleEngineUnit,
    }
}

apm.bob_rework.lib.tier.bronze = bronzeTier
apm.bob_rework.lib.tier.list[0] = bronzeTier
