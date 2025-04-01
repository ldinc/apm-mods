-- if apm == nil then apm = {} end
-- if not apm.lib then apm.lib = {} end

-- require("__apm_lib_ldinc__.lib.utils")

local updates = {
	handlers = {},
}

--- [SafTheLamb]
---

--- [crushing-industry]
if script.active_mods["crushing-industry"] then
	updates.handlers["crushing-industry"] = require("patches.crushing-industry")
end

--- [alloy-smelting]
if script.active_mods["alloy-smelting"] then
	updates.handlers["alloy-smelting"] = require("patches.alloy-smelting")
end

---
--- [/SafTheLamb]


-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
local function realistic_reactors()
	if not settings.startup['apm_power_compat_realistic_reactors'].value then return end
	if not script.active_mods['RealisticReactors'] then return end

	log('---------------------------------------------')
	log('Running update script for "RealisticReactors"')

	local item_stack = { name = 'solid-fuel', count = 50 }

	for _, surface in pairs(game.surfaces) do
		local hidden_steam_entities = surface.find_entities_filtered { name = 'rr-cooling-tower-steam' }
		for _, entity in pairs(hidden_steam_entities) do
			local inventory = entity.get_fuel_inventory()
			if inventory.can_insert(item_stack) then
				inventory.insert({ name = "solid-fuel", count = 50 })
				log('insert fuel at position: x=' ..
					tostring(entity.position.x) ..
					' y=' .. tostring(entity.position.y) .. ' at surface: ' .. tostring(surface.name))
			end
		end
	end

	log('---------------------------------------------')
end

-- Function -------------------------------------------------------------------
--
--
-- ----------------------------------------------------------------------------
function updates.run()
	if updates.handlers then
		for _, handler in pairs(updates.handlers) do
			handler()
		end
	end

	realistic_reactors()
end

-- ----------------------------------------------------------------------------
-- ----------------------------------------------------------------------------

return updates
