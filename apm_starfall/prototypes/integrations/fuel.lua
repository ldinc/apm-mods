require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/integrations/fuel.lua'

APM_LOG_HEADER(self)

local apm_starfall_compat_bob = settings.startup["apm_starfall_compat_bob"].value
local apm_starfall_compat_angel = settings.startup["apm_starfall_compat_angel"].value
local apm_starfall_compat_earendel = settings.startup["apm_starfall_compat_earendel"].value
local apm_starfall_compat_reverse_factory = settings.startup["apm_starfall_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_starfall_compat_bob', apm_starfall_compat_bob)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_angel', apm_starfall_compat_angel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_earendel', apm_starfall_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_reverse_factory', apm_starfall_compat_reverse_factory)

APM_LOG_INFO(self, '', 'BEGIN: add alien fuel categories')
apm.lib.utils.entities.add.fuel_category_with_conditional('assembling-machine', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('assembling-machine', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all inserter if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('inserter', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('inserter', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all labs if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('lab', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('lab', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all furnace if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('furnace', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('furnace', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all generators if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('generator', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('generator', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all boiler if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('boiler', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('boiler', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all mining-drill if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('mining-drill', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('mining-drill', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on allpump if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('pump', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('pump', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on allpump if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('reactor', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('reactor', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on allpump if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('generator-equipment', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('generator-equipment', 'apm_refined_chemical', 'apm_starfall_alien')

apm.lib.utils.description.entities.update()
