-- Tips and tricks of apm_energy_addon (category "apm" and "apm-introduction" come from apm_lib).
-- Added in data-final-fixes through apm.lib.utils.tips.add, which skips a tip whose
-- prototypes an integration or a setting has removed.

local tips = apm.lib.utils.tips

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-batteries-as-fuel",
	category = "apm",
	order = "e-a",
	indent = 1,
	tag = "[item=battery][item=apm_discharged_battery]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_electric_car"),
	simulation = tips.simulation("__apm_energy_addon_ldinc__/simulations/electric-car.lua"),
}, { recipe = { "apm_electric_car" }, item = { "battery", "apm_discharged_battery" }, car = { "apm_electric_car" } })

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-charging-stations",
	category = "apm",
	order = "e-b",
	indent = 1,
	tag = "[entity=apm_battery_charging_station][entity=apm_battery_discharging_station]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_battery_charging_station"),
	simulation = tips.simulation("__apm_energy_addon_ldinc__/simulations/charging.lua"),
}, {
	recipe = { "apm_battery_charging_station", "apm_charging_battery" },
	["assembling-machine"] = { "apm_battery_charging_station" },
	["burner-generator"] = { "apm_battery_discharging_station" },
	["electric-energy-interface"] = { "apm_simulation_power" },
})

tips.add({
	type = "tips-and-tricks-item",
	name = "apm-energy-transmitter",
	category = "apm",
	order = "e-c",
	indent = 1,
	tag = "[item=apm_equipment_energy_transmitter]",
	dependencies = { "apm-introduction" },
	trigger = tips.unlock_trigger("apm_equipment_energy_transmitter"),
}, { recipe = { "apm_equipment_energy_transmitter" } })
