if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end

apm.bob_rework.lib.entities.logicBasic = 'apm_mechanical_relay'
apm.bob_rework.lib.entities.logicSteam = 'apm_steam_relay'
apm.bob_rework.lib.entities.logicContact = 'basic-circuit-board'
apm.bob_rework.lib.entities.logicElectronic = 'electronic-circuit'
apm.bob_rework.lib.entities.logicAdvanced = 'advanced-circuit'
apm.bob_rework.lib.entities.logicProcessing = 'processing-unit'
apm.bob_rework.lib.entities.logicAPU = 'advanced-processing-unit'

local logics = {
    mechanical = 'apm_mechanical_relay',
    steam = 'apm_steam_relay',

    circuit = {
        low = 'basic-circuit-board',
        basic = 'electronic-circuit',
        advanced = 'advanced-circuit',
    },
    PU = 'processing-unit',
    APU = 'advanced-processing-unit',
}

return logics