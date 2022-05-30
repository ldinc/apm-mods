require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/fluids.lua'

APM_LOG_HEADER(self)

data:extend(
{
    {
        type = "fluid",
        name = "apm_cleaning_solution",
        default_temperature = 15,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.343, g=0.819, b=0.634},
        flow_color = {r=0.672, g=0.813, b=0.756},
        icons = apm.lib.utils.icon.generate.fluid({r=0.343, g=0.819, b=0.634}, {r=0.672, g=0.813, b=0.756}),
        group = "apm_recycling",
        subgroup = "apm_recycling_fluid",
        order = 'aa_a'
    },
    {
        type = "fluid",
        name = "apm_dirty_cleaning_solution",
        default_temperature = 15,
        max_temperature = 100,
        heat_capacity = "0.2KJ",
        base_color = {r=0.522, g=0.497, b=0.274},
        flow_color = {r=0.715, g=0.584, b=0.454},
        icons = apm.lib.utils.icon.generate.fluid({r=0.522, g=0.497, b=0.274}, {r=0.715, g=0.584, b=0.454}),
        group = "apm_recycling",
        subgroup = "apm_recycling_fluid",
        order = 'aa_b'
    },
})
