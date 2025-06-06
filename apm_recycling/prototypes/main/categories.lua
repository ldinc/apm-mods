require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_recycling/prototypes/main/categories.lua'

APM_LOG_HEADER(self)

-- Action ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
apm.lib.utils.category.create.group(
	'apm_recycling',
	'__apm_resource_pack_ldinc__/graphics/categories/apm_recycling.png',
	'10'
)
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_fluid', 'a_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_scrap_metal_box', 'a_b')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_raw_solid', 'b_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_processing_fluid', 'c_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_processing_solid', 'd_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_scrap_processed', 'e_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_scrap_processed_smelting_easy', 'f_a')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_scrap_processed_smelting', 'f_b')
apm.lib.utils.category.create.subgroup('apm_recycling', 'apm_recycling_machines', 'g_a')
