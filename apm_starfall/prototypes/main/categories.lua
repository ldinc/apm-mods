require('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/main/categories.lua'

APM_LOG_HEADER(self)

-- Action ---------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
 apm.lib.utils.category.create.group('apm_starfall', '__apm_resource_pack_ldinc__/graphics/categories/apm_starfall.png', '20')
	 apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_res', 'aa_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_res_fluid', 'aa_a')
	 apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_fluids', 'aa_b')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_ore', 'ab_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_fuel', 'ac_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_catalysts', 'ad_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_ore_processing', 'ae_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_centrifuging', 'af_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_machines', 'ag_a')
     apm.lib.utils.category.create.subgroup('apm_starfall', 'apm_starfall_other', 'zz_a')