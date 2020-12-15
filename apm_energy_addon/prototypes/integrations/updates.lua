require ('util')
require('__apm_lib__.lib.log')

local self = 'apm_energy_addon/prototypes/integrations/updates.lua'

APM_LOG_HEADER(self)

local apm_energy_addon_compat_bob = settings.startup["apm_energy_addon_compat_bob"].value
local apm_energy_addon_compat_earendel = settings.startup["apm_energy_addon_compat_earendel"].value
local apm_energy_addon_compat_reverse_factory = settings.startup["apm_energy_addon_compat_reverse_factory"].value

APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_bob', apm_energy_addon_compat_bob)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_earendel', apm_energy_addon_compat_earendel)
APM_LOG_SETTINGS(self, 'apm_energy_addon_compat_reverse_factory', apm_energy_addon_compat_reverse_factory)

-- Reverse Factory ------------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------------------
if mods['reverse-factory'] and apm_energy_addon_compat_reverse_factory then

    local function exclude(recipe_name)
        if rf and rf.norecycle_items then  
            table.insert(rf.norecycle_items, recipe_name)
            log('Info: add recipe: "' ..tostring(recipe_name).. '" to rf.norecycle_items')
        end
    end

    exclude('apm_charging_battery')

    if mods.apm_nuclear then
        exclude('apm_decayed_rtg_reprocessing')
    end

    if mods.bobplates and apm_energy_addon_compat_bob then
        exclude('apm_charging_lithium-ion-battery')
        exclude('apm_charging_silver-zinc-battery')
    end
end
