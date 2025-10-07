require("__apm_lib_ldinc__.lib.features")
require("lib.features.compat")
require("__apm_lib_ldinc__.lib.utils.patch.item")
require("__apm_lib_ldinc__.lib.utils.patch.entity")

return function()
	local item_stack = { name = "solid-fuel", count = 50 }

	for _, surface in pairs(game.surfaces) do
		local hidden_steam_entities = surface.find_entities_filtered { name = "RRR-cooling-tower-steam" }

		for _, entity in pairs(hidden_steam_entities) do
			local inventory = entity.get_fuel_inventory()

			if inventory and inventory.can_insert(item_stack) then
				inventory.insert(item_stack)
			end
		end
	end
end
