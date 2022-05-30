require ('util')
require('__apm_lib_ldinc__.lib.log')

local self = 'apm_starfall/prototypes/integrations/recipes.lua'

APM_LOG_HEADER(self)

local apm_starfall_compat_bob = settings.startup["apm_starfall_compat_bob"].value
local apm_starfall_compat_angel = settings.startup["apm_starfall_compat_angel"].value
local apm_starfall_compat_earendel = settings.startup["apm_starfall_compat_earendel"].value
local apm_starfall_compat_reverse_factory = settings.startup["apm_starfall_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_starfall_compat_bob', apm_starfall_compat_bob)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_angel', apm_starfall_compat_angel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_earendel', apm_starfall_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_starfall_compat_reverse_factory', apm_starfall_compat_reverse_factory)

-- ----------------------------------------------------------------------------------------------------------
-- This block should make this mod more compatible with other by setting the basic fuel categories for burners
-- apm.lib.utils.entities.add.fuel_category_with_conditional(entity_type, conditional_category, category)
-- ----------------------------------------------------------------------------------------------------------
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
-- overwrite fuel categorys on all car if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('car', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('car', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all locomotive if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('locomotive', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('locomotive', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on all mining-drill if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('mining-drill', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('mining-drill', 'apm_refined_chemical', 'apm_starfall_alien')
-- overwrite fuel categorys on allpump if they hav a burner and uses 'checmical' as fuel category
apm.lib.utils.entities.add.fuel_category_with_conditional('pump', 'chemical', 'apm_starfall_alien')
apm.lib.utils.entities.add.fuel_category_with_conditional('pump', 'apm_refined_chemical', 'apm_starfall_alien')
--
APM_LOG_INFO(self, '', 'END: add alien fuel categories')

-- apm ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.apm_recycling then
    apm.lib.utils.recycling.scrap.add({recipe='apm_alien_fuel_case', metal='iron'})
end

-- Bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and apm_starfall_compat_bob then
    apm.lib.utils.recycling.scrap.add({recipe='apm_alien_fuel_case', metal='lead'})
end

-- Reverse Factory ------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods['reverse-factory'] and apm_starfall_compat_reverse_factory then

    local function exclude(recipe_name)
        if rf and rf.norecycle_items then  
            table.insert(rf.norecycle_items, recipe_name)
            log('Info: add recipe: "' ..tostring(recipe_name).. '" to rf.norecycle_items')
        end
    end

    exclude('apm_alien_fuel_burnted_maintenance')
    exclude('apm_metal_catalyst_frame_used_maintenance')
    exclude('apm_meteorite_copper_solution_centrifuging')
    exclude('apm_meteorite_iron_solution_centrifuging')
    exclude('apm_mixed_meteorite_slurry_centrifuging_1')
    exclude('apm_mixed_meteorite_slurry_centrifuging_2')
end