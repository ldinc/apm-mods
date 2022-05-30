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

-- apm ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.apm_recycling then
    apm.lib.utils.recipe.category.change('apm_alien_fuel_burnted_maintenance', 'apm_recycling_1')
end

-- Bob ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.bobplates and apm_starfall_compat_bob then
    apm.lib.utils.recipe.ingredient.mod('apm_alien_fuel_case', 'iron-plate', 3)
    apm.lib.utils.recipe.ingredient.mod('apm_alien_fuel_case', 'lead-plate', 2)
end

-- Angel ----------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
if mods.angelsrefining and apm_starfall_compat_angel then
    apm.lib.utils.recipe.ingredient.mod('apm_dissolved_meteorite_slurry_desulfurize', apm.lib.utils.builder.recipe.item.name('APM_WATER'), 90)
    --apm.lib.utils.recipe.category.change('apm_dissolved_meteorite_slurry_desulfurize', 'water-treatment')
end