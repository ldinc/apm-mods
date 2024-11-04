require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/pumps.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		4,
		nil,
		{
			north = { 0.0, 0.0 },
			south = { 0.0, -1.0 },
			east = { -0.8, -0.55 },
			west = { 0.8, -0.55 },
		},
		0.08,
		60,
		1
	)
}

local item_icon_a = apm.lib.utils.icon.get.from_item('pump')
local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })

local pump = table.deepcopy(data.raw.pump['pump'])
pump.name = 'apm_pump_0'
pump.icons = icons
--pump.icon_size = 32
pump.flags = { "placeable-neutral", "placeable-player", "player-creation" }
pump.minable = { mining_time = 0.2, result = "apm_pump_0" }

pump.energy_usage = apm.power.constants.energy_usage.burner

pump.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	{ pollution = 2.5 },
	smoke_burner
)

pump.pumping_speed = 10

pump.animations.north.filename = '__apm_resource_pack_ldinc__/graphics/entities/pumps/hr_pump_north_0.png'

pump.animations.east.filename = '__apm_resource_pack_ldinc__/graphics/entities/pumps/hr_pump_east_0.png'

pump.animations.south.filename = '__apm_resource_pack_ldinc__/graphics/entities/pumps/hr_pump_south_0.png'

pump.animations.west.filename = '__apm_resource_pack_ldinc__/graphics/entities/pumps/hr_pump_west_0.png'

data:extend({ pump })
