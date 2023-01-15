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
    local g = data.raw["generator"][name]
    g.energy_source.effectivity = eff
    g.effectivity = eff
    g.max_power_output = maxPower
    g.fluid_usage_per_tick  = fpt
end

function turbine(name, eff, maxPower, fpt)
    local g = data.raw["generator"][name]
    g.effectivity = eff
    g.max_power_output = maxPower
    g.fluid_usage_per_tick  = fpt
end

function fgen(name, eff, maxPower)
    local g = data.raw["generator"][name]
    g.effectivity = eff
    g.max_power_output = maxPower
end

function boiler(name, eff, maxPower)
    local g = data.raw["boiler"][name]
    g.energy_source.effectivity = eff
    g.energy_consumption = maxPower
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


apm.bob_rework.lib.override.power = function ()
    if settings.startup['apm_bob_rework_replace_filter'].value == false then
        return
    end

    bgen("bob-burner-generator", 0.11, "500kW")
    gen("steam-engine", 0.3, "500kW", 1.5)
    gen("steam-engine-2", 0.33, "1000kW", 1.1)
    gen("steam-engine-3", 0.36, "1500kW", 1)
    gen("steam-engine-4", 0.39, "2000kW", 0.8)
    gen("steam-engine-5", 0.42, "3000kW", 0.9)

    turbine("steam-turbine", 0.6, "4500kW", 1.5)
    turbine("steam-turbine-2", 0.65, "7500kW", 1.7)
    turbine("steam-turbine-3", 0.7, "10000kW", 1.7)

    fgen("fluid-generator", 0.4, "1500kW")
    fgen("fluid-generator-2", 0.43, "2000kW")
    fgen("fluid-generator-3", 0.46, "2500kW")
    fgen("hydrazine-generator", 0.49, "8000kW")

    boiler("boiler", 0.8, "4180kW")
    boiler("boiler-2", 0.83, "7304kW")
    boiler("boiler-3", 0.86, "9691kW")
    boiler("boiler-4", 0.89, "11526kW")
    boiler("boiler-5", 0.92, "15529kW")
    boiler("electric-boiler", 0.9, "3705kW")
    -- fluid boilers
    boiler("oil-boiler", 0.83, "7304kW")
    boiler("oil-boiler-2", 0.86, "9691kW")
    boiler("oil-boiler-3", 0.89, "11526kW")
    boiler("oil-boiler-4", 0.92, "15529kW")
    -- heat exchangers
    boiler("heat-exchanger",   0.8,  "19000kW")
    boiler("heat-exchanger-2", 0.85, "28000kW")
    boiler("heat-exchanger-3", 0.9,  "32000kW")

    reactor("burner-reactor", 0.8, "15000kW", 0.2)
    -- reactor("burner-reactor-2", 0.85, "21000kW", 0.4)
    -- reactor("burner-reactor-3", 0.9, "25000kW", 0.6)
    reactor("fluid-reactor", 0.8, "15000kW", 0.2)
    -- reactor("fluid-reactor-2", 0.85, "21000kW", 0.4)
    -- reactor("fluid-reactor-3", 0.9, "25000  kW", 0.6)
end