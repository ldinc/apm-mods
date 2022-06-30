if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.entities == nil then apm.bob_rework.lib.entities = {} end
if apm.bob_rework.lib.entities.nuclear == nil then apm.bob_rework.lib.entities.nuclear = {} end

apm.bob_rework.lib.entities.nuclear.deuterium = {}
apm.bob_rework.lib.entities.nuclear.deuterium.cell = { I = 'deuterium-fuel-cell' }
apm.bob_rework.lib.entities.nuclear.deuterium.cell = { II = 'deuterium-fuel-cell-2' }

apm.bob_rework.lib.entities.nuclear.fusionCatalyst = 'fusion-catalyst'

return {
    fusion = {catalyst = 'fusion-catalyst'},
    deuterium = {
        cell = {
            I = 'deuterium-fuel-cell',
            II = 'deuterium-fuel-cell-2',
        }
    },
    rtg = 'rtg',
}