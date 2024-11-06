require('util')
require('__apm_lib_ldinc__.lib.log')
require('__apm_lib_ldinc__.lib.utils')

local self = 'apm_power/prototypes/main/offshore_pumps.lua'

APM_LOG_HEADER(self)

local smoke_burner = {
	apm.lib.utils.builders.smoke.new(
		"apm_dark_smoke",
		{ 0.1, 0.1 },
		10,
		{ 0, 0 },
		nil,
		0.08,
		60,
		1
	)
}

local smoke_steam = {
	apm.lib.utils.builders.smoke.new(
		"apm_light_smoke",
		{ 0.1, 0.1 },
		8,
		{ 0, 0 },
		nil,
		0.08,
		60,
		1
	)
}

local item_icon_a = apm.lib.utils.icon.get.from_item('offshore-pump')

local offshore_pump_base = table.deepcopy(data.raw['offshore-pump']['offshore-pump'])

offshore_pump_base.name = "apm_offshore_pump_0"
offshore_pump_base.minable = { mining_time = 0.1, result = "apm_offshore_pump_0" }
offshore_pump_base.localised_description = { "entity-description.apm_offshore_pump" }

offshore_pump_base.fluid_box = apm.lib.utils.builders.fluid_box.new(
	"output",
	100,
	nil,
	defines.direction.south,
	{ 0, 0 },
	nil
)


offshore_pump_base.pumping_speed = 2.5
offshore_pump_base.fast_replaceable_group = "apm_offshore_pump"
offshore_pump_base.next_upgrade = "apm_offshore_pump_1"
offshore_pump_base.energy_usage = apm.power.constants.energy_usage.burner

offshore_pump_base.energy_source = apm.lib.utils.builders.energy_source.new_burner(
	{ 'chemical', 'apm_refined_chemical' },
	apm.power.constants.emissions.offpump_0,
	smoke_burner
)

data:extend({ offshore_pump_base })

local item_icon_b = { apm.lib.icons.dynamics.t1 }
local icons = apm.lib.utils.icon.merge({ item_icon_a, item_icon_b })
local offshore_pump = table.deepcopy(offshore_pump_base)
offshore_pump.name = "apm_offshore_pump_1"
offshore_pump.icons = icons
offshore_pump.localised_description = { "entity-description.apm_offshore_pump" }
offshore_pump.energy_usage = apm.power.constants.energy_usage.electric

offshore_pump.energy_source = apm.lib.utils.builders.energy_source.new_electric(apm.power.constants.emissions.offpump_1)

offshore_pump.collision_box = offshore_pump_base.collision_box
offshore_pump.selection_box = offshore_pump_base.selection_box
offshore_pump.minable = { mining_time = 0.1, result = "apm_offshore_pump_1" }
offshore_pump.fast_replaceable_group = "apm_offshore_pump"
offshore_pump.next_upgrade = nil
-- offshore_pump.max_health = 100
offshore_pump.pumping_speed = 6.66666668
-- offshore_pump.fluid = "apm_sea_water"

offshore_pump_base.fluid_box = apm.lib.utils.builders.fluid_box.new(
	"output",
	100,
	nil,
	defines.direction.south,
	{ 0, 0 },
	nil
)

data:extend({ offshore_pump })
