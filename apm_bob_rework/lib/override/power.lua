if apm.bob_rework.lib == nil then apm.bob_rework.lib = {} end
if apm.bob_rework.lib.override == nil then apm.bob_rework.lib.override = {} end
if apm.bob_rework.lib.override.list == nil then apm.bob_rework.lib.override.list = {} end

require('lib.entities.base')
require('lib.tier.base')
require('lib.utils.debug')

function bgen(name, eff, maxPower)
    local g = data.raw["burner-generator"][name]
    g.burner.effectivity = eff
    g.max_power_output = maxPower
end

function gen(name, eff, maxPower, fpt)
    local g                     = data.raw["generator"][name]
    g.energy_source.effectivity = eff
    g.effectivity               = eff
    g.max_power_output          = maxPower
    g.fluid_usage_per_tick      = fpt
end

function turbine(name, eff, maxPower, fpt)
    local g                = data.raw["generator"][name]
    g.effectivity          = eff
    g.max_power_output     = maxPower
    g.fluid_usage_per_tick = fpt

    -- apm.lib.utils.debug.object(g)
end

function fgen(name, eff, maxPower, fpt)
    local g = data.raw["generator"][name]
    g.effectivity = eff
    g.max_power_output = maxPower
    if fpt ~= nil then
        g.fluid_usage_per_tick = fpt
    end
end

function boiler(name, eff, maxPower, minTemp, maxTemp, targetTemp)
    local g = data.raw["boiler"][name]
    g.energy_source.effectivity = eff
    g.energy_consumption = maxPower

    if maxTemp ~= nil and minTemp ~= nil then
        apm.lib.utils.debug.object(g)
        g.energy_source.max_temperature = maxTemp
        g.energy_source.minimum_working_temperature = minTemp + 30
        g.energy_source.minimum_glow_temperature = minTemp + 30
    end

    if targetTemp ~= nil then
        g.target_temperature = targetTemp
    end
end

-- function breactor(name, eff, maxPower, nb)
--     local g = data.raw["reactor"][name]
--     g.energy_source.effectivity = eff
--     g.energy_consumption = maxPower
--     g.neighbour_bonus = nb
-- end

function reactor(name, eff, maxPower, nb)
    local g = data.raw["reactor"][name]
    g.energy_source.effectivity = eff
    g.energy_consumption = maxPower
    g.neighbour_bonus = nb
end

function updateFluidBoiler(name, targetTemp, fluidUsage)
    local entity = data.raw['boiler'][name]

    entity.target_temperature = targetTemp
    -- if fluidUsage ~= nil then
    --     entity.energy_source.fluid_usage_per_tick = fluidUsage
    -- end
end

apm.bob_rework.lib.override.power = function()
    if settings.startup['apm_bob_rework_replace_filter'].value == false then
        return
    end

    bgen("bob-burner-generator", 0.15, "500kW")
    gen("steam-engine", 0.3, "500kW", 1.5)
    gen("steam-engine-2", 0.39, "1000kW", 0.9)
    gen("steam-engine-3", 0.36, "1500kW", 1)
    gen("steam-engine-4", 0.39, "2000kW", 0.8)
    gen("steam-engine-5", 0.42, "3000kW", 0.9)

    turbine("steam-turbine", 0.7, "7500kW", 2)
    turbine("steam-turbine-2", 0.65, "25000kW", 1.7)
    turbine("steam-turbine-3", 0.7, "40000kW", 1.7)

    fgen("fluid-generator", 0.45, "2500kW")
    fgen("fluid-generator-2", 0.43, "2500kW")
    fgen("fluid-generator-3", 0.46, "3500kW")
    fgen("hydrazine-generator", 0.65, "8000kW", 0.7)

    boiler("boiler", 0.8, "7600kW")
    boiler("boiler-2", 0.83, "11000kW")
    boiler("boiler-3", 0.86, "9691kW")
    boiler("boiler-4", 0.89, "11526kW")
    boiler("boiler-5", 0.92, "15529kW")
    boiler("electric-boiler", 0.9, "3705kW")
    -- fluid boilers
    boiler("oil-boiler", 0.83, "7550kW")
    updateFluidBoiler('oil-boiler', 120, 1.0)

    boiler("oil-boiler-2", 0.86, "11000kW")
    updateFluidBoiler('oil-boiler-2', 270, 1.0)

    boiler("oil-boiler-3", 0.89, "11526kW")
    boiler("oil-boiler-4", 0.92, "15529kW")
    -- heat exchangers
    boiler("heat-exchanger", 0.8, "44000kW", 400, 500, 470)
    boiler("heat-exchanger-2", 0.85, "28000kW")
    boiler("heat-exchanger-3", 0.9, "32000kW")

    reactor("burner-reactor", 0.8, "15000kW", 0.2)
    -- reactor("burner-reactor-2", 0.85, "21000kW", 0.4)
    -- reactor("burner-reactor-3", 0.9, "25000kW", 0.6)
    reactor("fluid-reactor", 0.8, "15000kW", 0.2)
    -- reactor("fluid-reactor-2", 0.85, "21000kW", 0.4)
    -- reactor("fluid-reactor-3", 0.9, "25000  kW", 0.6)
end
