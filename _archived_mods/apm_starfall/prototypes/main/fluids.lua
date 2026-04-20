require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/fluids.lua'

APM_LOG_HEADER(self)

data:extend(
{
    {
        type = "fluid",
        name = "apm_sulphurous_meteorite_solution",
        default_temperature = 40,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.296, g=0.011, b=0.522},
        flow_color = {r=0.792, g=0.988, b=0.011},
        icons = apm.lib.utils.icon.generate.fluid({r=0.296, g=0.011, b=0.522}, {r=0.792, g=0.988, b=0.011}, nil),
        icon_size = 32,
        group = "apm_starfall",
        subgroup = "apm_starfall_fluids",
        order = 'aa_a'
    },
    {
        type = "fluid",
        name = "apm_dissolved_meteorite_slurry",
        default_temperature = 70,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.234, g=0.031, b=0.300},
        flow_color = {r=0.302, g=0.031, b=0.388},
        icons = apm.lib.utils.icon.generate.fluid({r=0.234, g=0.031, b=0.300}, {r=0.302, g=0.031, b=0.388}, nil),
        icon_size = 32,
        group = "apm_starfall",
        subgroup = "apm_starfall_fluids",
        order = 'ae_a'
    },
    {
        type = "fluid",
        name = "apm_meteorite_copper_solution",
        default_temperature = 60,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.522, g=0.259, b=0.000},
        flow_color = {r=0.296, g=0.011, b=0.522},
        icons = apm.lib.utils.icon.generate.fluid({r=0.522, g=0.259, b=0.000}, {r=0.296, g=0.011, b=0.522}, nil),
        icon_size = 32,
        group = "apm_starfall",
        subgroup = "apm_starfall_fluids",
        order = 'ab_a'
    },
    {
        type = "fluid",
        name = "apm_meteorite_iron_solution",
        default_temperature = 60,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.000, g=0.388, b=0.522},
        flow_color = {r=0.296, g=0.011, b=0.522},
        icons = apm.lib.utils.icon.generate.fluid({r=0.000, g=0.388, b=0.522}, {r=0.296, g=0.011, b=0.522}, nil),
        icon_size = 32,
        group = "apm_starfall",
        subgroup = "apm_starfall_fluids",
        order = 'ac_a'
    },
    {
        type = "fluid",
        name = "apm_mixed_meteorite_slurry",
        default_temperature = 55,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.234, g=0.031, b=0.300},
        flow_color = {r=0.792, g=0.988, b=0.011},
        icons = apm.lib.utils.icon.generate.fluid({r=0.234, g=0.031, b=0.300}, {r=0.792, g=0.988, b=0.011}, nil),
        icon_size = 32,
        group = "apm_starfall",
        subgroup = "apm_starfall_fluids",
        order = 'ad_a'
    },
})
