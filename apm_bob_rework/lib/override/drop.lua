if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.enities.base')

apm.bob_rework.lib.override.drop = function ()
    local rm = apm.lib.utils.recipe.remove
    rm('apm_gearing')
    rm(apm.bob_rework.lib.entities.machineFrame)
    rm(apm.bob_rework.lib.entities.steamMachineFrame)
    rm(apm.bob_rework.lib.entities.advancedMachineFrame)

    rm('boiler-2-from-oil-boiler')
    rm('boiler-3-from-heat-exchanger')
    rm('boiler-3-from-oil-boiler-2')
    rm('boiler-4-from-heat-exchanger-2')
    rm('boiler-4-from-oil-boiler-3')
    rm('boiler-5-from-heat-exchanger-4')
    rm('boiler-5-from-heat-exchanger-3')
    rm('boiler-5-from-oil-boiler-4')
    rm('oil-boiler-2-from-boiler-3')
    rm('oil-boiler-3-from-boiler-4')
    rm('oil-boiler-4-from-boiler-5')

    rm('bob-area-mining-drill-1')
    rm('bob-area-mining-drill-2')
    rm('bob-area-mining-drill-3')
    rm('bob-area-mining-drill-4')

    rm('stone-furnace-from-stone-chemical-furnace')
    rm('stone-furnace-from-stone-mixing-furnace')
    rm('steel-furnace-from-fluid-furnace')
    rm('steel-furnace-from-steel-chemical-furnace')
    rm('steel-furnace-from-steel-mixing-furnace')
    rm('steel-furnace-from-fluid-mixing-furnace')
    rm('electric-furnace-from-electric-chemical-furnace')
    rm('electric-furnace-from-electric-mixing-furnace')
    rm('stone-chemical-furnace-from-stone-furnace')
    rm('steel-chemical-furnace-from-fluid-chemical-furnace')
    rm('steel-chemical-furnace-from-steel-furnace')
    rm('steel-chemical-furnace-from-fluid-furnace')
    rm('stone-mixing-furnace-from-stone-furnace')
    rm('steel-mixing-furnace-from-fluid-mixing-furnace')
    rm('steel-mixing-furnace-from-steel-furnace')
    rm('steel-mixing-furnace-from-fluid-furnace')
    rm('electric-chemical-furnace-from-electric-furnace')
    rm('electric-mixing-furnace-from-electric-furnace')
    rm('fluid-furnace-from-fluid-chemical-furnace')
    rm('fluid-furnace-from-fluid-mixing-furnace')
    rm('fluid-chemical-furnace-from-fluid-furnace')
    rm('fluid-mixing-furnace-from-fluid-furnace')

    rm('offshore-pump')

    rm('heat-exchanger-2-from-boiler-4')
    rm('heat-exchanger-3-from-boiler-5')
    rm('fluid-reactor-from-fluid-furnace')

    rm('stone-furnace')
    rm('steel-furnace')
    rm('fluid-furnace')
    rm('electric-furnace')
    rm('electric-furnace-2')
    rm('electric-furnace-3')

    rm(apm.bob_rework.lib.entities.stonePipe)
    rm(apm.bob_rework.lib.entities.nitinolPipe)
    rm(apm.bob_rework.lib.entities.nitinolUnderPipe)
    rm(apm.bob_rework.lib.entities.stoneUnderPipe)
end