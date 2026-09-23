require("util")
require("__apm_lib_ldinc__.lib.log")

local self = "apm_energy_addon/prototypes/integrations/bobs/vehicles.lua"

APM_LOG_HEADER(self)

-- Runs in data-updates: Bob's mods switch their vehicles to burner energy and add their
-- equipment grids in their own data-updates, which run before this one (optional dependencies).
local apm_energy_addon_compat_bob = settings.startup["apm_energy_addon_compat_bob"].value

if mods.boblogistics and apm_energy_addon_compat_bob then
	apm.energy_addon.generate_electric_powered_locomotive("bob-locomotive-2")
	apm.energy_addon.generate_electric_powered_locomotive("bob-locomotive-3")
	apm.energy_addon.generate_electric_powered_locomotive("bob-armoured-locomotive")
	apm.energy_addon.generate_electric_powered_locomotive("bob-armoured-locomotive-2")

	apm.energy_addon.generate_electric_locomotive_new_recipe("bob-locomotive-2")
	apm.energy_addon.generate_electric_locomotive_new_tech("bob-locomotive-2", "bob-railway-2")
	apm.energy_addon.generate_electric_locomotive_new_recipe("bob-locomotive-3")
	apm.energy_addon.generate_electric_locomotive_new_tech("bob-locomotive-3", "bob-railway-3")
	apm.energy_addon.generate_electric_locomotive_new_recipe("bob-armoured-locomotive")
	apm.energy_addon.generate_electric_locomotive_new_tech("bob-armoured-locomotive", "bob-armoured-railway")
	apm.energy_addon.generate_electric_locomotive_new_recipe("bob-armoured-locomotive-2")
	apm.energy_addon.generate_electric_locomotive_new_tech("bob-armoured-locomotive-2", "bob-armoured-railway-2")
end

if mods.bobwarfare and apm_energy_addon_compat_bob then
	---@diagnostic disable-next-line: different-requires
	local bobwarfare = require("prototypes.integrations.bobs.bobwarfare")

	bobwarfare.generate()
end
