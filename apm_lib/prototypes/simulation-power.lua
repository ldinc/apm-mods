-- A hidden power source for the tips-and-tricks simulations of the APM mods. The vanilla
-- electric-energy-interface has "dynamic" priority; this one is a plain primary output with a
-- fixed production that the simulation scripts can change (power_production).

local eei = table.deepcopy(data.raw["electric-energy-interface"]["electric-energy-interface"])

eei.name = "apm_simulation_power"
eei.energy_source = {
	type = "electric",
	usage_priority = "primary-output",
	buffer_capacity = "10MJ",
	input_flow_limit = "0W",
	output_flow_limit = "100MW",
}
eei.energy_production = "2MW"
eei.energy_usage = "0W"
eei.minable = nil
eei.hidden = true
eei.hidden_in_factoriopedia = true

data:extend({ eei })
