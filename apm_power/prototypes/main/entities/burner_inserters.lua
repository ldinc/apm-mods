require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_power/prototypes/main/burner_inserters.lua'

APM_LOG_HEADER(self)

-- NOTE: With factorio 2.0 all inserters with filter
-- Clone of electric long hand inserter & original burner insterter wuth updated graphics

local burner_long_inserter = table.deepcopy(data.raw.inserter['burner-inserter'])
burner_long_inserter.name = 'apm_burner_long_inserter'
burner_long_inserter.icon = '__apm_resource_pack_ldinc__/graphics/icons/apm_burner_long_inserter.png'
burner_long_inserter.minable = { mining_time = 0.1, result = "apm_burner_long_inserter" }
burner_long_inserter.energy_per_movement = "38836.3636363J"
burner_long_inserter.energy_per_rotation = "120000J"
burner_long_inserter.hand_size = 1.5
burner_long_inserter.extension_speed = 0.018 -- electric: 0.02
burner_long_inserter.rotation_speed = 0.0119 -- electric: 0.0457
burner_long_inserter.pickup_position = { 0, -2 }
burner_long_inserter.insert_position = { 0, 2.2 }

burner_long_inserter.hand_base_picture.filename =
'__apm_resource_pack_ldinc__/graphics/entities/burner_long_inserter/hr-inserter-hand-base.png'

burner_long_inserter.hand_closed_picture.filename =
'__apm_resource_pack_ldinc__/graphics/entities/burner_long_inserter/hr-inserter-hand-closed.png'

burner_long_inserter.hand_open_picture.filename =
'__apm_resource_pack_ldinc__/graphics/entities/burner_long_inserter/hr-inserter-hand-open.png'

burner_long_inserter.platform_picture.sheet.filename =
'__apm_resource_pack_ldinc__/graphics/entities/burner_long_inserter/hr-inserter-platform.png'

data:extend({ burner_long_inserter })