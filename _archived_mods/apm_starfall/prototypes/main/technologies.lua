require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/technologies.lua'

APM_LOG_HEADER(self)

-- Meteorite ore 1
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_meteorite_ore_1',
    {'apm_water_supply-1'},
    {'apm_meteorite_crushed_1'},
    {{"apm_industrial_science_pack", 1}},
    30, 15)

-- Fuel 1
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_fuel_1',
    {'apm_starfall_meteorite_ore_1', 'apm_fuel-1'},
    {'apm_alien_fuel_mixture', 'apm_alien_fuel_case', 'apm_alien_fuel', 'apm_alien_fuel_burnted_maintenance'},
    {{"apm_industrial_science_pack", 1}},
    50, 15)

-- Meteorite ore 2
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_meteorite_ore_2',
    {'apm_starfall_meteorite_ore_1', 'apm_tools_1'},
    {'apm_meteorite_crushed_2'},
    {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
    100, 30)

-- Catalysis 1
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_catalysis',
    {'apm_starfall_meteorite_ore_1', 'advanced-material-processing', 'sulfur-processing'},
    {'apm_sulphurous_meteorite_solution', 'apm_dissolved_meteorite_slurry_desulfurize', 'apm_metal_catalyst_frame',
        'apm_metal_catalyst_copper', 'apm_metal_catalyst_iron', 'apm_metal_catalyst_frame_used_maintenance',
        'apm_meteorite_iron_solution_catalyse', 'apm_meteorite_copper_solution_catalyse', 'apm_meteorite_copper_solution_centrifuging',
        'apm_meteorite_iron_solution_centrifuging'},
    {{"automation-science-pack", 1}, {"logistic-science-pack", 1}},
    150, 30)

-- Catalysis 2
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_catalysis-2',
    {'apm_starfall_catalysis', 'advanced-material-processing-2'},
    {'apm_mixed_meteorite_slurry', 'apm_mixed_meteorite_slurry_centrifuging_1'},
    {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}},
    250, 30)

-- Catalysis 3
apm.lib.utils.technology.new('apm_starfall',
    'apm_starfall_catalysis-3',
    {'apm_starfall_catalysis-2', 'production-science-pack'},
    {'apm_mixed_meteorite_slurry_centrifuging_2'},
    {{"automation-science-pack", 1}, {"logistic-science-pack", 1}, {"chemical-science-pack", 1}, {"production-science-pack", 1}},
    300, 30)
