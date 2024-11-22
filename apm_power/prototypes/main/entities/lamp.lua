require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local burner_lamp = table.deepcopy(data.raw["lamp"]["small-lamp"])

burner_lamp.name = "apm_burner_lamp"

burner_lamp.energy_source = apm.lib.utils.builders.energy_source.new_burner({"chemical"})

-- data:extend({burner_lamp})