require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/technologies.lua'

APM_LOG_HEADER(self)

apm.lib.utils.technology.new(
	'apm_recycling',
	'apm_recycling-0',
	{},
	{ 'apm_recycling_machine_0', 'apm_cleaning_solution', 'apm_dirty_cleaning_solution_reprocessing' },
	nil,
	apm.lib.utils.technology.new_unit(
		{ "automation-science-pack" },
		10,
		15
	)
)

apm.lib.utils.technology.new('apm_recycling',
	'apm_recycling-1',
	{ 'apm_recycling-0', 'automation', 'logistic-science-pack', 'fluid-handling' },
	{ 'apm_recycling_machine_1' },
	nil,
	apm.lib.utils.technology.new_unit(
		{ "automation-science-pack", "logistic-science-pack" },
		50,
		25
	)
)

apm.lib.utils.technology.new('apm_recycling',
	'apm_recycling-2',
	{ 'apm_recycling-1', 'chemical-science-pack' },
	{ 'apm_recycling_machine_2' },
	nil,
	apm.lib.utils.technology.new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack" },
		150,
		35
	)
)


apm.lib.utils.technology.new('apm_recycling',
	'apm_recycling-3',
	{ 'apm_recycling-2', 'production-science-pack', 'processing-unit', 'efficiency-module-2' },
	{ 'apm_recycling_machine_3' },
	nil,
	apm.lib.utils.technology.new_unit(
		{ "automation-science-pack", "logistic-science-pack", "chemical-science-pack", "production-science-pack" },
		200,
		45
	)
)
