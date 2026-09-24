-- Tips and tricks of apm_nuclear (category "apm" and "apm-introduction" come from apm_lib).
-- Added in data-final-fixes through apm.lib.utils.tips.add, which skips a tip whose
-- prototypes an integration or a setting has removed.

local tips = apm.lib.utils.tips

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-nuclear-fuel-rods",
	category = "apm",
	order = "n-a",
	indent = 1,
	tag = "[item=apm_fuel_rod_uranium]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_fuel_rod_uranium"),
}, { recipe = { "apm_fuel_rod_uranium" }, item = { "apm_fuel_rod_uranium_active", "apm_fuel_rod_container_worn" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-nuclear-cooling",
	category = "apm",
	order = "n-b",
	indent = 1,
	tag = "[entity=apm_cooling_pond_0][entity=apm_hybrid_cooling_tower_0]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_cooling_pond_0"),
}, { recipe = { "apm_cooling_pond_0", "apm_hybrid_cooling_tower_0" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-nuclear-breeder",
	category = "apm",
	order = "n-c",
	indent = 1,
	tag = "[entity=apm_nuclear_breeder]",
	dependencies = { "apm-nuclear-fuel-rods" },
	trigger = tips.unlock_trigger("apm_nuclear_breeder"),
}, { recipe = { "apm_nuclear_breeder" }, item = { "apm_breeder_uranium_loaded" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-nuclear-radioactive-items",
	category = "apm",
	order = "n-d",
	indent = 1,
	tag = "[item=apm_oxide_pellet_pu239]",
	dependencies = { "apm-radiation" },
	trigger = tips.unlock_trigger("apm_fuel_rod_uranium"),
}, { recipe = { "apm_fuel_rod_uranium" } })

-- Nuclear vehicles exist only with some integrations (apm.nuclear.nuclear_vehicle).
for _, vehicle_type in pairs({ "car", "locomotive" }) do
	for name, vehicle in pairs(data.raw[vehicle_type] or {}) do
		local description = vehicle.localised_description

		if type(description) == "table" and description[1] == "entity-description.apm_nuclear_vehicle" then
			tips.add({
				type = "tips-and-tricks-item",
				name = "apm-nuclear-vehicles",
				category = "apm",
				order = "n-e",
				indent = 1,
				tag = "[entity=" .. name .. "]",
				dependencies = { "apm-nuclear-fuel-rods" },
				trigger = { type = "enter-vehicle", vehicle = name },
			})

			return
		end
	end
end
